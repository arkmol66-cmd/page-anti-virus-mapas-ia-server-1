# Antivírus IA - Proteção Inteligente

Sistema de antivírus com Inteligência Artificial desenvolvido em .NET 8.0 para Windows.

## 🚀 Funcionalidades

- **Proteção em Tempo Real**: Monitora arquivos e rede continuamente
- **Análise Inteligente com IA**: Detecta ameaças usando padrões e heurísticas
- **Rede de IAs Colaborativa**: Compartilha informações de ameaças entre todas as instâncias
- **Proteção de Rede**: Bloqueia sites maliciosos e não seguros
- **Scanner de Arquivos**: Detecta arquivos maliciosos por padrões e comportamento

## 📋 Requisitos

- Windows 10/11
- .NET 8.0 SDK ou superior
- Visual Studio 2022 (opcional)

## 🔧 Instalação

1. Clone o repositório:
```bash
git clone https://github.com/arkmol66-cmd/anti-virus-com-ia.git
cd anti-virus-com-ia
```

2. Compile o projeto:
```bash
dotnet build AntivirusIA.sln
```

3. Execute o antivírus:
```bash
dotnet run --project AntivirusIA
```

## 🛡️ Como Usar

1. **Escanear Sistema**: Clique em "Escanear Sistema" para análise completa
2. **Proteção em Tempo Real**: Ative para monitoramento contínuo
3. **Sincronização Automática**: A IA sincroniza automaticamente com a rede a cada 5 minutos

## 🤖 Rede de IAs

O sistema sincroniza dados com repositório GitHub:

- **Conversas entre IAs** (privadas): `ias-conservas/*.1`
- **Arquivos maliciosos**: `ia-denfender/arquivos-malisiosos/`
- **Sites maliciosos**: `ia-denfender/sites-malisiosos/*.sites.malisiosos`
- **Sites não seguros**: `ia-denfender/sites-não-seguros/*.q.sites.nao.seguro`
- **Conversas com usuário**: `ia-denfender/consersas-com-o-usuario/*.comjjh`

## 📁 Estrutura de Arquivos Locais

```
sync/
├── ias-conservas/          # Conversas privadas entre IAs
├── arquivos-malisiosos/    # Base de arquivos maliciosos
├── sites-malisiosos/       # Sites bloqueados
├── sites-nao-seguros/      # Sites com avisos
└── conversas-com-usuario/  # Histórico de interações
```

## ⚠️ Avisos

- As conversas entre IAs são privadas e não acessíveis ao usuário
- O sistema requer permissões de administrador para proteção completa
- Mantenha o antivírus sempre atualizado

## 📝 Licença

MIT License - Veja LICENSE para detalhes
