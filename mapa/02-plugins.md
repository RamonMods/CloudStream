# CloudStream 3 — mapa de plugins e infraestrutura (org recloudstream)

Coleta feita em 25/11/2026 via GitHub CLI/API (`gh`) e requisições HTTP diretas. Status "ativo" = `isArchived=false` e data do último push.

## 1. Repositórios da org mapeados

| Repo | Papel | Linguagem | Licença | Ativo | Conteúdo |
|---|---|---|---|---|---|
| [extensions](https://github.com/recloudstream/extensions) | Repositório oficial de extensões | Kotlin | Sem `LICENSE` declarada | Sim (24/11/2026) | 5 providers: Dailymotion, InternetArchive, Invidious, Twitch, Youtube. Cada um com `build.gradle.kts`, `AndroidManifest.xml`, `*Plugin.kt` e `*Provider.kt`; `repo.json` → `builds/plugins.json`; workflow `build.yml`. |
| [cs-repos](https://github.com/recloudstream/cs-repos) | Índice/comunidade de repositórios de plugins | Python | Sem `LICENSE` declarada | Sim (24/11/2026) | `repos-db.json` (~39 URLs), `ci_check.py` (valida manifesto, listas e HTTP de cada `.cs3`), `create_markdown.py` (gera a lista publicada em rentry.org/cs3-repos), workflow `check_repos.yml`. |
| [TestPlugins](https://github.com/recloudstream/TestPlugins) | Template para criar seu próprio repo de plugins | Kotlin | Domínio público (declarado no README) | Sim (14/11/2026) | `ExampleProvider` + `ExamplePlugin` + `BlankFragment`; instruções de build (`gradlew ExampleProvider:make`), `deployWithAdb` e "All Files Access" via ADB. Base do guia "Using plugin template" do csdocs. |
| [maven](https://github.com/recloudstream/maven) | Publicação das dependências do app | Shell | Sem `LICENSE` declarada | `isArchived=false`, mas parado desde 30/11/2024 | `build.py`, `autoindex.sh`, `repos.json`, workflows `publishMaven.yml` e `updateSubmodules.yml`; submodules: NewPipeExtractor, NiceHttp, OverlappingPanels, UniFile, jadb, nanojson, gradle. |
| [csdocs](https://github.com/recloudstream/csdocs) | Documentação oficial (site Retype) | CSS/Markdown | Sem `LICENSE` declarada | Sim (02/11/2026) | `devs/` (getting started, providers, JSON repository, scraping), `Settings/`, `Integrations/` (Aniyomi, OpenSubtitles, NGINX, animetracking), `Other devices/` (Windows, Linux, TV), `Repositories.md`, `recapps.md`, `retype.yml`, `.inject/`. |
| [anime-db](https://github.com/recloudstream/anime-db) | Biblioteca JVM de banco de animes | Kotlin | Sem `LICENSE` declarada | Sim (15/10/2026) | `anime-db/src/main/kotlin/Main.kt` + `resources/animedb.json`; publica `com.github.recloudstream:animedb:1.0.2` e `com.lagradost:animedb:1.0.2` (mavenLocal + JitPack, JVM toolchain 21). |

## 2. Estrutura de uma extensão CloudStream

```
meu-repo/
├── build.gradle.kts          # raiz: AGP 8.7.3 + com.github.recloudstream:gradle:-SNAPSHOT (JitPack), Kotlin 2.1.0
│                             # cloudstream { setRepo(System.getenv("GITHUB_REPOSITORY") ?: "user/repo") }
│                             # minSdk 21 / compileSdk 35 / JVM 1.8; cloudstream("com.lagradost:cloudstream3:pre-release") = stubs
├── settings.gradle.kts, gradle.properties, gradlew, gradle/wrapper/
├── MeuProvider/
│   ├── build.gradle.kts      # version = 1 (inteiro!); cloudstream { description, authors, status, tvTypes, language, iconUrl, requiresResources }
│   └── src/main/
│       ├── AndroidManifest.xml
│       ├── kotlin/.../MeuPlugin.kt     # @CloudstreamPlugin class MeuPlugin : Plugin() { override fun load(ctx: Context) { registerMainAPI(MeuProvider()) } }
│       ├── kotlin/.../MeuProvider.kt   # class MeuProvider : MainAPI() { mainUrl, name, supportedTypes, lang, suspend fun search(query) }
│       └── res/ (opcional; exigido se requiresResources = true)
└── repo.json → pluginLists → builds/plugins.json (gerado pelo CI)
```

**`@CloudstreamPlugin`** marca a classe de entrada descoberta pelo app; no `load(context)` ela chama `registerMainAPI(...)` (e pode abrir `openSettings` com um `Fragment`). **`MainAPI`** é a classe base de todo provider: define `mainUrl`, `name`, `supportedTypes` (`TvType.Movie`, etc.), `lang`, `hasMainPage` e implementa `search`, `load`, `extractVideoLink` etc. O `cloudstream { ... }` do módulo preenche o manifesto exibido no app (`status`: 0=down, 1=ok, 2=slow, 3=beta-only).

**Como vira `.cs3`:** o plugin Gradle [`recloudstream/gradle`](https://github.com/recloudstream/gradle) (LGPL-3.0) registra as tarefas `compileDex` (Kotlin → `classes.dex` + arquivo `pluginClass`), `generateManifest` (`manifest.json` com nome, versão inteira e `requiresResources`), `compileResources` (`aapt2` → `res.apk`) e, opcionalmente, `compilePluginJar` (suporte cross-platform). A tarefa `make` é um `Zip` que gera `build/<Nome>.cs3` = `manifest.json` + `classes.dex` (+ recursos do `res.apk`, sem `AndroidManifest.xml`), sem timestamps. Depois `writeCacheEntry` → `plugin-entry.json` → `makePluginsJson` → `plugins.json` publicado no branch `builds`. Local: `.\gradlew.bat MeuProvider:make` ou `deployWithAdb` (instala via `adb`). No app, instalação por `cloudstreamrepo://<url-do-repo.json>`.

## 3. O que cs-repos, anime-db e csdocs oferecem

- **cs-repos**: lista canônica de repos da comunidade. `repos-db.json` aceita entradas como string ou `{url, verified}`; o CI faz GET no `repo.json`, exige `name` + `manifestVersion`, percorre `pluginLists` e testa cada URL de plugin com HEAD. Gera `list.md`/markdown com links `cloudstreamrepo://`, servido em https://rentry.org/cs3-repos. Aviso oficial: extensões executam código arbitrário e leem os dados do app.
- **anime-db**: `animedb.json` embutido como resource, consumido como biblioteca por providers que precisam de metadados/nomes de animes; distribuído via JitPack/Maven local na versão 1.0.2.
- **csdocs**: manual do usuário e do desenvolvedor — criação de providers, scraping (devtools, ofuscação, APIs), criação de repositórios JSON, uso do template, preferências de download/legendas/stream, integrações (Aniyomi, AniList/OpenSubtitles, NGINX) e builds para Windows/Linux/TV.

## 4. Repositórios de plugins BR/PT-BR conhecidos

Todos os `repo.json` abaixo foram testados em 25/11/2026 (GET, timeout 25 s). HTTP 200 = URL acessível e JSON válido, não garante confiabilidade do conteúdo.

| Repositório | URL do `repo.json` | HTTP | Observações |
|---|---|---|---|
| Oficial (baseline) | `https://raw.githubusercontent.com/recloudstream/extensions/master/repo.json` | **200** | "Cloudstream providers repository"; único auditado pela equipe do app. |
| saimuelbr/saimuelrepo | `https://raw.githubusercontent.com/saimuelbr/saimuelrepo/refs/heads/main/builds/repo.json` | **200** | "Primeiro Repositório Brasileiro do CloudStream"; presente no `repos-db.json` oficial. |
| lawlietbr/lietrepo | `https://raw.githubusercontent.com/lawlietbr/lietrepo/main/builds/repo.json` | **200** | "Repositório Brasileiro para o Cloudstream"; ~15 providers (AnimeFire, AnimesFHD, CineAgora, DattebayoBR, Goyabu, PobreFlix, ReiDosEmbeds...). Não está na lista oficial. |
| animesfhd/cloudstream-extensions | `https://raw.githubusercontent.com/animesfhd/cloudstream-extensions/main/builds/repo.json` | **200** | "Extensão oficial do AnimesFHD" (animes legendados e dublados em PT-BR); MIT; consta no `repos-db.json` oficial. |
| Fabiano2503/astra-cloudstream | `https://raw.githubusercontent.com/Fabiano2503/astra-cloudstream/refs/heads/builds/repo.json` | **200** | Repo "Astra" (mantenedor BR); os `.cs3` ficam no branch `builds`. O caminho `main/builds/repo.json` retorna **404**. |

**Veredito:** para PT-BR, o par mais sólido é o repo oficial + AnimesFHD (listados/verificados pelo `cs-repos`); `lietrepo` e `astra` cobrem providers brasileiros amplos, mas não passam pelo CI da org — trate como código de terceiros.
