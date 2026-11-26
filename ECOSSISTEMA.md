# Ecossistema CloudStream — mapa completo

Levantamento feito em 26/11/2026 pela API do GitHub. Organização: `recloudstream`.

> **Nota:** este é um levantamento técnico/histórico de código upstream sob GPL/LGPL. O projeto CloudBrasil não usa servidores, contas, Discord, downloads ou serviços da organização citada; os links abaixo servem apenas como referência de código.

## Resumo

| Grupo | Repositórios | O que faz |
|---|---|---|
| **App** | `cloudstream` | O aplicativo Android em si |
| **Build de extensões** | `gradle`, `extensions`, `TestPlugins` | Plugin Gradle, coleção de extensões e plugins de teste |
| **Distribuição** | `cs-repos`, `maven` | Lista de repositórios de plugins e dependências publicadas |
| **Documentação** | `csdocs`, `recloudstream.github.io`, `dokka` | Docs, site e API gerada |
| **Histórico** | `cloudstream-archive`, `cloudstream-sync` | Versões antigas e sincronização |
| **Bibliotecas** | `NewPipeExtractor`, `UniFile`, `NiceHttp`, `libass`, `media-ffmpeg` | Extração, arquivos, HTTP, legendas e ffmpeg |
| **Player/rede** | `Aria2cStream`, `torrentserver`, `csredirect`, `GPUVideo-android` | Streaming alternativo, torrent, redirecionamento e filtros de vídeo |
| **Apps auxiliares** | `golang-mobile`, `color-picker-android`, `anime-db` | Build Go mobile, seletor de cor e base de animes |
| **Bots** | `cs-bot`, `discord-commands`, `public-gateway-checker` | Bot do Discord, comandos e checagem de gateways |

## Tabela completa (25 repositórios)

| Repositório | Papel | Linguagem | Licença | Ativo | Faz parte do app? |
|---|---|---|---|---|---|
| `cloudstream` | Aplicativo Android (player + sistema de plugins) | Kotlin | GPL-3.0 | sim | **Sim — é o app** |
| `gradle` | Plugin Gradle que compila extensões em `.cs3` | Kotlin | LGPL-3.0 | sim | Sim — build das extensões |
| `extensions` | Coleção de extensões oficiais (base e exemplos) | Kotlin | — | sim | Sim — conteúdo |
| `cs-repos` | Lista curada de repositórios de plugins (→ rentry.org/cs3-repos) | Python | — | sim | Sim — distribuição |
| `TestPlugins` | Plugins usados para testar o app | Kotlin | — | sim | Não — desenvolvimento |
| `maven` | Repositório Maven com dependências do projeto | Shell | — | sim | Sim — dependências |
| `csdocs` | Fonte da documentação oficial | CSS | — | sim | Sim — docs |
| `recloudstream.github.io` | Site da organização | HTML | — | sim | Sim — site |
| `dokka` | Documentação de API gerada pelo Dokka | HTML | — | sim | Não — docs geradas |
| `.github` | Arquivos padrão e workflows da organização | — | — | sim | Não — infraestrutura |
| `cloudstream-archive` | Versões antigas do app | — | — | sim | Não — histórico |
| `cloudstream-sync` | Página de sincronização | HTML | — | sim | Não — utilitário |
| `anime-db` | Base de dados de animes usada por extensões | Kotlin | — | sim | Indireto |
| `NewPipeExtractor` | Fork do extrator do NewPipe (YouTube e outros) | Java | GPL-3.0 | sim | Sim — biblioteca |
| `UniFile` | Fork do DocumentFile, acesso a arquivos | Java | Apache-2.0 | sim | Sim — biblioteca |
| `NiceHttp` | Cliente HTTP usado pelas extensões | Kotlin | — | sim | Sim — biblioteca |
| `libass` | Renderização de legendas ASS/SSA | CMake | — | sim | Sim — biblioteca |
| `media-ffmpeg` | Build do ffmpeg para o app | — | — | sim | Sim — biblioteca |
| `Aria2cStream` | Fork: streaming via aria2c | Kotlin | GPL-3.0 | sim | Sim — player |
| `torrentserver` | Fork: servidor torrent local | Go | — | sim | Sim — torrent |
| `golang-mobile` | Fork: Go mobile para compilar o torrentserver | — | BSD-3-Clause | sim | Build |
| `color-picker-android` | Fork: seletor de cores da interface | Java | Apache-2.0 | sim | Sim — UI |
| `csredirect` | Fork: redirecionamento de links | — | — | sim | Indireto |
| `GPUVideo-android` | Fork: filtros de vídeo com GPU | — | MIT | sim | Sim — player |
| `public-gateway-checker` | Fork: checa gateways IPFS online | TypeScript | NOASSERTION | sim | Não — utilitário |
| `cs-bot` | Bot do Discord da comunidade | Go | — | sim | Não — comunidade |
| `discord-commands` | Comandos do bot | JavaScript | — | sim | Não — comunidade |

> Repositórios sem licença declarada no GitHub não podem ser reutilizados sem autorização expressa. Para forks, vale a licença do projeto original.

## Como as peças se encaixam

```
┌──────────────────────────────────────────────────────────────┐
│  cloudstream (app Android)                                   │
│  ┌────────────┐  ┌────────────┐  ┌────────────────────────┐  │
│  │ :app (UI)  │  │ :library   │  │ :shared / :desktopApp  │  │
│  │            │→ │ MainAPI    │  │                        │  │
│  └────────────┘  └─────┬──────┘  └────────────────────────┘  │
│                        │ carrega .cs3                        │
└────────────────────────┼─────────────────────────────────────┘
                         │
        ┌────────────────┴─────────────────┐
        │  repositório de plugins          │
        │  repo.json → plugins.json → .cs3 │
        └────────────────┬─────────────────┘
                         │ compilado por
                 ┌───────┴────────┐
                 │ gradle plugin  │
                 │ + extensão .kt │
                 └────────────────┘
```

1. O usuário instala o **app**.
2. Adiciona um **repositório de plugins** (URL de um `repo.json`).
3. O app baixa o `plugins.json`, mostra as extensões e baixa os `.cs3`.
4. Cada extensão implementa `MainAPI` e é compilada pelo **plugin Gradle**.
5. As bibliotecas (`NiceHttp`, `NewPipeExtractor`, `libass`, `ffmpeg`) dão suporte a rede, extração e reprodução.

## O que um repositório de extensões precisa

| Item | Descrição |
|---|---|
| `build.gradle.kts` raiz | Aplica o plugin `com.github.recloudstream:gradle` e define nome/autor do repo |
| Pasta por extensão | `NomeDaExtensao/build.gradle.kts` + `src/main/kotlin/com/Nome/...` |
| `@CloudstreamPlugin` | Classe que registra a `MainAPI` no app |
| CI | Compila e publica `builds/*.cs3`, `builds/plugins.json` e `builds/repo.json` |
| `repo.json` | Nome, ícone e manifest do repositório |

## Links úteis

- App e documentação (este repositório): https://github.com/RamonMods/CloudStream
- Extensões PT-BR: https://github.com/RamonMods/CloudBrasil
- Mapa detalhado: [mapa/01-app.md](mapa/01-app.md) · [mapa/02-plugins.md](mapa/02-plugins.md) · [mapa/03-libs.md](mapa/03-libs.md)
