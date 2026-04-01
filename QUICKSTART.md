# Quick Start Guide

Teste a validação de commits do h-hooks em 5 minutos.

## 1. Setup (uma vez)

```bash
# Instalar dependências
npm install

# Instalar pre-commit
pip install pre-commit

# Inicializar git (se necessário)
git init

# Instalar hooks
pre-commit install --hook-type commit-msg
```

## 2. Teste Automatizado

```bash
# Executar suite de testes completa
./test-commit-messages.sh
```

**Resultado esperado:**
```
Testing: JIRA ticket with feat type ... ✓ PASS
Testing: No JIRA ticket, feat type ... ✓ PASS
Testing: Subject starts with uppercase ... ✓ PASS (correctly rejected)
...
✓ All tests passed!
Passed: 27
Failed: 0
```

## 3. Teste Manual (Interativo)

### Teste 1: Mensagem válida ✅

```bash
git commit --allow-empty -m "HYPERFLEET-813 - feat: add validation"
```

**Esperado:** Commit criado com sucesso, sem erros.

### Teste 2: Mensagem inválida ❌

```bash
git commit --allow-empty -m "feat: Add Validation"
```

**Esperado:** Commit bloqueado com mensagem:
```
✗ Commit message validation failed

Please follow HyperFleet Conventional Commits standard:
  HYPERFLEET-XXX - <type>: <subject>

  ✗ feat: Add validation (subject should be lowercase)
```

## 4. Teste sem Commit

```bash
# Testar mensagem diretamente
echo "HYPERFLEET-001 - feat: test feature" | npx commitlint

# Testar mensagem inválida
echo "invalid message" | npx commitlint
```

## 5. Cenários de Teste Rápido

```bash
# ✅ Válidos
git commit --allow-empty -m "HYPERFLEET-001 - feat: add feature"
git commit --allow-empty -m "fix: resolve bug"
git commit --allow-empty -m "docs: update readme"

# ❌ Inválidos (todos devem falhar)
git commit --allow-empty -m "Add feature"
git commit --allow-empty -m "feat: Add Feature"
git commit --allow-empty -m "feat: test."
```

## Troubleshooting

### "npx: command not found"
```bash
# macOS
brew install node

# Ubuntu/Debian
sudo apt install nodejs npm
```

### Hook não está rodando
```bash
pre-commit install --hook-type commit-msg
```

### Ver mensagens detalhadas
```bash
echo "test" | npx commitlint --verbose
```

## Próximos Passos

Após testar aqui, aplique a mesma configuração no seu projeto real:

1. Copie `.pre-commit-config.yaml` para seu projeto
2. Copie `commitlint.config.js` para seu projeto
3. Copie `devDependencies` do `package.json`
4. Execute `npm install` e `pre-commit install --hook-type commit-msg`

## Referências

- [README.md](README.md) - Documentação completa
- [TESTING.md](TESTING.md) - Guia de testes detalhado
- [h-hooks](https://github.com/ldornele/h-hooks) - Repositório central
