# Projetista Jarbas — Meeting Watcher

Autonomous meeting watcher that monitors ClickUp docs, detects new meeting notes, and automatically generates Use Cases as a formatted Excel file — then creates a ClickUp task with the spreadsheet attached.

## What it does

```
ClickUp Doc (meeting notes)
        |
        v
  Gemini AI (gemini-2.5-flash)
  Generates structured JSON: UC IDs, User Stories,
  Acceptance Criteria, Shirt Sizes, MoSCoW, dates
        |
        v
  HubSpot Technical Recommendation
  Reads each UC row and adds:
  - Technical recommendation (tool/module to use)
  - Required Hub + License tier
        |
        v
  Excel (.xlsx) — 20 formatted columns
  Saved to your configured OUTPUT_DIR
        |
        v
  ClickUp Task created with Excel attached
  Assigned to the configured user, due date extracted from doc name
```

Runs automatically every hour via **Windows Task Scheduler**.

---

## Prerequisites

- Python 3.11+
- `pip install -r requirements.txt`
- ClickUp API key (personal token)
- Google Gemini API key
- Windows Task Scheduler (for automation)

---

## Setup

### 1. Clone and install

```bash
git clone https://github.com/epic-digital-mkt/Projetista-Jarbas.git
cd projetista-jarbas
pip install -r requirements.txt
```

### 2. Configure `.env`

Copy the example file and fill in your values:

```bash
cp .env.example .env
```

```env
CLICKUP_API_KEY=pk_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
CLICKUP_WORKSPACE=your_workspace_id
CLICKUP_USER_ID=your_user_id
GEMINI_API_KEY=AIzaxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
OUTPUT_DIR=C:/Users/yourname/Downloads/Use Cases
```

| Variable | Required | Description |
|----------|----------|-------------|
| `CLICKUP_API_KEY` | Yes | ClickUp personal API token |
| `CLICKUP_WORKSPACE` | Yes | Your ClickUp Workspace ID (visible in the URL) |
| `CLICKUP_USER_ID` | No | Your ClickUp User ID (task assignee) |
| `GEMINI_API_KEY` | Yes | Google Gemini API key |
| `OUTPUT_DIR` | No | Excel output folder (default: `~/Downloads/Use Cases`) |

### 3. Configure watched spaces

In `meeting_watcher.py`, update `WATCHED_SPACES` and `TASK_LISTS` with your ClickUp Space IDs:

```python
WATCHED_SPACES = {
    "SPACE_ID_1": "Client A",
    "SPACE_ID_2": "Client B",
    "SPACE_ID_3": "Internal",
}

TASK_LISTS = {
    "SPACE_ID_1": "LIST_ID_1",  # Space ID -> List ID
}
```

If a space is not in `TASK_LISTS`, the watcher auto-detects a list named "Reuniões" or "Meeting" via the ClickUp API.

### 4. Configure meeting detection

Docs are detected as meetings if their name contains any of these keywords (case-insensitive):

```python
MEETING_KEYWORDS = ["weekly", "discovery", "pds", "alinhamento",
                    "pedidos", "novo", "proposta", "projeto"]
```

---

## Running

### Manual run

```bash
python meeting_watcher.py
```

### Schedule with Windows Task Scheduler (every 1 hour)

Run `setup_scheduler.bat` as Administrator, or use PowerShell:

```powershell
$action  = New-ScheduledTaskAction -Execute "python" -Argument "C:\path\to\meeting_watcher.py" -WorkingDirectory "C:\path\to\projetista-jarbas"
$trigger = New-ScheduledTaskTrigger -RepetitionInterval (New-TimeSpan -Hours 1) -Once -At (Get-Date)
$settings = New-ScheduledTaskSettingsSet -ExecutionTimeLimit (New-TimeSpan -Minutes 10)
Register-ScheduledTask -TaskName "MeetingWatcher" -Action $action -Trigger $trigger -Settings $settings
```

---

## Excel output

Each processed meeting generates a `.xlsx` file with 20 columns (A–T).

### Use Case columns (A–O) — filled automatically

| Col | Column | Description |
|-----|--------|-------------|
| A | ID | UC01, UC02... |
| B | Grupo | Category of the use case |
| C | Caso de Uso | Short name |
| D | User Story | As X, I want Y, so that Z |
| E | Detalhes / Solução | Technical context and proposed solution |
| F | Critérios de Aceite | Given/When/Then acceptance criteria |
| G | Sugestão Técnica | HubSpot technical recommendation (yellow `#FFF2CC`) |
| H | Hub / Licença | Required HubSpot Hub + license tier (green `#E2EFDA`) |
| I | Status | Dropdown: A fazer / Em andamento / Concluído / Backlog / Impedido |
| J | Responsável | Assigned person |
| K | Shirt | Dropdown: S / M / L / XL |
| L | Horas | Estimated hours (e.g. 8h) |
| M | MoSCoW | Dropdown: Must / Should / Could / Won't |
| N | Início | Start date (DD/MM) |
| O | Fim | End date (DD/MM) |

Columns G and H are filled automatically via Gemini with HubSpot technical recommendations.

### Task columns (P–T) — filled manually

These columns are always blank when generated. Use them to track the corresponding ClickUp task. Header color: dark slate `#44546A`.

| Col | Column | Description |
|-----|--------|-------------|
| P | Lista ou ID | ClickUp list name or task ID |
| Q | Título | Task title |
| R | Descrição (contexto) | Task description or context notes |
| S | Responsável (Assignee) | Person assigned to the ClickUp task |
| T | Status (tarefa) | Current status of the ClickUp task |

---

## Gemini model fallback

If `gemini-2.5-flash` is unavailable (503/429), the watcher automatically retries with:

1. `gemini-2.5-flash`
2. `gemini-2.5-flash-lite`
3. `gemini-3-flash-preview`

Rate limit (429) and service unavailability (503) errors trigger exponential backoff (4s → 8s → 16s) before moving to the next model.

---

## State tracking

Processed doc IDs are saved in `processed_meetings.json`. To reprocess a meeting, remove its entry from that file.

```json
{
  "abc123": {
    "name": "Weekly Client 2025-04-08",
    "task_url": "https://app.clickup.com/t/...",
    "processed_at": "2025-04-08T10:30:00"
  }
}
```

Logs are written to `watcher.log` in the project root.

---

## Project structure

```
projetista-jarbas/
├── meeting_watcher.py       # Main script
├── requirements.txt         # Python dependencies
├── .env.example             # Environment variables template
├── .env                     # Your API keys (not committed)
├── setup_scheduler.bat      # Windows Task Scheduler setup
├── processed_meetings.json  # State tracker (not committed)
└── watcher.log              # Runtime log (not committed)
```

---

## Dependencies

| Package | Purpose |
|---------|---------|
| `openpyxl` | Excel generation with styles, dropdowns, conditional fills |

All HTTP calls use Python's built-in `urllib` — no extra dependencies.

---

Built by [EPIC Digital](https://epic.digital) — Revenue Architecture consultancy.
