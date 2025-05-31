# 🚀 Auto Commit Script

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Shell Script](https://img.shields.io/badge/Shell-Script-green.svg)](https://www.gnu.org/software/bash/)
[![Ubuntu](https://img.shields.io/badge/Ubuntu-Compatible-orange.svg)](https://ubuntu.com/)
[![Git](https://img.shields.io/badge/Git-Required-red.svg)](https://git-scm.com/)

Um script inteligente para automatizar a geração de mensagens de commit no Git, seguindo o padrão **Conventional Commits**. Analisa automaticamente suas mudanças e gera mensagens apropriadas, economizando tempo e mantendo consistência no histórico do projeto.

## ✨ Características

- 🧠 **Análise Inteligente**: Detecta tipos de arquivo e gera mensagens contextuais
- 📏 **Padrão Conventional Commits**: Segue convenções `tipo(escopo): descrição`
- 📊 **Estatísticas Visuais**: Mostra arquivos alterados e contagem de linhas
- ✅ **Confirmação Interativa**: Permite revisar antes de confirmar o commit
- 🎯 **Aliases do Git**: Comandos curtos para uso frequente
- 🌈 **Interface Colorida**: Output com cores para melhor legibilidade
- ⚡ **Modo Rápido**: Opção para commits automáticos sem confirmação

## 🛠️ Instalação

### Instalação Automática (Recomendada)

```bash
# Clone o repositório
git clone https://github.com/seu-usuario/auto-commit-script.git
cd auto-commit-script

# Execute o script de configuração
chmod +x setup-git-automation.sh
./setup-git-automation.sh
```

### Instalação Manual

1. **Baixe o script principal:**
```bash
wget https://raw.githubusercontent.com/seu-usuario/auto-commit-script/main/auto-commit.sh
chmod +x auto-commit.sh
```

2. **Configure aliases do Git (opcional):**
```bash
git config --global alias.ac '!bash auto-commit.sh'
git config --global alias.quick '!bash auto-commit.sh feat "" -y'
git config --global alias.fix '!bash auto-commit.sh fix'
git config --global alias.docs '!bash auto-commit.sh docs'
```

## 🚀 Uso

### Comandos Básicos

```bash
# Commit automático (tipo feat)
./auto-commit.sh

# Commit com tipo específico
./auto-commit.sh fix
./auto-commit.sh docs
./auto-commit.sh refactor

# Commit com escopo
./auto-commit.sh feat compilador
./auto-commit.sh fix parser

# Commit rápido sem confirmação
./auto-commit.sh feat "" -y
```

### Usando Aliases (após configuração)

```bash
git ac              # Auto commit interativo
git quick           # Commit rápido sem confirmação
git fix             # Commit de correção
git docs            # Commit de documentação
git refactor        # Commit de refatoração
git test            # Commit de testes
git chore           # Commit de manutenção
```

## 📋 Tipos de Commit Suportados

| Tipo | Descrição | Exemplo |
|------|-----------|---------|
| `feat` | Nova funcionalidade | `feat(auth): adiciona sistema de login` |
| `fix` | Correção de bug | `fix(parser): corrige análise de tokens` |
| `docs` | Documentação | `docs: atualiza README com instruções` |
| `style` | Formatação, lint | `style: corrige indentação do código` |
| `refactor` | Refatoração | `refactor(api): melhora estrutura dos endpoints` |
| `test` | Testes | `test: adiciona testes unitários para auth` |
| `chore` | Manutenção | `chore: atualiza dependências do projeto` |
| `perf` | Performance | `perf: otimiza consultas do banco de dados` |
| `ci` | CI/CD | `ci: adiciona workflow do GitHub Actions` |
| `build` | Build system | `build: configura webpack para produção` |

## 🤖 Análise Inteligente

O script analisa automaticamente os arquivos modificados e gera mensagens apropriadas:

### Detecção por Tipo de Arquivo

- **Arquivos Python (`.py`)**: "implementa funcionalidades Python" ou "adiciona/atualiza testes"
- **Documentação (`README`, `.md`)**: "atualiza documentação"
- **Configuração (`requirements`, `setup`, `.json`, `.yaml`)**: "atualiza configurações"
- **Scripts (`.sh`, `.bash`)**: "melhora scripts de automação"

### Análise Estatística

- Mais adições que remoções → "implementa nova funcionalidade"
- Mais remoções que adições → "remove código desnecessário"  
- Mudanças equilibradas → "refatora código existente"

## 📊 Exemplo de Saída

```bash
$ ./auto-commit.sh feat compilador

📁 Arquivos alterados:
  src/compilador.py
  src/analisador.py
  tests/test_compilador.py

📊 Mudanças: +127 -23

💬 Mensagem: feat(compilador): implementa funcionalidades Python

Confirmar commit? (Y/n): y
✅ Commit realizado!
```

## ⚙️ Configuração Avançada

### Template de Commit

O script configura automaticamente um template para mensagens de commit:

```bash
git config commit.template .gitmessage
```

### Hook Prepare-Commit-Msg

Adiciona estatísticas automaticamente nas mensagens de commit através de um Git hook.

### Personalização

Você pode modificar as configurações no início do script:

```bash
DEFAULT_TYPE="feat"           # Tipo padrão
MAX_SUBJECT_LENGTH=50        # Tamanho máximo da mensagem
```

## 🎯 Casos de Uso

### Desenvolvimento de Compiladores
```bash
./auto-commit.sh feat lexer     # Nova funcionalidade no analisador léxico
./auto-commit.sh fix parser     # Correção no parser
./auto-commit.sh test semantic  # Testes para análise semântica
```

### Projetos Python
```bash
./auto-commit.sh feat api       # Nova API
./auto-commit.sh refactor db    # Refatoração do banco
./auto-commit.sh docs readme    # Atualização de documentação
```

### Desenvolvimento Web
```bash
./auto-commit.sh feat ui        # Nova interface
./auto-commit.sh style css      # Ajustes de estilo
./auto-commit.sh fix responsive # Correção de responsividade
```

## 🔧 Requisitos

- **Sistema Operacional**: Ubuntu/Linux (testado no Ubuntu)
- **Git**: Versão 2.0 ou superior
- **Bash**: Versão 4.0 ou superior
- **Editor**: Compatível com vi/vim (opcional)

## 📝 Estrutura do Projeto

```
auto-commit-script/
├── auto-commit.sh              # Script principal
├── setup-git-automation.sh     # Script de configuração
├── .gitmessage                 # Template de commit
├── README.md                   # Esta documentação
├── LICENSE                     # Licença MIT
└── examples/
    ├── basic-usage.md          # Exemplos básicos
    └── advanced-config.md      # Configurações avançadas
```

## 🤝 Contribuindo

Contribuições são bem-vindas! Por favor:

1. **Fork** o projeto
2. **Crie** uma branch para sua feature (`git checkout -b feature/amazing-feature`)
3. **Commit** suas mudanças usando este script (`./auto-commit.sh feat amazing`)
4. **Push** para a branch (`git push origin feature/amazing-feature`)
5. **Abra** um Pull Request

### Diretrizes de Contribuição

- Mantenha o código legível e bem documentado
- Adicione testes para novas funcionalidades
- Siga o padrão Conventional Commits
- Atualize a documentação quando necessário

## 🐛 Relatando Bugs

Encontrou um bug? Por favor, abra uma [issue](https://github.com/seu-usuario/auto-commit-script/issues) com:

- **Descrição** do problema
- **Passos** para reproduzir
- **Comportamento esperado** vs **comportamento atual**
- **Ambiente** (SO, versão do Git, etc.)

## 📜 Licença

Este projeto está licenciado sob a Licença MIT - veja o arquivo [LICENSE](LICENSE) para detalhes.

## 🙏 Agradecimentos

- Inspirado no padrão [Conventional Commits](https://conventionalcommits.org/)
- Comunidade Git e desenvolvedores de ferramentas de versionamento
- Contribuidores do projeto

## 🔮 Roadmap

- [ ] Suporte para outros sistemas operacionais (macOS, Windows)
- [ ] Integração com editores de código (VS Code, Sublime)
- [ ] Configuração via arquivo JSON/YAML
- [ ] Plugin para vim/neovim
- [ ] Suporte a múltiplos idiomas nas mensagens
- [ ] Interface gráfica opcional (GUI)
- [ ] Integração com ferramentas de CI/CD

## 📞 Suporte

- **Issues**: [GitHub Issues](https://github.com/seu-usuario/auto-commit-script/issues)
- **Discussões**: [GitHub Discussions](https://github.com/seu-usuario/auto-commit-script/discussions)
- **Email**: not@exemplo.com

---

## 🤖 Gerado com IA

Este script foi desenvolvido com auxílio de **Inteligência Artificial** (Claude - Anthropic).

### Prompt Utilizado

```
Estou utilizando o sistema operacional Ubuntu, editor de texto vi e git para versionamento de software. Quero automatizar a geração das mensagens do commit, algo que identifique o que foi alterado e gere para mim a mensagem adequada para o commit. Como eu posso fazer isso?
```

A IA analisou os requisitos e gerou uma solução completa incluindo:
- Script principal para análise automática de mudanças
- Sistema de detecção de padrões em arquivos
- Configuração de aliases do Git
- Hooks personalizados
- Interface colorida e interativa
- Conformidade com padrões de commit convencionais

O resultado foi refinado e testado para garantir funcionalidade completa em ambiente Ubuntu com vi e git.

---

<div align="center">

**⭐ Se este projeto foi útil, considere dar uma estrela!**

[![GitHub stars](https://img.shields.io/github/stars/seu-usuario/auto-commit-script.svg?style=social&label=Star)](https://github.com/seu-usuario/auto-commit-script)

</div>
