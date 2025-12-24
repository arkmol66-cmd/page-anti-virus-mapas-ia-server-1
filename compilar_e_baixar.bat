@echo off
echo ========================================
echo    COMPILAR E BAIXAR TODOS OS APPS
echo ========================================
echo.

echo [1/5] Compilando AntivirusIA...
dotnet build AntivirusIA/AntivirusIA.csproj -c Debug --nologo -v q
if %errorlevel% neq 0 (
    echo ❌ Erro ao compilar AntivirusIA
    pause
    exit /b 1
)
echo ✅ AntivirusIA compilado

echo [2/5] Compilando Maps Browser...
dotnet build navegador/GoogleBrowser.csproj -c Debug --nologo -v q
if %errorlevel% neq 0 (
    echo ❌ Erro ao compilar navegador
    pause
    exit /b 1
)
echo ✅ Navegador compilado

echo [3/5] Compilando IA Assistant...
dotnet build ia-app/IAApp.csproj -c Debug --nologo -v q
if %errorlevel% neq 0 (
    echo ❌ Erro ao compilar IA Assistant
    pause
    exit /b 1
)
echo ✅ IA Assistant compilado

echo [4/5] Compilando Network Service...
dotnet build AntivirusIA.Network/AntivirusIA.Network.csproj -c Debug --nologo -v q
if %errorlevel% neq 0 (
    echo ❌ Erro ao compilar Network Service
    pause
    exit /b 1
)
echo ✅ Network Service compilado

echo.
echo ========================================
echo    TODOS OS APPS COMPILADOS!
echo ========================================
echo.
echo [5/5] Executando baixar.bat...
echo.

call baixar.bat

echo.
echo ========================================
echo    PROCESSO CONCLUIDO!
echo ========================================
pause