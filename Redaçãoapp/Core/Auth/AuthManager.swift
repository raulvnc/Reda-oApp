import Foundation
import Combine

@MainActor
final class AuthManager: ObservableObject {
    @Published var isAuthenticated = false
    @Published var currentUser: User?
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let tokenKey = "auth_token"
    private let usersKey = "mock_users"
    private let currentUserKey = "current_user"

    init() {
        checkAuthStatus()
    }

    func checkAuthStatus() {
        let hasToken = UserDefaults.standard.string(forKey: tokenKey) != nil
        guard hasToken else {
            isAuthenticated = false
            currentUser = nil
            return
        }

        if let data = UserDefaults.standard.data(forKey: currentUserKey),
           let user = try? JSONDecoder().decode(User.self, from: data) {
            currentUser = user
            isAuthenticated = true
        } else {
            signOut()
        }
    }

    func signInWithEmail(email: String, password: String) async {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }

        let normalizedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        guard !normalizedEmail.isEmpty, !password.isEmpty else {
            errorMessage = "Preencha e-mail e senha."
            return
        }

        let users = loadUsers()
        guard let storedUser = users.first(where: { $0.email == normalizedEmail }) else {
            errorMessage = "Usuário não encontrado."
            return
        }

        guard storedUser.password == password else {
            errorMessage = "Senha inválida."
            return
        }

        persistSession(user: storedUser.user)
    }

    func register(nome: String, email: String, password: String, confirmPassword: String) async {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }

        let cleanName = nome.trimmingCharacters(in: .whitespacesAndNewlines)
        let normalizedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()

        guard !cleanName.isEmpty else {
            errorMessage = "Informe seu nome."
            return
        }

        guard normalizedEmail.contains("@") else {
            errorMessage = "Informe um e-mail válido."
            return
        }

        guard password.count >= 6 else {
            errorMessage = "A senha deve ter pelo menos 6 caracteres."
            return
        }

        guard password == confirmPassword else {
            errorMessage = "As senhas não conferem."
            return
        }

        var users = loadUsers()
        if users.contains(where: { $0.email == normalizedEmail }) {
            errorMessage = "Já existe uma conta com esse e-mail."
            return
        }

        let newUser = User(id: UUID(), nome: cleanName, email: normalizedEmail)
        users.append(StoredUser(email: normalizedEmail, password: password, user: newUser))
        saveUsers(users)
        persistSession(user: newUser)
    }

    func signOut() {
        UserDefaults.standard.removeObject(forKey: tokenKey)
        UserDefaults.standard.removeObject(forKey: currentUserKey)
        isAuthenticated = false
        currentUser = nil
        errorMessage = nil
    }

    private func persistSession(user: User) {
        let token = "mock_jwt_\(UUID().uuidString)"
        UserDefaults.standard.set(token, forKey: tokenKey)
        if let data = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(data, forKey: currentUserKey)
        }
        currentUser = user
        isAuthenticated = true
    }

    private func loadUsers() -> [StoredUser] {
        guard let data = UserDefaults.standard.data(forKey: usersKey),
              let users = try? JSONDecoder().decode([StoredUser].self, from: data) else {
            return []
        }
        return users
    }

    private func saveUsers(_ users: [StoredUser]) {
        if let data = try? JSONEncoder().encode(users) {
            UserDefaults.standard.set(data, forKey: usersKey)
        }
    }
}

private struct StoredUser: Codable {
    let email: String
    let password: String
    let user: User
}
