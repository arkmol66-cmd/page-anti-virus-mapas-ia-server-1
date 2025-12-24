@echo off
echo Parando todos os processos do AntivirusIA...
taskkill /f /im AntivirusIA.exe >nul 2>&1
taskkill /f /im AntivirusIA.Network.exe >nul 2>&1
timeout /t 2 >nul
echo Processos encerrados.