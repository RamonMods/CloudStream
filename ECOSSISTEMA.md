# Ecossistema CloudStream — mapa completo

Levantamento feito em 26/11/2026 pela API do GitHub. Organização: [`recloudstream`](https://github.com/recloudstream).

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
| [`cloudstream`](https://github.com/recloudstream/cloudstream) | Aplicativo Android (player + sistema de plugins) | Kotlin | GPL-3.0 | sim | **Sim — é o app** |
| [`gradle`](https://github.com/recloudstream/gradle) | Plugin Gradle que compila extensões em `.cs3` | Kotlin | LGPL-3.0 | sim | Sim — build das extensões |
| [`extensions`](https://github.com/recloudstream/extensions) | Coleção de extensões oficiais (base e exemplos) | Kotlin | — | sim | Sim — conteúdo |
| [`cs-repos`](https://github.com/recloudstream/cs-repos) | Lista curada de repositórios de plugins (→ rentry.org/cs3-repos) | Python | — | sim | Sim — distribuição |
| [`TestPlugins`](https://github.com/recloudstream/TestPlugins) | Plugins usados para testar o app | Kotlin | — | sim | Não — desenvolvimento |
| [`maven`](https://github.com/recloudstream/maven) | Repositório Maven com dependências do projeto | Shell | — | sim | Sim — dependências |
| [`csdocs`](https://github.com/recloudstream/csdocs) | Fonte da documentação oficial | CSS | — | sim | Sim — docs |
| [`recloudstream.github.io`](https://github.com/recloudstream/recloudstream.github.io) | Site da organização | HTML | — | sim | Sim — site |
| [`dokka`](https://github.com/recloudstream/dokka) | Documentação de API gerada pelo Dokka | HTML | — | sim | Não — docs geradas |
| [`.github`](https://github.com/recloudstream/.github) | Arquivos padrão e workflows da organização | — | — | sim | Não — infraestrutura |
| [`cloudstream-archive`](https://github.com/recloudstream/cloudstream-archive) | Versões antigas do app | — | — | sim | Não — histórico |
| [`cloudstream-sync`](https://github.com/recloudstream/cloudstream-sync) | Página de sincronização | HTML | — | sim | Não — utilitário |
| [`anime-db`](https://github.com/recloudstream/anime-db) | Base de dados de animes usada por extensões | Kotlin | — | sim | Indireto |
| [`NewPipeExtractor`](https://github.com/recloudstream/NewPipeExtractor) | Fork do extrator do NewPipe (YouTube e outros) | Java | GPL-3.0 | sim | Sim — biblioteca |
| [`UniFile`](https://github.com/recloudstream/UniFile) | Fork do DocumentFile, acesso a arquivos | Java | Apache-2.0 | sim | Sim — biblioteca |
| [`NiceHttp`](https://github.com/recloudstream/NiceHttp) | Cliente HTTP usado pelas extensões | Kotlin | — | sim | Sim — biblioteca |
| [`libass`](https://github.com/recloudstream/libass) | Renderização de legendas ASS/SSA | CMake | — | sim | Sim — biblioteca |
| [`media-ffmpeg`](https://github.com/recloudstream/media-ffmpeg) | Build do ffmpeg para o app | — | — | sim | Sim — biblioteca |
| [`Aria2cStream`](https://github.com/recloudstream/Aria2cStream) | Fork: streaming via aria2c | Kotlin | GPL-3.0 | sim | Sim — player |
| [`torrentserver`](https://github.com/recloudstream/torrentserver) | Fork: servidor torrent local | Go | — | sim | Sim — torrent |
| [`golang-mobile`](https://github.com/recloudstream/golang-mobile) | Fork: Go mobile para compilar o torrentserver | — | BSD-3-Clause | sim | Build |
| [`color-picker-android`](https://github.com/recloudstream/color-picker-android) | Fork: seletor de cores da interface | Java | Apache-2.0 | sim | Sim — UI |
| [`csredirect`](https://github.com/recloudstream/csredirect) | Fork: redirecionamento de links | — | — | sim | Indireto |
| [`GPUVideo-android`](https://github.com/recloudstream/GPUVideo-android) | Fork: filtros de vídeo com GPU | — | MIT | sim | Sim — player |
| [`public-gateway-checker`](https://github.com/recloudstream/public-gateway-checker) | Fork: checa gateways IPFS online | TypeScript | NOASSERTION | sim | Não — utilitário |
| [`cs-bot`](https://github.com/recloudstream/cs-bot) | Bot do Discord da comunidade | Go | — | sim | Não — comunidade |
| [`discord-commands`](https://github.com/recloudstream/discord-commands) | Comandos do bot | JavaScript | — | sim | Não — comunidade |

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

- Lista de repositórios de plugins: https://rentry.org/cs3-repos
- Documentação: https://recloudstream.github.io/csdocs/
- Código do app: https://github.com/recloudstream/cloudstream
- Template de plugin: https://github.com/recloudstream/plugin-template
