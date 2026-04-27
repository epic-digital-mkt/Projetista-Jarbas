# Projetista Jarbas — Meeting Watcher

> **Transforma notas de reunião em Use Cases estruturados, cria uma tarefa no ClickUp com subtarefas por UC — de forma 100% autônoma.**

Monitora docs do ClickUp em background. Quando detecta uma nova reunião, aciona o Gemini AI para gerar casos de uso, consulta recomendações técnicas de HubSpot por UC em paralelo e entrega tudo organizado: tarefa principal com o nome da reunião + uma subtarefa por Use Case, cada uma com user story, critérios, sugestão técnica e sprint.

---

## Por que usar

| Sem o Jarbas | Com o Jarbas |
|---|---|
| Analisa a reunião manualmente | Gemini lê e estrutura automaticamente |
| Cria User Stories do zero | UC, User Story e Critérios gerados via AI |
| Consulta especialista HubSpot | Recomendação técnica por UC em paralelo |
| Cria subtarefas manualmente | Subtarefa por UC criada automaticamente no ClickUp |
| Controla sprint manualmente | Campo Sprint incluso em cada subtarefa e no Excel |
| Verifica a cada reunião | Roda a cada hora via Task Scheduler |

---

## Como funciona

```
  ClickUp Docs
  (nova reunião detectada)
        |
        v
  ┌─────────────────────────────────────┐
  │  Gemini AI  (gemini-2.5-flash)      │
  │  Lê o conteúdo e gera JSON com:     │
  │  - ID, Grupo, Caso de Uso           │
  │  - User Story (Como X, quero Y)     │
  │  - Criterios de Aceite              │
  │  - Shirt Size, MoSCoW, Datas        │
  └─────────────────────────────────────┘
        |
        v  (paralelo, até 5 UCs simultâneos)
  ┌─────────────────────────────────────┐
  │  Recomendação Técnica HubSpot       │
  │  Por UC, retorna:                   │
  │  - Sugestão: módulo/ferramenta      │
  │  - Hub + Licença necessários        │
  └─────────────────────────────────────┘
        |
        v
  ┌─────────────────────────────────────┐
  │  ClickUp Task (nome da reunião)     │
  │  - Tarefa principal = nome doc      │
  │  - Índice de UCs na descrição       │
  │  - Assignee + due date automáticos  │
  └─────────────────────────────────────┘
        |
        v  (uma subtarefa por UC)
  ┌─────────────────────────────────────┐
  │  Subtarefas por Use Case            │
  │  - Nome: UC01 — Caso de Uso         │
  │  - Corpo: user story + critérios    │
  │  - Sugestão técnica + Hub/Licença   │
  │  - Shirt, Horas, MoSCoW, Sprint     │
  └─────────────────────────────────────┘
```

---

## Caso de uso real — Teste WhatsApp HubSpot

> Entrada: *"Meus vendedores querem usar WhatsApp na HubSpot para vender"*

O watcher gerou automaticamente os casos de uso, consultou recomendações técnicas por UC e criou a tarefa com Excel anexado em menos de 3 minutos.

