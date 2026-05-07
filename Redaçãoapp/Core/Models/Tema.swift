import Foundation

struct Tema: Identifiable, Codable {
    let id: UUID
    let titulo: String
    let enunciado: String
    let eixoTematico: String
    let anoOrigem: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case titulo
        case enunciado
        case eixoTematico = "eixo_tematico"
        case anoOrigem = "ano_origem"
    }
}
