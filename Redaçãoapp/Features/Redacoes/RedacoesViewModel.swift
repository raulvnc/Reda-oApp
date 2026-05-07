import Foundation
import SwiftUI
import Combine

@MainActor
class RedacoesViewModel: ObservableObject {
    @Published var redacoes: [Redacao] = []
    @Published var isLoading = false
    @Published var ordenacao: Ordenacao = .notaDesc
    
    enum Ordenacao: String, CaseIterable {
        case notaDesc = "Nota (maior-menor)"
        case notaAsc = "Nota (menor-maior)"
        case dataRecente = "Data (mais recente)"
        case dataAntiga = "Data (mais antiga)"
    }
    
    init() {
        carregarRedacoes()
    }
    
    func carregarRedacoes() {
        // TODO: substituir por chamada de API real
        // Por enquanto, usa os exemplos
        redacoes = Redacao.exemplos
        ordenar()
    }
    
    func ordenar() {
        switch ordenacao {
        case .notaDesc:
            redacoes.sort { $0.notaTotal > $1.notaTotal }
        case .notaAsc:
            redacoes.sort { $0.notaTotal < $1.notaTotal }
        case .dataRecente:
            redacoes.sort { $0.createdAt > $1.createdAt }
        case .dataAntiga:
            redacoes.sort { $0.createdAt < $1.createdAt }
        }
    }
    
    func adicionarRedacao(_ redacao: Redacao) {
        redacoes.insert(redacao, at: 0)
    }
    
    // Computed properties para os badges
    var notaMaxima: Int {
        redacoes.map(\.notaTotal).max() ?? 0
    }
    
    var notaMedia: Int {
        guard !redacoes.isEmpty else { return 0 }
        return redacoes.map(\.notaTotal).reduce(0, +) / redacoes.count
    }
    
    // Para o gráfico
    var pontosGrafico: [(data: Date, nota: Int)] {
        redacoes
            .sorted { $0.createdAt < $1.createdAt }
            .map { ($0.createdAt, $0.notaTotal) }
    }
}
