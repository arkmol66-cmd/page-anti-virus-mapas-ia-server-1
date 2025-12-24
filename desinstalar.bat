@echo off
echo ========================================
echo   DESINSTALADOR ANTIVIRUS IA - v1.0
echo ========================================
echo.

:: Verifica se está executando como administrador
net session >nul 2>&1
if %errorLevel% == 0 (
    echo [OK] Executando como administrador
) else (
    echo [ERRO] Este desinstalador precisa ser executado como administrador!
    echo.
    echo Clique com o botao direito no arquivo e selecione "Executar como administrador"
    pause
    exit /b 1
)

echo.
set /p "CONFIRM=Tem certeza que deseja desinstalar o Antivirus IA? (S/N): "
if /i not "%CONFIRM%"=="S" (
    echo Desinstalacao cancelada.
    pause
    exit /b 0
)

echo.
echo Parando processos do Antivirus IA...
taskkill /f /im AntivirusIA.exe >nul 2>&1
taskkill /f /im AntivirusIA.Network.exe >nul 2>&1
timeout /t 3 >nul

echo.
echo Removendo arquivos...
set "INSTALL_DIR=C:\Program Files (x86)\anti-virus-mapas"
if exist "%INSTALL_DIR%" (
    rmdir /s /q "%INSTALL_DIR%" >nul 2>&1
    if exist "%INSTALL_DIR%" (
        echo [AVISO] Alguns arquivos podem estar em uso. Tente reiniciar o computador.
    ) else (
        echo [OK] Arquivos removidos
    )
) else (
    echo [INFO] Pasta de instalacao nao encontrada
)

echo.
echo Removendo atalhos...
set "DESKTOP=%USERPROFILE%\Desktop"
set "STARTMENU=%APPDATA%\Microsoft\Windows\Start Menu\Programs"
del "%DESKTOP%\Antivirus IA.lnk" >nul 2>&1
del "%STARTMENU%\Antivirus IA.lnk" >nul 2>&1
echo [OK] Atalhos removidos

echo.
echo Removendo entradas do registro...
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\AntivirusIA" /f >nul 2>&1
echo [OK] Registro limpo

echo.
echo ========================================
echo      DESINSTALACAO CONCLUIDA!
echo ========================================
echo.
echo O Antivirus IA foi removido do seu computador.
echo.
echo Obrigado por usar o Antivirus IA!
echo.
pause