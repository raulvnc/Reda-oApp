import SwiftUI

struct ContentView: View {
    enum Tab {
        case inicio
        case redacoes
        case temas
        case progresso
        case perfil
    }

    @State private var selectedTab: Tab = .inicio

    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack {
                InicioView()
            }
            .tabItem {
                Label("Início", systemImage: "house")
            }
            .tag(Tab.inicio)

            NavigationStack {
                RedacoesView()
            }
            .tabItem {
                Label("Redações", systemImage: "doc.text")
            }
            .tag(Tab.redacoes)

            NavigationStack {
                PlaceholderTabView(title: "Temas")
            }
            .tabItem {
                Label("Temas", systemImage: "book")
            }
            .tag(Tab.temas)

            NavigationStack {
                PlaceholderTabView(title: "Progresso")
            }
            .tabItem {
                Label("Progresso", systemImage: "chart.bar")
            }
            .tag(Tab.progresso)

            NavigationStack {
                PlaceholderTabView(title: "Perfil")
            }
            .tabItem {
                Label("Perfil", systemImage: "person")
            }
            .tag(Tab.perfil)
        }
    }
}

private struct PlaceholderTabView: View {
    let title: String

    var body: some View {
        VStack(spacing: 12) {
            Text(title)
                .font(.title2.bold())
            Text("Tela em construção")
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.backgroundLight)
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthManager())
}
