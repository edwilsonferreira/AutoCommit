#!/bin/bash

# auto-commit.sh - Script para gerar mensagens de commit automaticamente
# Uso: ./auto-commit.sh [tipo] [escopo]
# Exemplo: ./auto-commit.sh feat compilador

# Configurações
DEFAULT_TYPE="feat"
MAX_SUBJECT_LENGTH=50

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Função para mostrar ajuda
show_help() {
    echo -e "${BLUE}Uso: $0 [tipo] [escopo]${NC}"
    echo ""
    echo "Tipos disponíveis:"
    echo "  feat     - Nova funcionalidade"
    echo "  fix      - Correção de bug"
    echo "  docs     - Documentação"
    echo "  style    - Formatação, lint"
    echo "  refactor - Refatoração de código"
    echo "  test     - Adição/correção de testes"
    echo "  chore    - Tarefas de manutenção"
    echo ""
    echo "Exemplos:"
    echo "  $0 feat compilador"
    echo "  $0 fix parser"
    echo "  $0 docs readme"
}

# Verificar se estamos em um repositório git
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo -e "${RED}Erro: Este diretório não é um repositório git!${NC}"
    exit 1
fi

# Verificar se há mudanças para commit
if git diff --cached --quiet; then
    echo -e "${YELLOW}Nenhuma mudança staged para commit.${NC}"
    echo "Execute 'git add' primeiro ou use 'git add -A && $0'"
    exit 1
fi

# Parâmetros
COMMIT_TYPE=${1:-$DEFAULT_TYPE}
SCOPE=${2:-""}

# Validar tipo de commit
case $COMMIT_TYPE in
    feat|fix|docs|style|refactor|test|chore|perf|ci|build)
        ;;
    *)
        echo -e "${RED}Tipo de commit inválido: $COMMIT_TYPE${NC}"
        show_help
        exit 1
        ;;
esac

# Analisar mudanças
echo -e "${BLUE}Analisando mudanças...${NC}"

# Obter estatísticas
STATS=$(git diff --cached --stat)
FILES_CHANGED=$(git diff --cached --name-only)
ADDITIONS=$(git diff --cached --numstat | awk '{sum += $1} END {print sum+0}')
DELETIONS=$(git diff --cached --numstat | awk '{sum += $2} END {print sum+0}')

# Detectar padrões comuns
generate_message() {
    local files_list="$1"
    local message=""
    
    # Análise de arquivos modificados
    if echo "$files_list" | grep -q "\.py$"; then
        if echo "$files_list" | grep -q "test"; then
            message="adiciona/atualiza testes Python"
        else
            message="implementa funcionalidades Python"
        fi
    elif echo "$files_list" | grep -q "README\|readme"; then
        message="atualiza documentação"
    elif echo "$files_list" | grep -q "\.md$"; then
        message="atualiza documentação Markdown"
    elif echo "$files_list" | grep -q "requirements\|setup\|Dockerfile"; then
        message="atualiza configurações do projeto"
    elif echo "$files_list" | grep -q "\.json$\|\.yaml$\|\.yml$\|\.toml$"; then
        message="atualiza arquivos de configuração"
    elif echo "$files_list" | grep -q "\.sh$"; then
        message="atualiza scripts shell"
    else
        # Análise baseada em estatísticas
        if [ "$ADDITIONS" -gt "$DELETIONS" ]; then
            if [ "$ADDITIONS" -gt 100 ]; then
                message="implementa nova funcionalidade"
            else
                message="adiciona melhorias"
            fi
        elif [ "$DELETIONS" -gt "$ADDITIONS" ]; then
            message="remove código desnecessário"
        else
            message="refatora código existente"
        fi
    fi
    
    echo "$message"
}

# Gerar descrição automática
DESCRIPTION=$(generate_message "$FILES_CHANGED")

# Construir mensagem de commit
if [ -n "$SCOPE" ]; then
    COMMIT_MSG="${COMMIT_TYPE}(${SCOPE}): ${DESCRIPTION}"
else
    COMMIT_MSG="${COMMIT_TYPE}: ${DESCRIPTION}"
fi

# Truncar se muito longo
if [ ${#COMMIT_MSG} -gt $MAX_SUBJECT_LENGTH ]; then
    COMMIT_MSG=$(echo "$COMMIT_MSG" | cut -c1-$((MAX_SUBJECT_LENGTH-3)))...
fi

# Mostrar informações
echo -e "${GREEN}Resumo das mudanças:${NC}"
echo "$STATS"
echo ""
echo -e "${GREEN}Arquivos modificados:${NC}"
echo "$FILES_CHANGED"
echo ""
echo -e "${YELLOW}Linhas: +${ADDITIONS} -${DELETIONS}${NC}"
echo ""
echo -e "${GREEN}Mensagem de commit gerada:${NC}"
echo -e "${BLUE}$COMMIT_MSG${NC}"
echo ""

# Confirmar commit
read -p "Confirmar commit? (y/N): " confirm
case $confirm in
    [Yy]* )
        git commit -m "$COMMIT_MSG"
        echo -e "${GREEN}Commit realizado com sucesso!${NC}"
        ;;
    * )
        echo -e "${YELLOW}Commit cancelado.${NC}"
        exit 1
        ;;
esac
