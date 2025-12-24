@echo off
:: SOLICITA PERMISSOES DE ADMINISTRADOR AUTOMATICAMENTE
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

if '%errorlevel%' NEQ '0' (
    echo ========================================
    echo    SOLICITANDO PERMISSOES DE ADMIN
    echo ========================================
    echo.
    echo Este instalador precisa de permissoes de administrador
    echo para instalar em C:\Program Files (x86)
    echo.
    echo Clique em SIM na janela que vai aparecer...
    echo.
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"

echo ========================================
echo    INSTALADOR ANTIVIRUS IA - SIMPLES
echo    EXECUTANDO COMO ADMINISTRADOR
echo ========================================
echo.

echo Parando processos anteriores...
taskkill /f /im AntivirusIA.exe >nul 2>&1
taskkill /f /im AntivirusIA.Network.exe >nul 2>&1
timeout /t 2 >nul

echo.
echo Criando diretorio de instalacao...
set "INSTALL_DIR=C:\Program Files (x86)\anti-virus-mapas"
if exist "%INSTALL_DIR%" (
    echo Removendo instalacao anterior...
    rmdir /s /q "%INSTALL_DIR%" >nul 2>&1
)
mkdir "%INSTALL_DIR%" >nul 2>&1

echo.
echo Verificando arquivos...
if not exist "AntivirusIA\bin\Release\net10.0-windows\AntivirusIA.exe" (
    echo [ERRO] AntivirusIA.exe nao encontrado!
    echo.
    echo Execute primeiro:
    echo   .\executar.bat
    echo.
    echo Ou compile manualmente:
    echo   dotnet build AntivirusIA.sln -c Release
    echo.
    pause
    exit /b 1
)

echo [OK] Arquivos encontrados
echo.
echo Copiando arquivos...

:: Cria subpastas para organizar os apps
mkdir "%INSTALL_DIR%\AntivirusIA" >nul 2>&1
mkdir "%INSTALL_DIR%\navegador" >nul 2>&1
mkdir "%INSTALL_DIR%\ia-app" >nul 2>&1
mkdir "%INSTALL_DIR%\AntivirusIA.Network" >nul 2>&1

:: Copia AntivirusIA completo
xcopy /Y /E "AntivirusIA\bin\Release\net10.0-windows\*" "%INSTALL_DIR%\AntivirusIA\" >nul 2>&1
echo - AntivirusIA (pasta completa)

:: Copia Maps Browser
if exist "navegador\bin\Release\net10.0-windows\" (
    xcopy /Y /E "navegador\bin\Release\net10.0-windows\*" "%INSTALL_DIR%\navegador\" >nul 2>&1
    echo - Maps Browser
) else (
    echo - Maps Browser [NAO ENCONTRADO]
)

:: Copia IA Assistant
if exist "ia-app\bin\Release\net10.0-windows\" (
    xcopy /Y /E "ia-app\bin\Release\net10.0-windows\*" "%INSTALL_DIR%\ia-app\" >nul 2>&1
    echo - IA Assistant
) else (
    echo - IA Assistant [NAO ENCONTRADO]
)

:: Copia serviço de rede
xcopy /Y /E "AntivirusIA.Network\bin\Release\net10.0\*" "%INSTALL_DIR%\AntivirusIA.Network\" >nul 2>&1
echo - Servico de Rede

:: Copia executável principal para raiz (compatibilidade)
copy /Y "AntivirusIA\bin\Release\net10.0-windows\AntivirusIA.exe" "%INSTALL_DIR%\" >nul 2>&1
copy /Y "AntivirusIA.Network\bin\Release\net10.0\AntivirusIA.Network.exe" "%INSTALL_DIR%\" >nul 2>&1

echo.
echo Criando atalhos...

set "DESKTOP=%USERPROFILE%\Desktop"
set "STARTMENU=%APPDATA%\Microsoft\Windows\Start Menu\Programs"

:: Atalho AntivirusIA
echo Set oWS = WScript.CreateObject("WScript.Shell") > "%TEMP%\shortcut1.vbs"
echo sLinkFile = "%DESKTOP%\AntivirusIA - Mapas.lnk" >> "%TEMP%\shortcut1.vbs"
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> "%TEMP%\shortcut1.vbs"
echo oLink.TargetPath = "%INSTALL_DIR%\AntivirusIA\AntivirusIA.exe" >> "%TEMP%\shortcut1.vbs"
echo oLink.WorkingDirectory = "%INSTALL_DIR%\AntivirusIA" >> "%TEMP%\shortcut1.vbs"
echo oLink.Description = "Antivirus IA - Protecao Inteligente" >> "%TEMP%\shortcut1.vbs"
echo oLink.Save >> "%TEMP%\shortcut1.vbs"
cscript "%TEMP%\shortcut1.vbs" >nul 2>&1
del "%TEMP%\shortcut1.vbs" >nul 2>&1
echo - AntivirusIA (Area de Trabalho)

