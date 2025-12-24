@echo off
echo ========================================
echo    TESTANDO SOLICITACAO DE PERMISSOES
echo ========================================
echo.

:: SOLICITA PERMISSOES DE ADMINISTRADOR AUTOMATICAMENTE
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

if '%errorlevel%' NEQ '0' (
    echo ⚠️ SEM PERMISSOES DE ADMINISTRADOR
    echo.
    echo Este programa precisa de permissoes de administrador
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

echo ✅ PERMISSOES DE ADMINISTRADOR CONCEDIDAS!
echo.
echo Agora o programa pode:
echo - Escrever em C:\Program Files (x86)
echo - Criar atalhos no sistema
echo - Instalar serviços
echo - Modificar registro do Windows
echo.
echo Teste concluído com sucesso!
echo.
pause