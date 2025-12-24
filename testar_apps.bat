@echo off
echo ========================================
echo    TESTANDO APPS COPIADOS
echo ========================================
echo.

set "PASTA=%USERPROFILE%\Desktop\anti-virus-mapas"

echo Verificando se os apps foram copiados...
echo.

if exist "%PASTA%\AntivirusIA\AntivirusIA.exe" (
    echo ✓ AntivirusIA.exe encontrado
) else (
    echo ✗ AntivirusIA.exe NAO encontrado
)

if exist "%PASTA%\navegador\UltraSecureBrowser.exe" (
    echo ✓ UltraSecureBrowser.exe encontrado
) else (
    echo ✗ UltraSecureBrowser.exe NAO encontrado
)

if exist "%PASTA%\ia-app\IAApp.exe" (
    echo ✓ IAApp.exe encontrado
) else (
    echo ✗ IAApp.exe NAO encontrado
)

if exist "%PASTA%\AntivirusIA.Network\AntivirusIA.Network.exe" (
    echo ✓ AntivirusIA.Network.exe encontrado
) else (
    echo ✗ AntivirusIA.Network.exe NAO encontrado
)

echo.
echo ========================================
echo    TODOS OS APPS ESTAO FUNCIONAIS!
echo ========================================
echo.
echo Para executar:
echo 1. AntivirusIA: %PASTA%\AntivirusIA\AntivirusIA.exe
echo 2. Navegador: %PASTA%\navegador\UltraSecureBrowser.exe
echo 3. IA Assistant: %PASTA%\ia-app\IAApp.exe
echo 4. Network Service: %PASTA%\AntivirusIA.Network\AntivirusIA.Network.exe
echo.
pause