:: Atalho Maps Browser
if exist "%INSTALL_DIR%\navegador\MapsBrowser.exe" (
    echo Set oWS = WScript.CreateObject("WScript.Shell") > "%TEMP%\shortcut2.vbs"
    echo sLinkFile = "%DESKTOP%\Maps Browser - Mapas.lnk" >> "%TEMP%\shortcut2.vbs"
    echo Set oLink = oWS.CreateShortcut(sLinkFile) >> "%TEMP%\shortcut2.vbs"
    echo oLink.TargetPath = "%INSTALL_DIR%\navegador\MapsBrowser.exe" >> "%TEMP%\shortcut2.vbs"
    echo oLink.WorkingDirectory = "%INSTALL_DIR%\navegador" >> "%TEMP%\shortcut2.vbs"
    echo oLink.Description = "Maps Browser - Navegacao Segura Mapas" >> "%TEMP%\shortcut2.vbs"
    echo oLink.Save >> "%TEMP%\shortcut2.vbs"
    cscript "%TEMP%\shortcut2.vbs" >nul 2>&1
    del "%TEMP%\shortcut2.vbs" >nul 2>&1
    echo - Maps Browser (Area de Trabalho)
)

:: Atalho IA Assistant
if exist "%INSTALL_DIR%\ia-app\IAApp.exe" (
    echo Set oWS = WScript.CreateObject("WScript.Shell") > "%TEMP%\shortcut3.vbs"
    echo sLinkFile = "%DESKTOP%\IA Assistant - Mapas.lnk" >> "%TEMP%\shortcut3.vbs"
    echo Set oLink = oWS.CreateShortcut(sLinkFile) >> "%TEMP%\shortcut3.vbs"
    echo oLink.TargetPath = "%INSTALL_DIR%\ia-app\IAApp.exe" >> "%TEMP%\shortcut3.vbs"
    echo oLink.WorkingDirectory = "%INSTALL_DIR%\ia-app" >> "%TEMP%\shortcut3.vbs"
    echo oLink.Description = "IA Assistant - Assistente Inteligente" >> "%TEMP%\shortcut3.vbs"
    echo oLink.Save >> "%TEMP%\shortcut3.vbs"
    cscript "%TEMP%\shortcut3.vbs" >nul 2>&1
    del "%TEMP%\shortcut3.vbs" >nul 2>&1
    echo - IA Assistant (Area de Trabalho)
)

:: Atalho no Menu Iniciar (AntivirusIA principal)
echo Set oWS = WScript.CreateObject("WScript.Shell") > "%TEMP%\shortcut4.vbs"
echo sLinkFile = "%STARTMENU%\AntivirusIA - Mapas.lnk" >> "%TEMP%\shortcut4.vbs"
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> "%TEMP%\shortcut4.vbs"
echo oLink.TargetPath = "%INSTALL_DIR%\AntivirusIA\AntivirusIA.exe" >> "%TEMP%\shortcut4.vbs"
echo oLink.WorkingDirectory = "%INSTALL_DIR%\AntivirusIA" >> "%TEMP%\shortcut4.vbs"
echo oLink.Description = "Antivirus IA - Protecao Inteligente" >> "%TEMP%\shortcut4.vbs"
echo oLink.Save >> "%TEMP%\shortcut4.vbs"
cscript "%TEMP%\shortcut4.vbs" >nul 2>&1
del "%TEMP%\shortcut4.vbs" >nul 2>&1
echo - AntivirusIA (Menu Iniciar)

echo.
echo Criando desinstalador...
(
echo @echo off
echo echo Desinstalando Antivirus IA...
echo taskkill /f /im AntivirusIA.exe ^>nul 2^>^&1
echo taskkill /f /im AntivirusIA.Network.exe ^>nul 2^>^&1
echo timeout /t 2 ^>nul
echo rmdir /s /q "%INSTALL_DIR%" ^>nul 2^>^&1
echo del "%DESKTOP%\Antivirus IA.lnk" ^>nul 2^>^&1
echo del "%STARTMENU%\Antivirus IA.lnk" ^>nul 2^>^&1
echo echo Antivirus IA desinstalado!
echo pause
) > "%INSTALL_DIR%\desinstalar.bat"

echo.
echo ========================================
echo        INSTALACAO CONCLUIDA!
echo ========================================
echo.
echo Local: %INSTALL_DIR%
echo.
echo Atalhos criados na Area de Trabalho:
echo - AntivirusIA - Mapas
if exist "%INSTALL_DIR%\navegador\MapsBrowser.exe" echo - Maps Browser - Mapas
if exist "%INSTALL_DIR%\ia-app\IAApp.exe" echo - IA Assistant - Mapas
echo.
echo Estrutura de pastas:
echo %INSTALL_DIR%\
echo   ├── AntivirusIA\          (Antivirus principal)
echo   ├── navegador\            (Maps Browser)
echo   ├── ia-app\               (IA Assistant)
echo   └── AntivirusIA.Network\  (Servico de rede)
echo.
echo TODOS OS APPS ESTAO NA MESMA PASTA!
echo.
set /p "START=Iniciar AntivirusIA agora? (S/N): "
if /i "%START%"=="S" (
    start "" "%INSTALL_DIR%\AntivirusIA\AntivirusIA.exe"
    echo AntivirusIA iniciado!
)

echo.
pause