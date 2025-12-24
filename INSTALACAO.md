# 🛡️ Antivírus IA - Guia de Instalação

## 📋 Requisitos do Sistema

- **Sistema Operacional:** Windows 10/11 (64-bit)
- **Framework:** .NET 10.0 ou superior
- **Memória:** Mínimo 2GB RAM
- **Espaço:** 500MB livres
- **Permissões:** Administrador (para instalação)

## 🚀 Instalação Automática

### 1. Executar como Administrador
```bash
# Clique com botão direito em "instalar.bat"
# Selecione "Executar como administrador"
```

### 2. Ou via linha de comando:
```bash
# Abra CMD/PowerShell como administrador
.\instalar.bat
```

## 📁 Localização da Instalação

```
C:\Program Files (x86)\anti-virus-mapas\
├── AntivirusIA.exe              # Programa principal
├── AntivirusIA.Network.exe      # Serviço de rede
├── *.dll                       # Bibliotecas necessárias
└── desinstalar.bat             # Script de desinstalação
```

## 🔗 Atalhos Criados

- **Área de Trabalho:** `Antivírus IA.lnk`
- **Menu Iniciar:** `Programas > Antivírus IA`

## ⚙️ Funcionalidades Instaladas

✅ **Interface Principal** - Controle completo do antivírus
✅ **Serviço de Rede** - Sincronização com Google Drive (invisível)
✅ **Proteção em Tempo Real** - Monitoramento contínuo
✅ **Chat com IA** - Assistente inteligente
✅ **Bandeja do Sistema** - Execução em segundo plano
✅ **Atalhos Automáticos** - Fácil acesso

## 🗑️ Desinstalação

### Método 1: Script Automático
```bash
# Execute como administrador:
C:\Program Files (x86)\anti-virus-mapas\desinstalar.bat
```

### Método 2: Script Local
```bash
# Na pasta do projeto:
.\desinstalar.bat
```

### Método 3: Painel de Controle
```
Configurações > Aplicativos > Antivírus IA > Desinstalar
```

## 🔧 Solução de Problemas

### Erro: "Precisa ser executado como administrador"
- Clique com botão direito no arquivo .bat
- Selecione "Executar como administrador"

### Erro: ".NET não encontrado"
- Baixe e instale .NET 10.0 do site oficial da Microsoft

### Erro: "Falha na compilação"
- Verifique se todos os arquivos estão presentes
- Execute `dotnet --version` para verificar o .NET

### Antivírus não inicia
- Verifique se o Windows Defender não está bloqueando
- Execute como administrador
- Verifique os logs em `error.log`

## 📞 Suporte

- **Logs:** Verifique `error.log` e `network_service.log`
- **Processos:** Use Task Manager para verificar se está rodando
- **Rede:** Botões "Parar Rede" e "Reiniciar Rede" na interface

## 🔄 Atualização

Para atualizar:
1. Execute o desinstalador
2. Baixe a nova versão
3. Execute o instalador novamente

---

**Desenvolvido com .NET 10.0 e ❤️**