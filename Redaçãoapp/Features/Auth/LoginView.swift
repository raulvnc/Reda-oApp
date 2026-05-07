import SwiftUI

struct LoginView: View {
    @EnvironmentObject private var authManager: AuthManager

    @State private var isCadastro = false
    @State private var nome = ""
    @State private var email = ""
    @State private var senha = ""
    @State private var confirmarSenha = ""
    @State private var showPassword = false
    @State private var showConfirmPassword = false
    @State private var acceptedTerms = false

    var body: some View {
        ZStack {
            Color(red: 0.95, green: 0.96, blue: 0.99)
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 0) {
                    Spacer().frame(height: 32)

                    if isCadastro {
                        cadastroCard
                    } else {
                        loginCard
                    }

                    Spacer().frame(height: 32)
                }
                .padding(.horizontal, 20)
            }
        }
        .animation(.easeInOut(duration: 0.2), value: isCadastro)
    }

    private var loginCard: some View {
        VStack(spacing: 18) {
            iconHeader(title: "Bem-vindo de volta", subtitle: "Acesse sua conta para continuar evoluindo.")

            VStack(spacing: 12) {
                fieldLabel("E-mail")
                iconTextField(placeholder: "nome@exemplo.com", text: $email, icon: "envelope")

                fieldLabel("Senha")
                iconPasswordField(
                    placeholder: "••••••••",
                    text: $senha,
                    show: $showPassword
                )

                HStack {
                    Spacer()
                    Button("Esqueci minha senha") {}
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundStyle(Color(red: 0.20, green: 0.45, blue: 0.74))
                }
            }

            submitButton(title: "Entrar") {
                Task {
                    await authManager.signInWithEmail(email: email, password: senha)
                }
            }
            .disabled(email.isEmpty || senha.isEmpty || authManager.isLoading)
            .opacity(email.isEmpty || senha.isEmpty ? 0.6 : 1)

            dividerText("OU CONTINUE COM")

            VStack(spacing: 10) {
                socialButton(title: "Google", icon: "g.circle.fill", iconColor: Color(red: 0.91, green: 0.26, blue: 0.21))
                socialButton(title: "Apple", icon: "applelogo", iconColor: Color.black)
            }

            HStack(spacing: 4) {
                Text("Não tem uma conta?")
                    .foregroundStyle(Color(red: 0.45, green: 0.47, blue: 0.53))
                Button("Criar conta") {
                    isCadastro = true
                }
                .fontWeight(.semibold)
                .foregroundStyle(Color(red: 0.08, green: 0.12, blue: 0.21))
            }
            .font(.system(size: 15))

            errorText
        }
        .padding(24)
        .cardStyle()
    }

    private var cadastroCard: some View {
        VStack(spacing: 16) {
            HStack {
                Button {
                    isCadastro = false
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(Color(red: 0.20, green: 0.22, blue: 0.27))
                        .frame(width: 30, height: 30)
                }
                Spacer()
            }

            VStack(alignment: .leading, spacing: 4) {
                Text("Crie sua conta")
                    .font(.system(size: 34, weight: .black))
                    .foregroundStyle(Color(red: 0.10, green: 0.14, blue: 0.22))
                Text("Comece a melhorar suas redações hoje mesmo! Preencha os dados abaixo.")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(Color(red: 0.42, green: 0.45, blue: 0.51))
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            VStack(spacing: 12) {
                fieldLabel("Nome Completo")
                iconTextField(placeholder: "Digite seu nome completo", text: $nome, icon: "person")

                fieldLabel("E-mail")
                iconTextField(placeholder: "seu@email.com", text: $email, icon: "envelope")

                fieldLabel("Senha")
                iconPasswordField(placeholder: "Crie uma senha forte", text: $senha, show: $showPassword)

                fieldLabel("Confirmar Senha")
                iconPasswordField(placeholder: "Repita sua senha", text: $confirmarSenha, show: $showConfirmPassword)
            }

            Button {
                acceptedTerms.toggle()
            } label: {
                HStack(alignment: .top, spacing: 10) {
                    Image(systemName: acceptedTerms ? "checkmark.square.fill" : "square")
                        .foregroundStyle(acceptedTerms ? Color(red: 0.20, green: 0.45, blue: 0.74) : Color(red: 0.60, green: 0.62, blue: 0.68))
                    Text("Eu li e concordo com os Termos de Uso e a Política de Privacidade.")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundStyle(Color(red: 0.34, green: 0.38, blue: 0.45))
                        .multilineTextAlignment(.leading)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .buttonStyle(.plain)

            submitButton(title: "Cadastrar") {
                Task {
                    await authManager.register(
                        nome: nome,
                        email: email,
                        password: senha,
                        confirmPassword: confirmarSenha
                    )
                }
            }
            .disabled(!acceptedTerms || nome.isEmpty || email.isEmpty || senha.isEmpty || confirmarSenha.isEmpty || authManager.isLoading)
            .opacity(!acceptedTerms || nome.isEmpty || email.isEmpty || senha.isEmpty || confirmarSenha.isEmpty ? 0.6 : 1)

            HStack(spacing: 4) {
                Text("Já tem uma conta?")
                    .foregroundStyle(Color(red: 0.45, green: 0.47, blue: 0.53))
                Button("Entrar") {
                    isCadastro = false
                }
                .fontWeight(.semibold)
                .foregroundStyle(Color(red: 0.20, green: 0.45, blue: 0.74))
            }
            .font(.system(size: 15))

            errorText
        }
        .padding(24)
        .cardStyle()
    }

    private var errorText: some View {
        Group {
            if let error = authManager.errorMessage {
                Text(error)
                    .font(.system(size: 13))
                    .foregroundStyle(.red)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
            }
        }
    }

    private func iconHeader(title: String, subtitle: String) -> some View {
        VStack(spacing: 12) {
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(Color(red: 0.90, green: 0.95, blue: 1.0))
                .frame(width: 58, height: 58)
                .overlay {
                    Image(systemName: "doc.text")
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundStyle(Color(red: 0.20, green: 0.45, blue: 0.74))
                }

            Text(title)
                .font(.system(size: 30, weight: .bold))
                .foregroundStyle(Color(red: 0.10, green: 0.14, blue: 0.22))

            Text(subtitle)
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(Color(red: 0.42, green: 0.45, blue: 0.51))
                .multilineTextAlignment(.center)
        }
    }

    private func fieldLabel(_ text: String) -> some View {
        Text(text)
            .font(.system(size: 14, weight: .semibold))
            .foregroundStyle(Color(red: 0.20, green: 0.22, blue: 0.27))
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    private func iconTextField(placeholder: String, text: Binding<String>, icon: String) -> some View {
        HStack(spacing: 10) {
            Image(systemName: icon)
                .foregroundStyle(Color(red: 0.55, green: 0.57, blue: 0.63))
                .frame(width: 18)
            TextField(placeholder, text: text)
        }
        .inputStyle()
    }

    private func iconPasswordField(placeholder: String, text: Binding<String>, show: Binding<Bool>) -> some View {
        HStack(spacing: 10) {
            Image(systemName: "lock")
                .foregroundStyle(Color(red: 0.55, green: 0.57, blue: 0.63))
                .frame(width: 18)

            Group {
                if show.wrappedValue {
                    TextField(placeholder, text: text)
                } else {
                    SecureField(placeholder, text: text)
                }
            }

            Button {
                show.wrappedValue.toggle()
            } label: {
                Image(systemName: show.wrappedValue ? "eye.slash" : "eye")
                    .foregroundStyle(Color(red: 0.55, green: 0.57, blue: 0.63))
            }
            .buttonStyle(.plain)
        }
        .inputStyle()
    }

    private func submitButton(title: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Group {
                if authManager.isLoading {
                    ProgressView().tint(.white)
                } else {
                    Text(title)
                        .font(.system(size: 16, weight: .semibold))
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 48)
            .foregroundStyle(.white)
        }
        .background(Color(red: 0.06, green: 0.11, blue: 0.22))
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    }

    private func socialButton(title: String, icon: String, iconColor: Color) -> some View {
        Button {} label: {
            HStack(spacing: 10) {
                Image(systemName: icon)
                    .foregroundStyle(iconColor)
                Text(title)
                    .foregroundStyle(Color(red: 0.16, green: 0.18, blue: 0.24))
                    .font(.system(size: 15, weight: .medium))
            }
            .frame(maxWidth: .infinity)
            .frame(height: 44)
            .background(Color.white)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(red: 0.80, green: 0.81, blue: 0.85), lineWidth: 1)
            }
        }
        .buttonStyle(.plain)
    }

    private func dividerText(_ text: String) -> some View {
        HStack(spacing: 10) {
            Rectangle().fill(Color(red: 0.84, green: 0.85, blue: 0.89)).frame(height: 1)
            Text(text)
                .font(.system(size: 11, weight: .semibold))
                .tracking(1)
                .foregroundStyle(Color(red: 0.55, green: 0.57, blue: 0.63))
            Rectangle().fill(Color(red: 0.84, green: 0.85, blue: 0.89)).frame(height: 1)
        }
    }
}

private struct CardStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .shadow(color: Color.black.opacity(0.06), radius: 12, x: 0, y: 4)
            .overlay {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .stroke(Color(red: 0.89, green: 0.90, blue: 0.93), lineWidth: 1)
            }
    }
}

private extension View {
    func cardStyle() -> some View {
        modifier(CardStyle())
    }

    func inputStyle() -> some View {
        self
            .padding(.horizontal, 14)
            .padding(.vertical, 13)
            .background(Color.white)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(red: 0.80, green: 0.81, blue: 0.85), lineWidth: 1)
            }
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}

#Preview {
    LoginView()
        .environmentObject(AuthManager())
}
