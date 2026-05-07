import SwiftUI
import Charts

struct RedacoesView: View {
    @StateObject private var viewModel = RedacoesViewModel()
    @State private var showEditor = false
    @State private var showAdicionarManual = false
    
    var body: some View {
        ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Título
                    Text("Redações")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(Color(hex: "1F2937"))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, 12)
                    
                    // 2 botões grandes
                    HStack(spacing: 12) {
                        // Corrigir Redação Nova
                        Button {
                            showEditor = true
                        } label: {
                            VStack(spacing: 12) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color(hex: "FEE2E2"))
                                        .frame(width: 50, height: 50)
                                    
                                    Image(systemName: "calendar.badge.plus")
                                        .font(.system(size: 24))
                                        .foregroundColor(Color(hex: "F97316"))
                                }
                                
                                Text("Corrigir Redação\nNova")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(Color(hex: "1F2937"))
                                    .multilineTextAlignment(.center)
                                    .lineLimit(2)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 24)
                            .background(Color(hex: "FEF3E2"))
                            .cornerRadius(16)
                        }
                        
                        // Adicionar Já Corrigida
                        Button {
                            showAdicionarManual = true
                        } label: {
                            VStack(spacing: 12) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color(hex: "D1FAE5"))
                                        .frame(width: 50, height: 50)
                                    
                                    Image(systemName: "plus")
                                        .font(.system(size: 24, weight: .semibold))
                                        .foregroundColor(Color(hex: "10B981"))
                                }
                                
                                Text("Adicionar Redação\nJá Corrigida")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(Color(hex: "1F2937"))
                                    .multilineTextAlignment(.center)
                                    .lineLimit(2)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 24)
                            .background(Color(hex: "D1FAE5").opacity(0.3))
                            .cornerRadius(16)
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    // Card Nota Geral com gráfico
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text("Nota Geral")
                                .font(.system(size: 22, weight: .bold))
                                .foregroundColor(Color(hex: "1F2937"))
                            
                            Spacer()
                        }
                        
                        // Tags de filtro
                        HStack(spacing: 8) {
                            TagBadge(text: "1 Máx", color: Color(hex: "FEF3C7"), textColor: Color(hex: "B45309"))
                            TagBadge(text: "2 Méd", color: Color(hex: "FEE2E2"), textColor: Color(hex: "B91C1C"))
                            TagBadge(text: "Reenviar", color: Color(hex: "FED7AA"), textColor: Color(hex: "C2410C"))
                        }
                        
                        // Gráfico
                        if !viewModel.pontosGrafico.isEmpty {
                            grafico
                                .frame(height: 200)
                        } else {
                            Text("Sem dados ainda")
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity)
                                .frame(height: 200)
                        }
                    }
                    .padding(20)
                    .background(Color.white)
                    .cornerRadius(16)
                    .shadow(color: Color.black.opacity(0.04), radius: 8, y: 2)
                    .padding(.horizontal, 20)
                    
                    // Redações Antigas
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Redações Antigas")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(Color(hex: "1F2937"))
                            .padding(.horizontal, 20)
                        
                        // Dropdown de ordenação
                        Menu {
                            ForEach(RedacoesViewModel.Ordenacao.allCases, id: \.self) { opcao in
                                Button {
                                    viewModel.ordenacao = opcao
                                    viewModel.ordenar()
                                } label: {
                                    Text(opcao.rawValue)
                                }
                            }
                        } label: {
                            HStack {
                                Text("Ordenar por: ")
                                    .foregroundColor(Color(hex: "6B7280"))
                                Text(viewModel.ordenacao.rawValue)
                                    .foregroundColor(Color(hex: "1F2937"))
                                    .fontWeight(.semibold)
                                Spacer()
                                Image(systemName: "chevron.down")
                                    .foregroundColor(Color(hex: "6B7280"))
                            }
                            .font(.system(size: 14))
                            .padding(16)
                            .background(Color.white)
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color(hex: "E5E7EB"), lineWidth: 1)
                            )
                        }
                        .padding(.horizontal, 20)
                        
                        // Lista de redações
                        VStack(spacing: 12) {
                            ForEach(viewModel.redacoes) { redacao in
                                RedacaoCard(redacao: redacao)
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                    
                    Spacer(minLength: 100)
                }
                .padding(.bottom, 20)
            }
            .background(Color(hex: "F9FAFB"))
            .sheet(isPresented: $showEditor) {
                EditorRedacaoView()
            }
    }
    
    // Gráfico de barras + linha
    private var grafico: some View {
        Chart {
            ForEach(Array(viewModel.pontosGrafico.enumerated()), id: \.offset) { index, ponto in
                BarMark(
                    x: .value("Data", index),
                    y: .value("Nota", ponto.nota)
                )
                .foregroundStyle(Color(hex: "FCD34D"))
                .cornerRadius(4)
                
                LineMark(
                    x: .value("Data", index),
                    y: .value("Nota", ponto.nota)
                )
                .foregroundStyle(Color(hex: "F472B6"))
                .lineStyle(StrokeStyle(lineWidth: 2.5))
                .symbol {
                    Circle()
                        .fill(Color(hex: "F472B6"))
                        .frame(width: 8, height: 8)
                }
            }
        }
        .chartXAxis(.hidden)
        .chartYAxis {
            AxisMarks(position: .leading) { _ in
                AxisGridLine()
                    .foregroundStyle(Color(hex: "F3F4F6"))
            }
        }
    }
}