**Tarefa gerada:** [Teste - Projetista Jarbas Demo — ClickUp](https://app.clickup.com/t/86agweagc)

Exemplo de UC gerado para essa entrada:

| Campo | Valor gerado |
|-------|-------------|
| ID | UC03 |
| Caso de Uso | Envio de mensagens WhatsApp pelo vendedor |
| User Story | Como vendedor, quero enviar WhatsApp direto pelo HubSpot, para ter todas as conversas no CRM |
| Critérios | Dado que o contato tem WhatsApp, quando o vendedor envia, então a mensagem aparece no CRM |
| Sugestão Técnica | Integrar WhatsApp Business via provedor parceiro (Twilio, 360dialog) conectado ao Inbox do HubSpot |
| Hub / Licença | Sales Hub Pro + Service Hub Starter |

---

## Instalação

### 1. Clonar o repositório

```bash
git clone https://github.com/epic-digital-mkt/Projetista-Jarbas.git
cd projetista-jarbas
pip install -r requirements.txt
```

### 2. Configurar `.env`

```bash
cp .env.example .env
```

Edite o `.env` com seus valores:

```env
CLICKUP_API_KEY=pk_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
CLICKUP_WORKSPACE=seu_workspace_id
CLICKUP_USER_ID=seu_user_id
GEMINI_API_KEY=AIzaxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
OUTPUT_DIR=C:/Users/SeuNome/Downloads/Use Cases
```

**Como obter cada valor:**

| Variável | Onde encontrar |
|----------|---------------|
| `CLICKUP_API_KEY` | ClickUp > Perfil > Aplicativos > Token de API |
| `CLICKUP_WORKSPACE` | URL do ClickUp: `app.clickup.com/{workspace_id}/...` |
| `CLICKUP_USER_ID` | ClickUp > Perfil > ID do usuário |
| `GEMINI_API_KEY` | [aistudio.google.com/app/apikey](https://aistudio.google.com/app/apikey) |

### 3. Configurar Spaces monitorados

Edite `meeting_watcher.py` com os IDs dos seus Spaces:

```python
WATCHED_SPACES = {
    "SPACE_ID_1": "Cliente A",
    "SPACE_ID_2": "Cliente B",
    "SPACE_ID_3": "Interno",
}

TASK_LISTS = {
    "SPACE_ID_1": "LIST_ID_DA_LISTA_DE_REUNIOES",
}
```

> **Dica:** Se `TASK_LISTS` estiver vazio, o watcher busca automaticamente uma lista com "Reunião" ou "Meeting" no nome.

### 4. Configurar palavras-chave de detecção

Docs são detectados como reunião se o nome contiver alguma dessas palavras:

```python
MEETING_KEYWORDS = ["weekly", "discovery", "pds", "alinhamento",
                    "pedidos", "novo", "proposta", "projeto"]
```

---

## Workflow após alterações no código

Sempre que modificar `meeting_watcher.py` ou qualquer outro arquivo:

```bash
# 1. Copiar alterações para o repositório limpo (sem secrets)
#    Copie manualmente ou use um script de sync — nunca copie o .env

# 2. Commitar e subir para o GitHub
cd projetista-jarbas
git add meeting_watcher.py README.md   # adicione os arquivos alterados
git commit -m "descrição da mudança"
git push origin main
```

> **Importante:** Nunca inclua o `.env`, `processed_meetings.json` ou `watcher.log` no commit. Esses arquivos estão no `.gitignore`.

---

## Executando

### Rodar manualmente

```bash
python meeting_watcher.py
```

### Agendar no Windows Task Scheduler (a cada 1 hora)

Execute `setup_scheduler.bat` como Administrador, ou via PowerShell:

```powershell
$action  = New-ScheduledTaskAction -Execute "python" -Argument "C:\caminho\meeting_watcher.py" -WorkingDirectory "C:\caminho\projetista-jarbas"
$trigger = New-ScheduledTaskTrigger -RepetitionInterval (New-TimeSpan -Hours 1) -Once -At (Get-Date)
$settings = New-ScheduledTaskSettingsSet -ExecutionTimeLimit (New-TimeSpan -Minutes 10)
Register-ScheduledTask -TaskName "MeetingWatcher" -Action $action -Trigger $trigger -Settings $settings
```

---

## Subtarefas no ClickUp

Cada Use Case vira uma subtarefa dentro da tarefa principal. O corpo da subtarefa contém:

| Campo | Conteúdo |
|-------|----------|
| **User Story** | Como [perfil], quero [ação], para [benefício] |
| **Detalhes** | Contexto técnico e solução proposta |
| **Critérios de Aceite** | Dado / Quando / Então |
| **Sugestão Técnica** | Módulo/ferramenta HubSpot recomendado |
| **Hub / Licença** | Ex: Sales Hub Pro + Ops Hub Starter |
| **Shirt / Horas / MoSCoW** | Tamanho, estimativa e prioridade |
| **Sprint** | Preenchido manualmente após criação |

---

## Planilha Excel (uso manual)

O Excel ainda pode ser gerado manualmente via `test_run.py` com **21 colunas (A–U)** formatadas.

### Colunas A–O — preenchidas automaticamente pelo Gemini

| Col | Coluna | Detalhe |
|-----|--------|---------|
| A | ID | UC01, UC02... |
| B | Grupo | Categoria do caso (ex: Comunicação, Gestão) |
| C | Caso de Uso | Nome curto e objetivo |
| D | User Story | Como [perfil], quero [ação], para [benefício] |
| E | Detalhes / Solução | Contexto técnico e solução proposta |
| F | Critérios de Aceite | Dado / Quando / Então em bullet points |
| G | **Sugestão Técnica** | Módulo/ferramenta HubSpot recomendado *(amarelo)* |
| H | **Hub / Licença** | Ex: Sales Hub Pro + Ops Hub Starter *(verde)* |
| I | Status | Dropdown: OPEN / BACKLOG / PENDING / WAITING INFORMATION / IN PROGRESS / INTERNAL REVIEW / CLIENT REVIEW / CANCELED |
| J | Responsável | Nome do responsável |
| K | Shirt | Dropdown: S / M / L / XL |
| L | Horas | Estimativa (ex: 8h, 16h) |
| M | MoSCoW | Dropdown: Must / Should / Could / Won't |
| N | Início | Data DD/MM |
| O | Fim | Data DD/MM |

> Colunas G e H são preenchidas em paralelo — até 5 UCs simultâneos via `ThreadPoolExecutor`.

### Colunas P–U — em branco para gestão manual

Cabeçalho em cinza-azulado `#44546A` para distinguir visualmente.

| Col | Coluna | Uso |
|-----|--------|-----|
| P | Lista ou ID | ID da lista ou tarefa no ClickUp |
| Q | Título | Título da tarefa |
| R | Descrição (contexto) | Contexto ou observações adicionais |
| S | Responsável (Assignee) | Pessoa atribuída à tarefa |
| T | Status (tarefa) | Status atual no ClickUp |
| U | **Sprint** | Sprint atribuído ao UC |

---

## Resiliência e fallback

### Fallback de modelos Gemini

Se `gemini-2.5-flash` retornar 503 ou 429, o watcher tenta automaticamente:

```
gemini-2.5-flash  -->  gemini-2.5-flash-lite  -->  gemini-3-flash-preview
```

### Retry com backoff exponencial

Erros 429 (rate limit) e 503 (serviço indisponível) acionam retry automático:

```
Tentativa 1: aguarda 4s
Tentativa 2: aguarda 8s
Tentativa 3: aguarda 16s
Tentativa 4: erro final
```

### Fallback de conteúdo

Se o Gemini estiver totalmente indisponível, o watcher cria uma estrutura mínima com `UC01 — Revisar manualmente` e ainda cria a tarefa no ClickUp para não perder a reunião.

---

## Rastreamento de estado

Doc IDs processados são salvos em `processed_meetings.json`:

```json
{
  "abc123": {
    "name": "Weekly Cliente - 2025-04-08",
    "task_url": "https://app.clickup.com/t/...",
    "processed_at": "2025-04-08T10:30:00"
  }
}
```

> Para reprocessar uma reunião, remova sua entrada do arquivo.

Logs em tempo real em `watcher.log`:

```
[2026-04-10 18:10:29] Processando: Teste - Vendedores WhatsApp HubSpot
[2026-04-10 18:10:35]   Gemini: 8 casos de uso gerados.
[2026-04-10 18:10:45]   David -> UC01: ok
[2026-04-10 18:10:45]   David -> UC03: ok
[2026-04-10 18:10:45]   Excel: C:\Users\...\Teste - Vendedores WhatsApp HubSpot_Use_Cases.xlsx
[2026-04-10 18:10:46]   Tarefa: https://app.clickup.com/t/86agua0db
[2026-04-10 18:10:46]   Excel anexado.
```

---

## Erros comuns

| Erro | Causa | Solução |
|------|-------|---------|
| `KeyError: CLICKUP_API_KEY` | `.env` não configurado | Copiar `.env.example` para `.env` e preencher |
| `503 / 429 Gemini` | Modelo sobrecarregado | Retry automático já implementado |
| `Nenhuma reunião nova` | Docs já processados ou keyword não bate | Checar `processed_meetings.json` e `MEETING_KEYWORDS` |
| `ERRO: nenhuma lista encontrada` | Space não mapeado | Adicionar `list_id` em `TASK_LISTS` |
| Excel não anexado | `OUTPUT_DIR` inválido | Verificar se a pasta existe |
| `JSON truncado` | Resposta Gemini cortada | Repair automático implementado no parser |

---

## Estrutura do projeto

```
projetista-jarbas/
├── meeting_watcher.py       # Script principal
├── SKILL.md                 # Skill Claude Code (/projetista-jarbas)
├── requirements.txt         # Dependências Python
├── .env.example             # Template de variáveis de ambiente
├── .env                     # Suas chaves (não commitado)
├── setup_scheduler.bat      # Agendador Windows Task Scheduler
├── processed_meetings.json  # Controle de estado (não commitado)
└── watcher.log              # Log de execução (não commitado)
```

---

## Dependências

```
openpyxl>=3.1.0
```

Todas as chamadas HTTP usam `urllib` nativo do Python — sem dependência de `requests`.

---

## Skill Claude Code

Este repositório inclui um `SKILL.md` para uso como skill do Claude Code:

```bash
# Instalar
cp -r projetista-jarbas ~/.claude/skills/projetista-jarbas   # macOS/Linux
Copy-Item -Recurse projetista-jarbas "$env:USERPROFILE\.claude\skills\projetista-jarbas"  # Windows
```

Depois é só chamar:

```
/projetista-jarbas executar o watcher agora
/projetista-jarbas mostrar os últimos logs
/projetista-jarbas reprocessar a reunião de ontem
```

---

## Gemini Gem — Gerador de Use Cases

O Projetista Jarbas também existe como **Gem no Google Gemini** para uso manual e interativo — ideal para reuniões únicas, pedidos avulsos ou revisões antes de entrar no pipeline automatizado.

### Como criar seu Gem

1. Acesse [gemini.google.com](https://gemini.google.com)
2. Clique em **Gems** no menu lateral → **Novo Gem**
3. Dê o nome: `Projetista Jarbas`
4. Cole as instruções abaixo no campo **Instruções**
5. Salve

### Instruções do Gem

```
Você é um gestor de projeto que envolve venda, implementação, otimização e gestão da ferramenta HubSpot.

É necessário criar tabelas de use cases e user stories de forma que seja fácil apresentar e aprovar as soluções com o cliente. Nossas fontes de dados vão ser transcrições de reuniões e pedidos feitos por mim. É importante que a tabela fique clara e possa ser usada em integrações com o Google Sheets e ClickUp.

Para as colunas precisamos incluir:

| Coluna | Descrição |
|--------|-----------|
| ID | Identificador único do caso (UC01, UC02...) |
| Grupo | Categoria ou módulo HubSpot envolvido |
| Caso de Uso | Nome curto e objetivo do caso |
| User Story | Como [perfil], quero [ação], para [benefício] |
| Detalhes | Contexto adicional e informações relevantes |
| Perguntas para Briefing | Dúvidas a esclarecer com o cliente antes de implementar |
| Solução Proposta | Abordagem técnica e funcional recomendada |
| Condição para Aprovação (QA) | Critérios que definem que o caso está implementado corretamente |
| Necessidade Técnica | Recursos, integrações ou configurações necessárias |
| Shirt Size | Estimativa de esforço: S / M / L / XL |
| Horas Previstas | Estimativa em horas (ex: 4h, 8h, 16h) |
| Status | OPEN / BACKLOG / PENDING / WAITING INFORMATION / IN PROGRESS / INTERNAL REVIEW / CLIENT REVIEW / CANCELED |
| Stakeholder / Responsável | Quem do cliente lidera ou aprova o caso |
| MoSCoW | Prioridade: Must / Should / Could / Won't |
| Data de Início | DD/MM |
| Data Final | DD/MM |
| Responsável | Consultor EPIC responsável pela entrega |
| Lista ClickUp | Nome ou ID da lista onde a tarefa será criada |
| Necessidade Técnica HubSpot | Hub e licença necessários (ex: Sales Hub Pro + Ops Hub Starter) |
```

### Exemplo de uso do Gem

**Entrada:**
> "Transcrição da reunião com Petlove — time quer usar WhatsApp integrado ao CRM e automatizar follow-up pós-proposta"

**O Gem retorna** uma tabela completa com todos os casos de uso mapeados, prontos para copiar no Google Sheets ou importar no ClickUp.

### Diferença entre o Gem e o Watcher automático

| | Gem (manual) | Watcher (automático) |
|--|---|---|
| Acionamento | Você cola a transcrição | Detecta automaticamente no ClickUp |
| Resultado | Tabela para revisar | Excel formatado + tarefa criada |
| Melhor para | Reuniões avulsas, revisões | Fluxo contínuo de projetos |

---

Desenvolvido pela [EPIC Digital](https://epic.digital) — consultoria de Revenue Architecture especializada em implementações enterprise de HubSpot.
