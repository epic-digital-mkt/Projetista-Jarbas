# Routing: Intent to KB Categories

This file maps user questions to the correct Knowledge Base files. Use this to determine which files to load before answering.

## Level 1: Question Type

| Type | Signals (PT) | Signals (EN) | Primary Source |
|------|-------------|-------------|---------------|
| Usage/Config | "como configuro", "onde fica", "como faco", "passo a passo" | "how do I", "where is", "how to", "step by step" | user-docs |
| API/Dev | "API", "endpoint", "custom code", "webhook", "HubL", "serverless" | same | api-docs |
| Best Practice | "melhor forma", "recomendacao", "padrao", "devo usar" | "best way", "recommendation", "pattern", "should I" | Implementation Skill + user-docs |
| Troubleshooting | "nao funciona", "erro", "problema", "bug" | "not working", "error", "issue", "bug" | api-docs + user-docs |
| Architecture | "como estruturo", "design", "modelagem", "arquitetura" | "how to structure", "design", "modeling", "architecture" | Implementation Skill |

## Level 2: Domain Routing

### CRM & Data

| Keywords (PT/EN) | user-docs | api-docs | Skill Rule |
|-------------------|-----------|----------|------------|
| contato, contact | records | api-reference-crm | — |
| empresa, company | records | api-reference-crm | — |
| negocio, deal | records, object-settings | api-reference-crm | pipeline-design.md |
| registro, record, associacao, association | records | api-reference-crm | custom-objects.md |
| propriedade, property, campo, field | properties | api-reference-crm | property-architecture.md |
| objeto customizado, custom object | object-settings | api-reference-crm | custom-objects.md |
| importacao, import, exportacao, export | import-and-export | api-reference-crm | migration-playbook.md |
| lista, list, segmento, segment | segments | api-reference-crm | — |

### Sales

| Keywords (PT/EN) | user-docs | api-docs | Skill Rule |
|-------------------|-----------|----------|------------|
| pipeline, estagio, stage | object-settings | api-reference-crm | pipeline-design.md |
| sequencia, sequence | sequences | api-reference-automation | — |
| reuniao, meeting | meetings-tool | — | — |
| orcamento, quote, cotacao | quotes | api-reference-crm | — |
| forecast, previsao | forecast | — | — |
| scoring, pontuacao, lead score | scoring | api-reference-crm | property-architecture.md |
| prospeccao, prospecting | prospecting (PT) | — | — |

### Marketing

| Keywords (PT/EN) | user-docs | api-docs | Skill Rule |
|-------------------|-----------|----------|------------|
| email, email marketing, newsletter | marketing-email | api-reference-marketing | — |
| campanha, campaign | campaigns | api-reference-marketing | — |
| formulario, form | Forms (EN) / forms (PT) | api-reference-cms | — |
| landing page, pagina | website-and-landing-pages | api-reference-cms | — |
| CTA, call to action | ctas | api-reference-cms | — |
| blog, conteudo, content | blog, content-strategy | api-reference-cms | — |
| anuncio, ad, ads, midia paga | ads | — | — |
| social, redes sociais | social | — | — |
| SEO | seo (PT only) | — | — |

### Automation

| Keywords (PT/EN) | user-docs | api-docs | Skill Rule |
|-------------------|-----------|----------|------------|
| workflow, automacao, automation | workflows | api-reference-automation | workflow-patterns.md |
| trigger, gatilho, acao, action | workflows | api-reference-automation | workflow-patterns.md |
| chatbot, chatflow, bot | chatflows | api-reference-conversations | — |

### Service & CS

| Keywords (PT/EN) | user-docs | api-docs | Skill Rule |
|-------------------|-----------|----------|------------|
| ticket, suporte, support, help desk | help-desk | api-reference-crm | pipeline-design.md |
| feedback, NPS, CSAT | customer-feedback | — | — |
| customer success, CS | customer-success | — | — |
| caixa de entrada, inbox | inbox | api-reference-conversations | — |

### Admin & Config

| Keywords (PT/EN) | user-docs | api-docs | Skill Rule |
|-------------------|-----------|----------|------------|
| usuario, user, permissao, permission | user-management | api-reference-auth | multi-tenant-safety.md |
| seguranca, security, 2FA, SSO | account-security | api-reference-auth | — |
| conta, account, configuracao, settings | account, account-management | api-reference-settings | — |
| dominio, domain, DNS, URL | domains-and-urls | — | — |
| faturamento, billing | billing | — | — |
| LGPD, GDPR, privacidade, consent | privacy-and-consent | api-reference-communication-preferences | — |

### Reporting

| Keywords (PT/EN) | user-docs | api-docs | Skill Rule |
|-------------------|-----------|----------|------------|
| relatorio, report | reports | — | — |
| dashboard, painel | dashboards (EN) / dashboard (PT) | — | — |
| analytics, metricas | analytics-tools | api-reference-events | — |
| meta, goal | goals | — | — |

### Development

| Keywords (PT/EN) | user-docs | api-docs | Skill Rule |
|-------------------|-----------|----------|------------|
| API, REST, endpoint | — | (by specific API) | api-gotchas.md |
| HubL, template, tema, theme | — | cms | — |
| app, extensao, extension, UI extension | — | apps | — |
| CLI, hs command | — | developer-tooling | — |
| webhook | — | api-reference-webhooks | — |
| migracao, migration, Salesforce, RD Station | — | api-reference-crm | migration-playbook.md |

### Implementation Lifecycle

| Keywords (PT/EN) | user-docs | api-docs | Skill Rule |
|-------------------|-----------|----------|------------|
| go-live, lancamento, cutover | — | — | go-live-checklist.md |
| hypercare, pos go-live | — | — | go-live-checklist.md |
| discovery, arquitetura | — | — | methodology.md |
| multi-portal, multi-tenant, varios portais | — | — | multi-tenant-safety.md |

## Level 3: Language Detection

| Question Language | Load user-docs from | UI Labels Style |
|-------------------|--------------------|--------------------|
| Portuguese | `user-docs/pt/llm-ready/by-category/` | "Va em Configuracoes > Propriedades" |
| English | `user-docs/en/llm-ready/by-category/` | "Go to Settings > Properties" |
| Mixed/Ambiguous | `user-docs/pt/llm-ready/by-category/` | Portuguese labels (default) |

**Note:** API docs are always in English (no PT version exists for developer docs).

## Context Budget Rules

1. **Max 2 category files per response** (~1MB total)
2. If question crosses domains, prioritize the most relevant category
3. For follow-up questions in the same topic, reuse already-loaded categories
4. `api-reference-crm.md` is 7.5MB — NEVER load entirely. Use user-docs alternatives first
5. Implementation Skill rules are small (9-18KB each) — safe to load alongside any category
