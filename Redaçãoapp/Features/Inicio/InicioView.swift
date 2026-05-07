import SwiftUI

struct InicioView: View {
    @EnvironmentObject private var authManager: AuthManager

    private let redacoesSemanais = 1
    private let metaSemanal = 2

    var body: some View {
        ZStack {
            Color.backgroundLight
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Olá, \(firstName)")
                        .font(.system(size: 48, weight: .bold))
                        .foregroundStyle(Color.textPrimary)

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Meta Semanal:")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundStyle(Color.textPrimary)

                        progressBar
                    }

                    metaNotaCard

                    HStack(spacing: 14) {
                        AtalhoCard(icon: "doc.text", titulo: "Enviar\nRedação", backgroundColor: Color(hex: "DBEAFE"), iconColor: Color(hex: "2563EB"))
                        AtalhoCard(icon: "shuffle", titulo: "Sortear\nTema", backgroundColor: Color(hex: "D1FAE5"), iconColor: Color(hex: "10B981"))
                        AtalhoCard(icon: "chart.line.uptrend.xyaxis", titulo: "Ver\nProgresso", backgroundColor: Color(hex: "FEF3C7"), iconColor: Color(hex: "D97706"))
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Últimas Redações")
                            .font(.system(size: 42, weight: .bold))
                            .foregroundStyle(Color.textPrimary)

                        RedacaoMiniCard(titulo: "Democratização do acesso ao cinema", nota: 840)
                    }

                    Spacer(minLength: 100)
                }
                .padding(.horizontal, 18)
                .padding(.top, 18)
                .padding(.bottom, 20)
            }
        }
    }

    private var firstName: String {
        authManager.currentUser?.nome.split(separator: " ").first.map(String.init) ?? "Raul"
    }

    private var progressBar: some View {
        GeometryReader { proxy in
            let progress = min(CGFloat(redacoesSemanais) / CGFloat(metaSemanal), 1)
            let width = proxy.size.width * progress

            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 14)
                    .fill(Color(hex: "E5E7EB"))

                RoundedRectangle(cornerRadius: 14)
                    .fill(Color(hex: "3B82F6"))
                    .frame(width: width)

                Text("\(redacoesSemanais)/\(metaSemanal) concluídas")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(Color(hex: "4B5563"))
                    .padding(.leading, 12)
            }
        }
        .frame(height: 40)
    }

    private var metaNotaCard: some View {
        HStack(spacing: 14) {
            ZStack {
                RoundedRectangle(cornerRadius: 14)
                    .fill(Color(hex: "FDE68A"))
                    .frame(width: 56, height: 56)

                Image(systemName: "trophy")
                    .font(.system(size: 26, weight: .semibold))
                    .foregroundStyle(Color(hex: "B45309"))
            }

            VStack(alignment: .leading, spacing: 3) {
                Text("Meta de Nota")
                    .font(.system(size: 21, weight: .bold))
                    .foregroundStyle(Color.textPrimary)
                Text("Alvo: 900")
                    .font(.system(size: 16))
                    .foregroundStyle(Color.textSecondary)
                Text("Média Últimas 10: 840")
                    .font(.system(size: 16))
                    .foregroundStyle(Color.textSecondary)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(Color(hex: "9CA3AF"))
        }
        .padding(16)
        .background(Color(hex: "FDF2F2"))
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
    }

    private var bottomTabBar: some View {
        HStack {
            tabItem("house", "Início", true)
            tabItem("doc.text", "Redações", false)
            tabItem("book", "Temas", false)
            tabItem("chart.bar", "Progresso", false)
            tabItem("person", "Perfil", false)
        }
        .padding(.horizontal, 12)
        .padding(.top, 10)
        .padding(.bottom, 8)
        .background(Color.white)
        .overlay(alignment: .top) {
            Rectangle().fill(Color(hex: "E5E7EB")).frame(height: 1)
        }
    }

    private func tabItem(_ icon: String, _ title: String, _ active: Bool) -> some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
            Text(title)
                .font(.system(size: 12, weight: .semibold))
        }
        .frame(maxWidth: .infinity)
        .foregroundStyle(active ? Color(hex: "3B82F6") : Color(hex: "6B7280"))
    }
}

struct AtalhoCard: View {
    let icon: String
    let titulo: String
    let backgroundColor: Color
    let iconColor: Color

    var body: some View {
        VStack(spacing: 10) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(backgroundColor)
                    .frame(width: 52, height: 52)
                Image(systemName: icon)
                    .font(.system(size: 24, weight: .medium))
                    .foregroundStyle(iconColor)
            }

            Text(titulo)
                .font(.system(size: 16, weight: .bold))
                .multilineTextAlignment(.center)
                .foregroundStyle(Color.textPrimary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}

struct RedacaoMiniCard: View {
    let titulo: String
    let nota: Int

    var body: some View {
        HStack {
            Text(titulo)
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(Color.textPrimary)
                .lineLimit(2)

            Spacer()

            HStack(spacing: 8) {
                Text("\(nota)")
                    .font(.system(size: 48, weight: .bold))
                    .foregroundStyle(Color.textPrimary)
                Image(systemName: "chevron.right")
                    .foregroundStyle(Color(hex: "9CA3AF"))
            }
        }
        .padding(18)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}

#Preview {
    InicioView()
        .environmentObject(AuthManager())
}
