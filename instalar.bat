@echo off
echo ========================================
echo    INSTALADOR ANTIVIRUS IA - v1.0
echo ========================================
echo.

:: Verifica se está executando como administrador
net session >nul 2>&1
if %errorLevel% == 0 (
    echo [OK] Executando como administrador
) else (
    echo [ERRO] Este instalador precisa ser executado como administrador!
    echo.
    echo Clique com o botao direito no arquivo e selecione "Executar como administrador"
    pause
    exit /b 1
)

echo.
echo Parando processos anteriores...
taskkill /f /im AntivirusIA.exe >nul 2>&1
taskkill /f /im AntivirusIA.Network.exe >nul 2>&1
timeout /t 2 >nul

echo.
echo Verificando arquivos compilados...
if not exist "AntivirusIA\bin\Release\net10.0-windows\AntivirusIA.exe" (
    echo [ERRO] AntivirusIA.exe nao encontrado!
    echo Execute primeiro: .\executar.bat
    pause
    exit /b 1
)

if not exist "AntivirusIA.Network\bin\Release\net10.0\AntivirusIA.Network.exe" (
    echo [ERRO] AntivirusIA.Network.exe nao encontrado!
    echo Execute primeiro: .\executar.bat
    pause
    exit /b 1
)

echo [OK] Arquivos compilados encontrados

echo.
echo Criando diretorio de instalacao...
set "INSTALL_DIR=C:\Program Files (x86)\anti-virus-mapas"
if exist "%INSTALL_DIR%" (
    echo Removendo instalacao anterior...
    rmdir /s /q "%INSTALL_DIR%" >nul 2>&1
)
mkdir "%INSTALL_DIR%" >nul 2>&1

echo.
echo Copiando arquivos do antivirus...
copy /Y "AntivirusIA\bin\Release\net10.0-windows\AntivirusIA.exe" "%INSTALL_DIR%\" >nul
if %errorLevel% neq 0 (
    echo [ERRO] Falha ao copiar AntivirusIA.exe
    pause
    exit /b 1
)

copy /Y "AntivirusIA.Network\bin\Release\net10.0\AntivirusIA.Network.exe" "%INSTALL_DIR%\" >nul
if %errorLevel% neq 0 (
    echo [ERRO] Falha ao copiar AntivirusIA.Network.exe
    pause
    exit /b 1
)

echo Copiando bibliotecas...
copy /Y "AntivirusIA\bin\Release\net10.0-windows\*.dll" "%INSTALL_DIR%\" >nul
copy /Y "AntivirusIA\bin\Release\net10.0-windows\*.json" "%INSTALL_DIR%\" >nul 2>&1
copy /Y "AntivirusIA\bin\Release\net10.0-windows\*.runtimeconfig.json" "%INSTALL_DIR%\" >nul 2>&1

echo.
echo Criando atalhos...
:: Atalho na Area de Trabalho
set "DESKTOP=%USERPROFILE%\Desktop"
powershell -Command "$WshShell = New-Object -ComObject WScript.Shell; $Shortcut = $WshShell.CreateShortcut('%DESKTOP%\Antivirus IA.lnk'); $Shortcut.TargetPath = '%INSTALL_DIR%\AntivirusIA.exe'; $Shortcut.Description = 'Antivirus com IA'; $Shortcut.Save()" >nul 2>&1

:: Atalho no Menu Iniciar
set "STARTMENU=%APPDATA%\Microsoft\Windows\Start Menu\Programs"
powershell -Command "$WshShell = New-Object -ComObject WScript.Shell; $Shortcut = $WshShell.CreateShortcut('%STARTMENU%\Antivirus IA.lnk'); $Shortcut.TargetPath = '%INSTALL_DIR%\AntivirusIA.exe'; $Shortcut.Description = 'Antivirus com IA'; $Shortcut.Save()" >nul 2>&1

echo.
echo Criando script de desinstalacao...
(
echo @echo off
echo echo Desinstalando Antivirus IA...
echo taskkill /f /im AntivirusIA.exe ^>nul 2^>^&1
echo taskkill /f /im AntivirusIA.Network.exe ^>nul 2^>^&1
echo timeout /t 2 ^>nul
echo rmdir /s /q "%INSTALL_DIR%" ^>nul 2^>^&1
echo del "%DESKTOP%\Antivirus IA.lnk" ^>nul 2^>^&1
echo del "%STARTMENU%\Antivirus IA.lnk" ^>nul 2^>^&1
echo echo Antivirus IA desinstalado com sucesso!
echo pause
) > "%INSTALL_DIR%\desinstalar.bat"

echo.
echo Registrando no sistema...
:: Adiciona ao registro do Windows (opcional)
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\AntivirusIA" /v "DisplayName" /t REG_SZ /d "Antivirus IA" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\AntivirusIA" /v "UninstallString" /t REG_SZ /d "%INSTALL_DIR%\desinstalar.bat" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\AntivirusIA" /v "InstallLocation" /t REG_SZ /d "%INSTALL_DIR%" /f >nul 2>&1

echo.
echo ========================================
echo        INSTALACAO CONCLUIDA!
echo ========================================
echo.
echo Local de instalacao: %INSTALL_DIR%
echo.
echo Atalhos criados:
echo - Area de Trabalho: Antivirus IA
echo - Menu Iniciar: Antivirus IA
echo.
echo Para desinstalar: Execute desinstalar.bat na pasta de instalacao
echo.
set /p "START=Deseja iniciar o Antivirus IA agora? (S/N): "
if /i "%START%"=="S" (
    echo.
    echo Iniciando Antivirus IA...
    start "" "%INSTALL_DIR%\AntivirusIA.exe"
    echo.
    echo Antivirus IA iniciado com sucesso!
) else (
    echo.
    echo Voce pode iniciar o Antivirus IA pelo atalho na Area de Trabalho
)

echo.
echo Pressione qualquer tecla para sair...
pause >nul