// MARK: - Componentes

struct TagBadge: View {
    let text: String
    let color: Color
    let textColor: Color
    
    var body: some View {
        Text(text)
            .font(.system(size: 12, weight: .semibold))
            .foregroundColor(textColor)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(color)
            .cornerRadius(20)
    }
}

struct RedacaoCard: View {
    let redacao: Redacao
    
    private var dataFormatada: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: redacao.createdAt)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(redacao.titulo)
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(Color(hex: "1F2937"))
                        .lineLimit(2)
                    
                    Text(dataFormatada)
                        .font(.system(size: 14))
                        .foregroundColor(Color(hex: "6B7280"))
                }
                
                Spacer()
                
                Text("\(redacao.notaTotal)")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(Color(hex: "1F2937"))
            }
            
            // Chips das competências
            FlowLayout(spacing: 6) {
                CompetenciaChip(num: 1, valor: redacao.notaC1, color: Color(hex: "DBEAFE"), textColor: Color(hex: "1E40AF"))
                CompetenciaChip(num: 2, valor: redacao.notaC2, color: Color(hex: "D1FAE5"), textColor: Color(hex: "065F46"))
                CompetenciaChip(num: 3, valor: redacao.notaC3, color: Color(hex: "EDE9FE"), textColor: Color(hex: "5B21B6"))
                CompetenciaChip(num: 4, valor: redacao.notaC4, color: Color(hex: "FED7AA"), textColor: Color(hex: "9A3412"))
                CompetenciaChip(num: 5, valor: redacao.notaC5, color: Color(hex: "FCE7F3"), textColor: Color(hex: "9F1239"))
            }
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.04), radius: 8, y: 2)
    }
}

struct CompetenciaChip: View {
    let num: Int
    let valor: Int
    let color: Color
    let textColor: Color
    
    var body: some View {
        Text("C\(num)-\(valor)")
            .font(.system(size: 12, weight: .semibold))
            .foregroundColor(textColor)
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(color)
            .cornerRadius(12)
    }
}

// Layout que quebra automaticamente os chips
struct FlowLayout: Layout {
    var spacing: CGFloat = 8
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let result = layout(proposal: proposal, subviews: subviews)
        return result.size
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let result = layout(proposal: proposal, subviews: subviews)
        for (index, frame) in result.frames.enumerated() {
            subviews[index].place(at: CGPoint(x: frame.minX + bounds.minX, y: frame.minY + bounds.minY), proposal: ProposedViewSize(frame.size))
        }
    }
    
    private func layout(proposal: ProposedViewSize, subviews: Subviews) -> (size: CGSize, frames: [CGRect]) {
        let maxWidth = proposal.width ?? .infinity
        var frames: [CGRect] = []
        var x: CGFloat = 0
        var y: CGFloat = 0
        var rowHeight: CGFloat = 0
        var totalHeight: CGFloat = 0
        
        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            
            if x + size.width > maxWidth && x > 0 {
                x = 0
                y += rowHeight + spacing
                rowHeight = 0
            }
            
            frames.append(CGRect(x: x, y: y, width: size.width, height: size.height))
            x += size.width + spacing
            rowHeight = max(rowHeight, size.height)
            totalHeight = y + rowHeight
        }
        
        return (CGSize(width: maxWidth, height: totalHeight), frames)
    }
}

// Editor placeholder (vamos implementar amanhã)
struct EditorRedacaoView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Editor em construção")
                    .font(.title)
                Spacer()
            }
            .navigationTitle("Nova Redação")
            .toolbar {
                ToolbarItem {
                    Button("Fechar") { dismiss() }
                }
            }
        }
    }
}

#Preview {
    RedacoesView()
}
