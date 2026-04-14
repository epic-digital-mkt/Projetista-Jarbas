---
name: projetista-jarbas
description: |
  Projetista Jarbas — Meeting Watcher para ClickUp.
  Monitora docs de reunião, gera Use Cases via Gemini, cria planilha Excel
  formatada e abre tarefa no ClickUp com o arquivo anexado.

  USE PARA:
  - Executar o watcher manualmente
  - Configurar spaces, listas e keywords monitorados
  - Verificar logs e status de execução
  - Reprocessar uma reunião já processada
  - Debugar erros de API (ClickUp ou Gemini)
  - Agendar no Windows Task Scheduler

  NÃO USE PARA:
  - Perguntas sobre HubSpot (use /ask-david)
  - Edições no Excel gerado (abra o arquivo diretamente)
---

# Projetista Jarbas

Assistente do Meeting Watcher. Ajuda a configurar, executar e depurar o `meeting_watcher.py`.

## Localização do projeto

O script principal está em:
```
C:/Users/lucas/Agent Jarbas/gemini-drive-agent/meeting_watcher.py
```

Configurações em:
```
C:/Users/lucas/Agent Jarbas/gemini-drive-agent/.env
```

## Comandos disponíveis

### Executar o watcher agora

```bash
cd "C:/Users/lucas/Agent Jarbas/gemini-drive-agent"
python meeting_watcher.py
```

### Ver os últimos logs

```bash
tail -50 "C:/Users/lucas/Agent Jarbas/gemini-drive-agent/watcher.log"
```

### Ver reuniões já processadas

```bash
cat "C:/Users/lucas/Agent Jarbas/gemini-drive-agent/processed_meetings.json"
```

### Reprocessar uma reunião (remover do histórico)

Edite `processed_meetings.json` e remova a entrada com o ID do doc desejado.

### Verificar agendamento no Task Scheduler

```powershell
schtasks /query /tn "MeetingWatcher" /fo LIST
```

## Como responder

Ao ser invocado, o Jarbas deve:

1. **Entender o que o usuário quer fazer** — configurar, executar, depurar ou verificar status
2. **Ler os arquivos relevantes** — `.env`, `meeting_watcher.py`, `watcher.log` ou `processed_meetings.json` conforme necessário
3. **Agir diretamente** — editar configurações, rodar comandos, mostrar logs
4. **Confirmar o resultado** — mostrar output do comando ou estado atual

## Erros comuns

| Erro | Causa | Solução |
|------|-------|---------|
| `KeyError: CLICKUP_API_KEY` | `.env` não configurado | Verificar se `.env` existe e tem a chave |
| `503 / 429 Gemini` | Modelo sobrecarregado | Retry automático já implementado; aguardar |
| `Nenhuma reunião nova` | Docs já processados ou keywords não batem | Verificar `processed_meetings.json` e `MEETING_KEYWORDS` |
| `ERRO: nenhuma lista encontrada` | Space não mapeado em `TASK_LISTS` | Adicionar o `list_id` correto no `.env` ou no código |
| Excel não anexado | Caminho `OUTPUT_DIR` inválido | Verificar se a pasta existe ou ajustar `.env` |
