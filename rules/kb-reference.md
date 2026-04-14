# Knowledge Base Reference

Prefira as ferramentas MCP (`search_kb`, `get_category`, `suggest_docs`) em vez de carregar arquivos diretamente.
Se usar a ferramenta Read, os caminhos são relativos à raiz do repositório projetista-jarbas.

**Caminho KB no repo:** `kb/` (relativo) ou `~/epic/projetista-jarbas/kb/` (absoluto)

## API Docs (18 categories, 1,659 pages)

Source: developers.hubspot.com/docs

| Category | MCP scope/category | Pages | Notes |
|----------|-------------------|-------|-------|
| CRM APIs | api-docs / api-reference-crm | 627 | LARGE (7.5MB) — avoid loading fully |
| Legacy APIs (v1/v2) | api-docs / api-reference-legacy | 262 | Only if user asks about v1/v2 |
| CMS APIs | api-docs / api-reference-cms | 182 | Templates, pages, modules |
| App Development | api-docs / apps | 142 | UI extensions, serverless |
| CMS Development | api-docs / cms | 122 | HubL, themes, modules |
| Marketing APIs | api-docs / api-reference-marketing | 98 | Email, lists, campaigns |
| Conversations APIs | api-docs / api-reference-conversations | 37 | Chat, messaging |
| Automation APIs | api-docs / api-reference-automation | 35 | Workflows, custom actions |
| Settings APIs | api-docs / api-reference-settings | 29 | Account config |
| Files APIs | api-docs / api-reference-files | 21 | File management |
| Developer Tooling | api-docs / developer-tooling | 20 | CLI, local dev |
| Auth APIs | api-docs / api-reference-auth | 17 | OAuth, private apps |
| Comm Preferences | api-docs / api-reference-communication-preferences | 16 | Subscriptions |
| API Core | api-docs / api-reference-core | 15 | Fundamentals |
| Events APIs | api-docs / api-reference-events | 14 | Analytics, tracking |
| Webhooks APIs | api-docs / api-reference-webhooks | 11 | Event-driven |
| Guides | api-docs / guides | 7 | CRM concepts |
| Getting Started | api-docs / getting-started | 4 | Quickstart |

## User Docs EN (64 categories, 616 pages)

Source: knowledge.hubspot.com | Language: English

Top categories by page count:

| Category | MCP scope/category | Pages |
|----------|-------------------|-------|
| Marketing Email | user-docs-en / marketing-email | 64 |
| Records | user-docs-en / records | 49 |
| Workflows | user-docs-en / workflows | 45 |
| Reports | user-docs-en / reports | 44 |
| Connected Email | user-docs-en / connected-email | 35 |
| Account Management | user-docs-en / account-management | 29 |
| Campaigns | user-docs-en / campaigns | 26 |
| Ads | user-docs-en / ads | 24 |
| Help Desk | user-docs-en / help-desk | 22 |
| Website & Landing Pages | user-docs-en / website-and-landing-pages | 22 |
| Account | user-docs-en / account | 19 |
| Blog | user-docs-en / blog | 17 |
| Help & Resources | user-docs-en / help-and-resources | 14 |
| Calling | user-docs-en / calling | 13 |
| Object Settings | user-docs-en / object-settings | 11 |
| Account Security | user-docs-en / account-security | 11 |
| CTAs | user-docs-en / ctas | 11 |
| User Management | user-docs-en / user-management | 10 |
| Get Started | user-docs-en / get-started | 9 |
| Integrations | user-docs-en / integrations | 9 |

Other EN categories (1-8 pages each): Forms, chatflows, website-pages, ai, ai-tools, quotes, customer-feedback, goals, content-strategy, properties, one-to-one-email, customer-agent, billing, sequences, domains-and-urls, payment-processing, segments, social, analytics-tools, privacy-and-consent, cta, resources, contacts, conversations, cpq, cs, dashboards, documents, files, forecast, knowledge-base, meeting-tool, meetings-tool, partner-tools, podcasts, sales-tools, scoring, subscriptions, tasks.

## User Docs PT (65 categories, 351 pages)

Source: knowledge.hubspot.com/pt | Language: Portugues

Top categories by page count:

| Category | MCP scope/category | Pages |
|----------|-------------------|-------|
| Integrations | user-docs-pt / integrations | 29 |
| Marketing Email | user-docs-pt / marketing-email | 28 |
| Workflows | user-docs-pt / workflows | 17 |
| Connected Email | user-docs-pt / connected-email | 16 |
| Records | user-docs-pt / records | 16 |
| Social | user-docs-pt / social | 15 |
| Ads | user-docs-pt / ads | 14 |
| Reports | user-docs-pt / reports | 12 |
| Forms | user-docs-pt / forms | 10 |
| Salesforce | user-docs-pt / salesforce | 9 |
| Help Desk | user-docs-pt / help-desk | 9 |
| Website & Landing Pages | user-docs-pt / website-and-landing-pages | 9 |
| User Management | user-docs-pt / user-management | 9 |
| Account | user-docs-pt / account | 8 |
| Campaigns | user-docs-pt / campaigns | 8 |
| Design Manager | user-docs-pt / design-manager | 8 |
| Properties | user-docs-pt / properties | 8 |
| Sequences | user-docs-pt / sequences | 7 |
| Account Management | user-docs-pt / account-management | 6 |
| Files | user-docs-pt / files | 6 |

Other PT categories (1-5 pages each): segments, import-and-export, ai, object-settings, calling, chatflows, privacy-and-consent, website-pages, blog, account-security, customer-feedback, data-management, domains-and-urls, forecast, help-and-resources, payments, prospecting, ai-tools, analytics-tools, billing, content-strategy, conversations, ctas, dashboard, goals, marketplace, mobile, one-to-one-email, partner-tools, payment-links, payment-processing, podcasts, prospects, quotes, resources, sales-tools, scoring, seo, service-tools, sms, tasks, web-content, get-started.

## Implementation Rules (9 files)

Available via MCP tool `get_implementation_guide` or at `implementation-rules/` in the repo.

| Rule | Topic ID | Size |
|------|----------|------|
| Methodology | methodology | 17KB |
| Migration Playbook | migration-playbook | 18KB |
| Pipeline Design | pipeline-design | 18KB |
| API Gotchas | api-gotchas | 16KB |
| Property Architecture | property-architecture | 14KB |
| Workflow Patterns | workflow-patterns | 13KB |
| Go-Live Checklist | go-live-checklist | 13KB |
| Custom Objects | custom-objects | 12KB |
| Multi-Tenant Safety | multi-tenant-safety | 9KB |

**Note:** These files are small (9-18KB). Safe to load 2-3 rules alongside a KB category file.
