# Arquitetura do CloudStream

Como o app é montado, como o sistema de plugins funciona e como uma extensão sai do código e chega no celular.

## Módulos do app

O `settings.gradle.kts` deste repositório declara:

```kotlin
rootProject.name = "CloudStream"
include(":app", ":shared", ":library", ":docs", ":desktopApp")
```

| Módulo | Papel |
|---|---|
| `:app` | Aplicativo Android: UI (Compose), player, download, configurações, gerenciador de extensões |
| `:library` | Núcleo comum: `MainAPI`, tipos (`TvType`, `LoadResponse`, `Episode`), extratores, rede, sistema de plugins |
| `:shared` | Código compartilhado entre app e desktop |
| `:desktopApp` | Versão desktop (Compose Multiplatform) |
| `:docs` | Documentação interna |

O arquivo mais importante para quem escreve extensão é:

```
library/src/commonMain/kotlin/com/lagradost/cloudstream3/MainAPI.kt
```

É lá que ficam `MainAPI`, `newEpisode`, `newAnimeLoadResponse`, `newTvSeriesLoadResponse`, `newMovieLoadResponse`, `newLiveStreamLoadResponse`, `newHomePageResponse` e as classes de resposta.

## O que é uma extensão

Uma extensão é um `.cs3`, que nada mais é do que um **APK/JAR empacotado** com:

```
NomeDaExtensao/
├── build.gradle.kts
└── src/main/kotlin/com/NomeDaExtensao/
    ├── NomeDaExtensao.kt     ← class NomeDaExtensao : MainAPI()
    └── NomeDaExtensaoPlugin.kt ← @CloudstreamPlugin class ... : BasePlugin()
```

A classe de plugin registra o provider:

```kotlin
@CloudstreamPlugin
class MinhaExtensaoPlugin : BasePlugin() {
    override fun load() {
        registerMainAPI(MinhaExtensao())
    }
}
```

O provider implementa `MainAPI`:

```kotlin
class MinhaExtensao : MainAPI() {
    override var mainUrl = "https://site.com"
    override var name = "MinhaExtensao"
    override val supportedTypes = setOf(TvType.Movie, TvType.TvSeries)
    override var lang = "pt-br"

    override suspend fun getMainPage(page: Int, request: MainPageRequest): HomePageResponse { ... }
    override suspend fun search(query: String): List<SearchResponse> { ... }
    override suspend fun load(url: String): LoadResponse { ... }
    override suspend fun loadLinks(
        data: String, isCasting: Boolean,
        subtitleCallback: (SubtitleFile) -> Unit,
        callback: (ExtractorLink) -> Unit
    ): Boolean { ... }
}
```

## Temporadas e episódios

O app **agrupa por `Episode.season`**. Não existe `addSeason`: a temporada é só um campo do episódio.

```kotlin
addEpisodes(DubStatus.Dubbed, listOf(
    newEpisode(url) {
        this.name = "Episódio 1"
        this.season = 2
        this.episode = 1
    }
))
```

Consequências práticas:

- `season` nulo ou sempre `1` faz o app mostrar tudo como temporada 1.
- Para várias temporadas, carregue **todos** os episódios e preencha `season`/`episode`.
- Deduplicate por `it.data` (o campo do `Episode` é `data`, não `url`).
- Ordene por `(season, episode)` antes de `addEpisodes`.

## Repositório de plugins

O app não tem loja embutida: ele lê um `repo.json` publicado em qualquer lugar.

`builds/repo.json`:

```json
{
  "name": "CloudBrasil",
  "iconUrl": "https://github.com/RamonMods.png",
  "description": "Repositório Brasileiro para o Cloudstream",
  "manifestVersion": 1,
  "pluginLists": ["https://raw.githubusercontent.com/.../builds/plugins.json"]
}
```

`builds/plugins.json` é uma lista de plugins:

```json
[
  {
    "internalName": "AnimeFire",
    "name": "AnimeFire",
    "authors": ["RamonMods"],
    "description": "Site brasileiro de animes",
    "language": "pt-br",
    "tvTypes": ["Animes"],
    "version": 2,
    "status": 1,
    "apiVersion": 1,
    "url": "https://.../builds/AnimeFire.cs3",
    "fileHash": "sha256-...",
    "fileSize": 49228,
    "iconUrl": "https://.../favicon.png",
    "repositoryUrl": "https://github.com/RamonMods/CloudBrasil"
  }
]
```

O app baixa o `.cs3`, confere o hash e carrega o plugin.

### Shortcode

O app aceita um atalho: em vez da URL completa, o usuário digita o nome do repositório (ex.: `CloudBrasil`) e o app resolve para o `repo.json` publicado pelo projeto.

## Plugin Gradle

O build das extensões usa:

```kotlin
plugins {
    id("com.android.library")
    id("org.jetbrains.kotlin.android")
    id("com.github.recloudstream.gradle")
}

cloudstream {
    internalName = "MinhaExtensao"
    description = "Descrição curta"
    authors = listOf("SeuNome")
    tvTypes = listOf("Movies", "Series")
    language = "pt-br"
    iconUrl = "https://site.com/favicon.png"
    version = 1
    status = 1
}
```

Responsabilidades do plugin:

1. Aplicar as configurações de build do CloudStream.
2. Empacotar o provider e a classe `@CloudstreamPlugin`.
3. Gerar o `.cs3` e as entradas do `plugins.json`.

No projeto CloudBrasil o plugin está fixado em um commit válido do JitPack:

```kotlin
id("com.github.recloudstream:gradle:81b1d424d236")
```

## Fluxo completo

```
código (.kt)
   ↓ gradle assemble
build/.../NomeDaExtensao.cs3
   ↓ CI copia para builds/
builds/NomeDaExtensao.cs3 + builds/plugins.json + builds/repo.json
   ↓ usuário adiciona a URL do repo.json
app baixa plugins.json → baixa o .cs3 → confere hash → carrega MainAPI
```

## Cache e atualização

- O app guarda os plugins instalados e o `repo.json` em cache.
- Para atualizar, o usuário puxa a lista de novo ou usa "Atualizar repositórios".
- Trocar `version` no `cloudstream { }` sinaliza atualização.
- `status = 1` publica; valores diferentes podem marcar o plugin como instável/removido.

## Boas práticas para providers

1. Use `app.get(url).document` (Jsoup) para HTML e `app.get(url).text` para JSON.
2. Sempre defina `Referer`/`User-Agent` quando o site bloquear cliente simples.
3. Prefira API JSON quando existir: quebra menos que scraping.
4. Deduplicate resultados de busca e episódios.
5. Preencha `season`/`episode` sempre que a fonte tiver temporadas.
6. Trate falha de uma temporada sem derrubar a ficha inteira (`try/catch` por bloco).
7. Não use `Episode(...)` direto: use `newEpisode`.
