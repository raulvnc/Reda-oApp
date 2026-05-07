# 📝 RedaçãoApp

> App iOS para correção de redações do ENEM usando Inteligência Artificial.

Aplicativo mobile que ajuda estudantes a treinarem redação para o ENEM com correção automática por IA, baseada nas 5 competências oficiais do exame.

---

## 🎯 Funcionalidades

### ✅ Implementadas
- 🔐 Autenticação completa (login, cadastro, Sign in with Apple)
- 💾 Persistência local de sessão e usuários
- 🏠 Dashboard com saudação personalizada
- 📊 Card de meta semanal com barra de progresso
- 🏆 Card de meta de nota (alvo + média das últimas 10)
- ⚡ Atalhos rápidos (Enviar Redação, Sortear Tema, Ver Progresso)
- 📱 Tab bar com navegação entre 5 áreas

### 🚧 Em desenvolvimento
- ✍️ Editor de redação com contador de palavras
- 🤖 Correção automática por IA (5 competências do ENEM)
- 📚 Biblioteca de temas com filtros e sorteio
- 📈 Gráficos de evolução (Swift Charts)
- 📊 Tela de progresso detalhado
- 👤 Perfil com configurações

---

## 🛠 Stack Tecnológica

| Camada | Tecnologia |
|--------|------------|
| Linguagem | Swift 5.9 |
| Framework UI | SwiftUI |
| Mínimo iOS | iOS 17+ |
| IDE | Xcode 15+ |
| Autenticação | Sign in with Apple |
| Gráficos | Swift Charts |
| Networking | URLSession + async/await |
| Armazenamento | UserDefaults (atual) → Keychain + Backend (futuro) |

### Backend (planejado)
- Node.js + Express **ou** Python + FastAPI
- PostgreSQL
- OpenAI GPT-4o ou Anthropic Claude para correção
- Hospedagem: Railway / Render

---

## 📁 Estrutura do projeto
Redaçãoapp/
├── App/
│   └── RedacaoAppApp.swift
├── Core/
│   ├── Network/
│   ├── Models/
│   └── Auth/
├── Features/
│   ├── Auth/
│   ├── Inicio/
│   ├── Redacoes/
│   ├── Temas/
│   ├── Progresso/
│   └── Perfil/
├── Shared/
│   ├── Components/
│   ├── Extensions/
│   └── Utilities/
└── Resources/
└── Assets.xcassets

---

## 🚀 Como rodar

### Pré-requisitos
- macOS 14+
- Xcode 15+
- Conta Apple Developer (para Sign in with Apple)

### Passos

```bash
# 1. Clone o repositório
git clone https://github.com/raulvnc/Reda-oApp.git

# 2. Entre na pasta
cd Reda-oApp

# 3. Abra no Xcode
open Redaçãoapp.xcodeproj
```

No Xcode:
1. Selecione um simulador (iPhone 15 Pro recomendado)
2. Pressione **Cmd + R** para rodar
3. Faça login com qualquer email/senha (autenticação mock por enquanto)

---

## 🎨 Design

O app segue um design clean com cores suaves baseadas em pastéis. As principais cores são:

- 🔵 Azul primário (`#2563EB`)
- 🟠 Laranja de destaque (`#F97316`)
- 🟢 Verde de sucesso (`#10B981`)
- ⚫ Texto principal (`#1F2937`)

---

## 🗺 Roadmap

- [x] Setup inicial e arquitetura
- [x] Sistema de autenticação
- [x] Tela de Início
- [ ] Editor de redação
- [ ] Integração com IA para correção
- [ ] Tela de Redações com histórico
- [ ] Biblioteca de temas
- [ ] Tela de Progresso
- [ ] Tela de Perfil
- [ ] Backend próprio
- [ ] Deploy na App Store

---

## 👨‍💻 Autor

**Raul Vila nova costa**
- GitHub: [@raulvnc](https://github.com/raulvnc)

---

> 🟡 **Status:** Em desenvolvimento ativo — MVP em construção