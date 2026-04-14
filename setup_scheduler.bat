@echo off
REM Cria a tarefa no Windows Task Scheduler para rodar o watcher a cada 1 hora
REM Execute como Administrador

set PYTHON=python
set SCRIPT=%~dp0meeting_watcher.py

powershell -Command "& { $action = New-ScheduledTaskAction -Execute '%PYTHON%' -Argument '\"%SCRIPT%\"' -WorkingDirectory '%~dp0'; $trigger = New-ScheduledTaskTrigger -RepetitionInterval (New-TimeSpan -Hours 1) -Once -At (Get-Date); $settings = New-ScheduledTaskSettingsSet -ExecutionTimeLimit (New-TimeSpan -Minutes 10); Register-ScheduledTask -TaskName 'MeetingWatcher' -Action $action -Trigger $trigger -Settings $settings -Force }"

echo.
echo Tarefa criada. Verificando...
schtasks /query /tn "MeetingWatcher"
pause
