@echo off
echo ========================================
echo  COMPILAR E INSTALAR ANTIVIRUS IA
echo ========================================
echo.

echo Passo 1: Parando processos...
call parar_todos.bat

echo.
echo Passo 2: Compilando projeto...
dotnet build AntivirusIA.sln -c Release
if %errorLevel% neq 0 (
    echo [ERRO] Falha na compilacao!
    pause
    exit /b 1
)

echo.
echo Passo 3: Copiando arquivos de rede...
copy /Y "AntivirusIA.Network\bin\Release\net10.0\AntivirusIA.Network.exe" "AntivirusIA\bin\Release\net10.0-windows\" >nul
copy /Y "AntivirusIA.Network\bin\Release\net10.0\*.dll" "AntivirusIA\bin\Release\net10.0-windows\" >nul

echo.
echo Passo 4: Instalando...
call instalar_simples.bat

echo.
echo ========================================
echo     COMPILACAO E INSTALACAO CONCLUIDA!
echo ========================================