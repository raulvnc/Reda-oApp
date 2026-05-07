import Foundation

struct Redacao: Identifiable, Codable {
    let id: UUID
    let titulo: String
    let texto: String
    let temaId: UUID?
    let temaTitulo: String?
    let notaTotal: Int
    let notaC1: Int
    let notaC2: Int
    let notaC3: Int
    let notaC4: Int
    let notaC5: Int
    let feedbackGeral: String?
    let pontosFortes: [String]
    let sugestoesMelhoria: [String]
    let createdAt: Date
    
    init(
        id: UUID = UUID(),
        titulo: String,
        texto: String,
        temaId: UUID? = nil,
        temaTitulo: String? = nil,
        notaTotal: Int = 0,
        notaC1: Int = 0,
        notaC2: Int = 0,
        notaC3: Int = 0,
        notaC4: Int = 0,
        notaC5: Int = 0,
        feedbackGeral: String? = nil,
        pontosFortes: [String] = [],
        sugestoesMelhoria: [String] = [],
        createdAt: Date = Date()
    ) {
        self.id = id
        self.titulo = titulo
        self.texto = texto
        self.temaId = temaId
        self.temaTitulo = temaTitulo
        self.notaTotal = notaTotal
        self.notaC1 = notaC1
        self.notaC2 = notaC2
        self.notaC3 = notaC3
        self.notaC4 = notaC4
        self.notaC5 = notaC5
        self.feedbackGeral = feedbackGeral
        self.pontosFortes = pontosFortes
        self.sugestoesMelhoria = sugestoesMelhoria
        self.createdAt = createdAt
    }
}

// Dados de exemplo para preview/teste
extension Redacao {
    static let exemplos: [Redacao] = [
        Redacao(
            titulo: "Combate ao Etarismo",
            texto: "A sociedade contemporânea...",
            temaTitulo: "Combate ao Etarismo no Brasil",
            notaTotal: 880,
            notaC1: 200,
            notaC2: 160,
            notaC3: 180,
            notaC4: 160,
            notaC5: 180,
            createdAt: Calendar.current.date(byAdding: .day, value: -2, to: Date())!
        ),
        Redacao(
            titulo: "Desafio da Mobilidade Urbana",
            texto: "A mobilidade urbana...",
            temaTitulo: "Desafios da mobilidade urbana no Brasil",
            notaTotal: 960,
            notaC1: 180,
            notaC2: 200,
            notaC3: 200,
            notaC4: 200,
            notaC5: 180,
            createdAt: Calendar.current.date(byAdding: .day, value: -5, to: Date())!
        ),
        Redacao(
            titulo: "Publicidade Infantil",
            texto: "A publicidade infantil...",
            temaTitulo: "Publicidade infantil: responsabilidades",
            notaTotal: 840,
            notaC1: 160,
            notaC2: 160,
            notaC3: 160,
            notaC4: 180,
            notaC5: 180,
            createdAt: Calendar.current.date(byAdding: .day, value: -10, to: Date())!
        )
    ]
}
