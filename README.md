# Projetista Jarbas

**Jarbas** é o AI Partner da EPIC Digital para HubSpot. Um skill para Claude Code que responde qualquer pergunta sobre HubSpot combinando documentação oficial (2.629 páginas) com 70+ implementações reais.

Bilíngue PT/EN — responde no idioma da pergunta.

---

## O que o Jarbas sabe

| Camada | Fonte | Cobertura |
|--------|-------|-----------|
| Docs oficiais | developers.hubspot.com | 1.659 páginas — APIs, CMS, automação, auth |
| User docs EN | knowledge.hubspot.com | 616 páginas — 64 categorias |
| User docs PT | knowledge.hubspot.com/pt | 351 páginas — 65 categorias |
| Metodologia EPIC | 70+ implementações | 9 arquivos de regras — pipelines, properties, migrações, go-live |

---

## Instalação

### 1. Download

Clone este repositório ou baixe o ZIP:

```bash
git clone https://github.com/epic-digital-mkt/Projetista-Jarbas.git
```

### 2. Instalar o skill

Copie a pasta para o diretório de skills do Claude Code:

```bash
# macOS / Linux
cp -r projetista-jarbas ~/.claude/skills/projetista-jarbas

# Windows (PowerShell)
Copy-Item -Recurse projetista-jarbas "$env:USERPROFILE\.claude\skills\projetista-jarbas"
```

### 3. Usar

Em qualquer sessão do Claude Code:

```
/projetista-jarbas como configuro lead scoring no HubSpot?
/projetista-jarbas what's the rate limit for the Contacts API?
/projetista-jarbas quando uso custom object vs pipeline separado?
```

---

## Exemplos de uso

### Pergunta de configuração (PT)

```
/projetista-jarbas como crio uma propriedade de data no HubSpot?
```

Jarbas carrega `user-docs/pt/properties.md` e responde em Português com a navegação exata da UI.

### Pergunta de API (EN)

```
/projetista-jarbas what's the best way to create associations via API?
```

Jarbas carrega `api-docs/api-reference-crm.md` (seção de associações) e responde com exemplos de código e o gotcha do typeId.

### Decisão de arquitetura (PT)

```
/projetista-jarbas quando uso custom object vs pipeline separado?
```

Jarbas carrega `implementation-rules/custom-objects.md` + `pipeline-design.md` e responde com a árvore de decisão EPIC.

### Troubleshooting (EN)

```
/projetista-jarbas my workflow isn't re-enrolling contacts after a property change
```

Jarbas carrega `user-docs/en/workflows.md` + `api-docs/api-reference-automation.md` e diagnostica as configurações de re-enrollment.

---

## Formato de resposta do Jarbas

Toda resposta segue esta estrutura:

1. **Resposta direta** — sem preâmbulo, direto ao ponto
2. **Passo a passo** — passos numerados com labels corretos da UI no seu idioma (quando aplicável)
3. **Referência oficial** — "Segundo a documentação oficial do HubSpot: [categoria]"
4. **Padrão EPIC** — "Padrão EPIC recomendado: [regra]" (quando aplicável)
5. **Gotchas / avisos** — armadilhas conhecidas de 70+ implementações reais (quando aplicável)

---

## Cobertura da base de conhecimento

### API Docs — 18 categorias, 1.659 páginas

| Categoria | Páginas |
|-----------|---------|
| CRM APIs | 627 |
| Legacy APIs (v1/v2) | 262 |
| CMS APIs | 182 |
| App Development | 142 |
| CMS Development (HubL) | 122 |
| Marketing APIs | 98 |
| + 12 categorias | 226 |

### User Docs — 129 categorias, 967 páginas (EN + PT)

Principais tópicos: Email Marketing, Registros, Workflows, Relatórios, Email Conectado, Campanhas, Anúncios, Help Desk, Landing Pages, Blog, Gestão de Conta.

### Regras de Implementação EPIC — 9 arquivos

| Regra | O que cobre |
|-------|-------------|
| Methodology | Framework de implementação em 5 fases |
| Migration Playbook | Salesforce, RD Station, Pipedrive → HubSpot |
| Pipeline Design | Pipelines de negócios, tickets e custom objects |
| API Gotchas | 17 regras de ouro para desenvolvimento na API HubSpot |
| Property Architecture | Convenções de nomenclatura, grupos, tipos, escala |
| Workflow Patterns | Padrões de automação, custom code actions |
| Go-Live Checklist | Pré go-live, cutover, hypercare |
| Custom Objects | Árvore de decisão, schema, associações |
| Multi-Tenant Safety | Gerenciamento seguro de múltiplos portais |

---

## Estrutura de arquivos

```
projetista-jarbas/
├── SKILL.md                   # Definição do skill — carregado pelo Claude Code
└── rules/
    ├── jarbas-persona.md      # Identidade, tom e formato de resposta
    ├── kb-reference.md        # Índice da base de conhecimento (2.629 páginas)
    └── routing.md             # Mapeia intenção da pergunta para categorias da KB
```

---

## O que o Jarbas NÃO faz

- **Executar ações** no HubSpot — Jarbas orienta, não cria/edita/deleta
- **Responder sobre dados de clientes específicos** — use o CLAUDE.md do cliente para isso
- **Chutar** — se não tiver certeza, o Jarbas diz e aponta para a categoria KB relevante

---

## MCP server (opcional)

Para dados reais do portal HubSpot em tempo real, conecte o servidor MCP **HubSpotDev**. Isso permite que o Jarbas consulte contatos, propriedades e configurações do portal durante as conversas.

---

Desenvolvido pela [EPIC Digital](https://epic.digital) — consultoria de Revenue Architecture especializada em implementações enterprise de HubSpot.
