@echo off
:: SOLICITA PERMISSOES DE ADMINISTRADOR AUTOMATICAMENTE
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

if '%errorlevel%' NEQ '0' (
    echo ========================================
    echo    SOLICITANDO PERMISSOES DE ADMIN
    echo ========================================
    echo.
    echo Este programa precisa de permissoes de administrador
    echo para copiar os arquivos para C:\Program Files (x86)
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
echo    PERMISSOES DE ADMIN CONCEDIDAS!
echo ========================================
cd /d "C:\Program Files (x86)"
md anti-virus-mapas 2>nul
cd anti-virus-mapas
echo ========================================
echo    MAPAS CORPORACOES - BAIXAR APPS
echo ========================================
echo Bem-vindo ao sistema de download da Mapas!
echo Vamos copiar todos os aplicativos pre-baixados...
echo.
echo Apps incluidos:
echo - AntivirusIA (Protecao completa)
echo - Maps Browser (Navegador Mapas)  
echo - IA Assistant (Assistente de IA)
echo - Servico de Rede (Network)
echo.
echo Iniciando copia...
timeout /t 3 /nobreak >nul

echo [1/4] Copiando AntivirusIA...
xcopy "%~dp0AntivirusIA\bin\Debug\net10.0-windows\*" "AntivirusIA\" /E /I /Y /Q 2>nul
if exist "AntivirusIA\AntivirusIA.exe" (
    echo ✓ AntivirusIA copiado com sucesso
) else (
    echo ✗ Erro ao copiar AntivirusIA
)

echo [2/4] Copiando Maps Browser...
xcopy "%~dp0navegador\bin\Debug\net10.0-windows\*" "navegador\" /E /I /Y /Q 2>nul
if exist "navegador\MapsBrowser.exe" (
    echo ✓ Maps Browser copiado com sucesso
) else (
    echo ✗ Erro ao copiar navegador
)

echo [3/4] Copiando IA Assistant...
xcopy "%~dp0ia-app\bin\Debug\net10.0-windows\*" "ia-app\" /E /I /Y /Q 2>nul
if exist "ia-app\IAApp.exe" (
    echo ✓ IA Assistant copiado com sucesso
) else (
    echo ✗ Erro ao copiar IA Assistant
)

echo [4/4] Copiando Servico de Rede...
xcopy "%~dp0AntivirusIA.Network\bin\Debug\net10.0\*" "AntivirusIA.Network\" /E /I /Y /Q 2>nul
if exist "AntivirusIA.Network\AntivirusIA.Network.exe" (
    echo ✓ Servico de Rede copiado com sucesso
) else (
    echo ✗ Erro ao copiar Servico de Rede
)

echo.
echo ========================================
echo           COPIA CONCLUIDA!
echo ========================================
echo Todos os aplicativos foram copiados para:
echo C:\Program Files ^(x86^)\anti-virus-mapas\
echo.
echo Para executar:
echo - AntivirusIA\AntivirusIA.exe
echo - navegador\MapsBrowser.exe  
echo - ia-app\IAApp.exe
echo.
echo Pressione qualquer tecla para continuar...
pause >nul