import Foundation

struct User: Identifiable, Codable {
    let id: UUID
    var nome: String
    var email: String
    var avatarUrl: String?
    var metaNota: Int
    var metaSemanal: Int
    var plano: String
    
    enum CodingKeys: String, CodingKey {
        case id, nome, email
        case avatarUrl = "avatar_url"
        case metaNota = "meta_nota"
        case metaSemanal = "meta_semanal"
        case plano
    }
    
    init(id: UUID, nome: String, email: String, avatarUrl: String? = nil,
         metaNota: Int = 900, metaSemanal: Int = 2, plano: String = "free") {
        self.id = id
        self.nome = nome
        self.email = email
        self.avatarUrl = avatarUrl
        self.metaNota = metaNota
        self.metaSemanal = metaSemanal
        self.plano = plano
    }
}
