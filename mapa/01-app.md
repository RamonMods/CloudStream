# Mapa da org `recloudstream` — 01: app e infraestrutura

Mapeamento dos 7 repositórios pedidos, com foco no app CloudStream, no sistema de plugins e no plugin Gradle. Pesquisa feita via `gh`/API em 25/11/2026; branches padrão conferidos no GitHub.

## Tabela comparativa

| Repositório | Branch | Linguagem | Stars | Papel na org | O que importa aqui |
|---|---|---|---:|---|---|
| [`cloudstream`](https://github.com/recloudstream/cloudstream) | `master` | Kotlin | 11.425 | App Android de streaming/download | `settings.gradle.kts`, `MainAPI.kt`, `PluginManager.kt`, UI de repositórios |
| [`gradle`](https://github.com/recloudstream/gradle) | `master` | Kotlin | 7 | Plugin Gradle de build de plugins | ID `com.lagradost.cloudstream3.gradle`; consumido como `com.github.recloudstream:gradle` |
| [`.github`](https://github.com/recloudstream/.github) | `master` | — | 10 | Configuração da org | `ISSUE_TEMPLATE/config.yml`, `check_issue.py`, `connectivitycheck`, `profile/README.md` (avisos DMCA/EUCD) |
| [`cloudstream-archive`](https://github.com/recloudstream/cloudstream-archive) | `master` | HTML | 35 | Versões antigas | Só histórico;README manda usar o releases atual |
| [`dokka`](https://github.com/recloudstream/dokka) | `master` | HTML | 9 | Documentação da API gerada | `app/.../*.html` (Dokka estático, com `.nojekyll`) |
| [`recloudstream.github.io`](https://github.com/recloudstream/recloudstream.github.io) | `master` | HTML | 13 | Site antigo (Pages) | README: site removido após pedido de DMCA |
| [`cloudstream-sync`](https://github.com/recloudstream/cloudstream-sync) | `main` | HTML | 7 | Páginas de sincronização | `google-drive/index.html` — opt-in "Cloudstream3 Sync - Google Drive" |

> Atenção: `cloudstream-sync` usa `main`; os outros seis usam `master`.

## 1. Módulos do `settings.gradle.kts`

Arquivo na raiz de `cloudstream`:

```kotlin
pluginManagement {
    repositories { gradlePluginPortal(); google(); mavenCentral() }
}
dependencyResolutionManagement {
    repositoriesMode.set(RepositoriesMode.FAIL_ON_PROJECT_REPOS)
    repositories {
        google(); mavenCentral(); mavenLocal(); maven("https://jitpack.io")
    }
}
rootProject.name = "CloudStream"
include(":app", ":shared", ":library", ":docs", ":desktopApp")
```

| Módulo | Papel |
|---|---|
| `:app` | App Android (Jetpack Compose), onde ficam `MainActivity`, `PluginManager.kt` e a UI de extensões |
| `:shared` | Código compartilhado multiplataforma (Kotlin `commonMain`), ex.: `com/lagradost/cloudstream4/viewmodels/ExtensionsViewModel2.kt` |
| `:library` | Núcleo da API (`com.lagradost.cloudstream3`) — é o que os plugins consomem via JitPack |
| `:docs` | Geração da documentação (Dokka) |
| `:desktopApp` | Variante desktop |

Cada módulo tem seu `build.gradle.kts` (`app/`, `shared/`, `library/`, `docs/`, `desktopApp/`). O JitPack é essencial: a lib é publicada como `com.github.recloudstream.cloudstream:library` (os plugins de terceiros usam `...:library:-SNAPSHOT`).

## 2. Caminho do `MainAPI.kt`

```
library/src/commonMain/kotlin/com/lagradost/cloudstream3/MainAPI.kt
```

- Está em `commonMain`, ou seja, é a API comum do núcleo multiplataforma — não é arquivo do `:app`.
- Define as anotações de contrato: `@Prerelease` (só em builds prerelease; estável fecha com `NoSuchMethodException`), `@InternalAPI`, `@UnsafeSSL` e `@SkipSerializationTest`.
- O arquivo registra a migração em andamento de Jackson para `kotlinx.serialization` (imports de `JsonMapper`, `JsonProperty` e `Serialization` convivem).
- É a classe-base que um provedor de site estende ao escrever um plugin/extensão.

## 3. Sistema de plugins

Cadeia completa: **repositório → `repo.json` → `plugins.json` → `.cs3` → carregamento no app**.

### `.cs3` (formato do pacote)
É um ZIP sem versão (`archiveExtension.set("cs3")`, `archiveVersion.set("")`) gerado pela task `make` do plugin Gradle. Conteúdo:
- `manifest.json` — `PluginManifest(pluginClassName, name, version: Int, requiresResources)`;
- `classes.dex` — saída da task `compileDex` (compila o Kotlin Android em DEX);
- `res.apk` (somente se `requiresResources = true`), com `AndroidManifest.xml` removido.

No app, `app/src/main/java/com/lagradost/cloudstream3/plugins/PluginManager.kt` lê `manifest.json` de dentro do pacote, guarda os arquivos em `$filesDir/plugins/<pasta>/<nome>.cs3`, e trata plugins online/locais, safely (`isSafeMode()`) e hot reload.

### `repo.json` (índice do repositório)
Arquivo na raiz do repo de extensões. Exemplo real de `recloudstream/extensions`:

```json
{
  "name": "Cloudstream providers repository",
  "description": "Cloudstream extension Repository",
  "manifestVersion": 1,
  "pluginLists": [
    "https://raw.githubusercontent.com/recloudstream/extensions/builds/plugins.json"
  ]
}
```

O campo `pluginLists` aponta para um ou mais `plugins.json`, normalmente hospedados no branch `builds`.

### `plugins.json` (catálogo)
Gerado pela task `makePluginsJson` (root project) a partir de um `plugin-entry.json` por plugin (`writeCacheEntry`). É um array de entradas com campos como `internalName`, `version`, `apiVersion`, `status`, `authors`, `description`, `tvTypes`, `iconUrl`, `repositoryUrl`, `jarUrl`, `cs3Url`, `fileHash`, `fileSize`, `jarFileSize`. Exemplo: `DailymotionProvider`, v4, `apiVersion: 1`, autor `Luna712`.

### Shortcode
No app, o campo de adicionar repositório aceita URL **ou shortcode** (`strings.xml`: `repository_url_hint = "Repository URL or Shortcode"`). O shortcode é um atalho que resolve para uma URL diferente do texto digitado — o código em `ExtensionsViewModel2.kt` comenta explicitamente: *"Shortcodes can have a different url from the input"*. A documentação (`csdocs`, `Repositories.md`) manda copiar os shortcodes da lista de repositórios; exemplo: `anicompat` → `https://raw.githubusercontent.com/CranberrySoup/AniyomiCompatExtension/master/repo.json`. O repo padrão embutido na UI é `https://raw.githubusercontent.com/RamonMods/CloudBrasil/main/builds/repo.json`.

## 4. Plugin Gradle `com.github.recloudstream:gradle`

Duas coordenações diferentes, não confundir:

| Item | Valor |
|---|---|
| Coordenada consumida (JitPack) | `classpath("com.github.recloudstream:gradle:-SNAPSHOT")` |
| ID do plugin aplicado | `com.lagradost.cloudstream3.gradle` |
| Classe | `com.lagradost.cloudstream3.gradle.CloudstreamPlugin` |
| `group` no build | `com.lagradost.cloudstream3` |
| Publicação | `https://maven.pkg.github.com/recloudstream/gradle` (GitHub Packages) + JitPack (`jitpack.yml`, JDK 17) |

Uso real em `recloudstream/extensions/build.gradle.kts`:

```kotlin
buildscript {
    dependencies {
        classpath("com.android.tools.build:gradle:8.7.3")
        classpath("com.github.recloudstream:gradle:-SNAPSHOT")
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:2.3.0")
    }
}
fun Project.cloudstream(configuration: CloudstreamExtension.() -> Unit) =
    extensions.getByName<CloudstreamExtension>("cloudstream").configuration()

subprojects {
    apply(plugin = "com.android.library")
    apply(plugin = "kotlin-android")
    apply(plugin = "com.lagradost.cloudstream3.gradle")
    cloudstream { setRepo(System.getenv("GITHUB_REPOSITORY") ?: "https://github.com/user/repo") }
}
```

`CloudstreamPlugin.apply()` cria a extensão `cloudstream`, registra as tasks e as configurações. Principais opções do bloco `cloudstream {}` (`CloudstreamExtension.kt`):

| Propriedade/método | Default / efeito |
|---|---|
| `setRepo(url)` / `setRepo(user, repo, type)` | Detecta `github`, `gitlab`, `codeberg`, `gitlab-<domínio>` ou `gitea-<domínio>` e monta o link raw com `%branch%`/`%filename%` |
| `setRepo(user, repo, url, rawLinkFormat)` | Formato raw customizado |
| `buildBranch` | `"builds"` (branch onde `plugins.json` e os `.cs3` são publicados) |
| `overrideUrlPrefix(url)` | Ajusta o prefixo de download do `cloudstream.jar`/APK |
| `requiresResources` | `false`; se `true`, inclui `res.apk` no `.cs3` |
| `description`, `authors`, `status` (3), `language`, `tvTypes`, `iconUrl` | Metadados da entrada em `plugins.json` |
| `apiVersion` | `1` — versão da API esperada pelo app |
| `isCrossPlatform` | `false`; gera `<nome>.jar` e valida com `ensureJarCompatibility` |

Tasks registradas (grupo `cloudstream`): `generateSources`, `compileDex`, `compileResources`, `compilePluginJar`, `ensureJarCompatibility`, `generateManifest`, `make` (gera o `.cs3`), `writeCacheEntry` (`plugin-entry.json`), `makePluginsJson` (`plugins.json`), `cleanCache` e `deployWithAdb`.

> A pegadinha: quem quer escrever um plugin copia a coordenada JitPack `com.github.recloudstream:gradle`, mas o `apply(plugin = ...)` usa o ID `com.lagradost.cloudstream3.gradle`. O README do repo `gradle` ainda aponta para um `plugin-template` que hoje retorna 404 na org; o exemplo vivo é o repo `extensions`.

## 5. Fontes

Branches e arquivos lidos via GitHub REST API/CLI: `cloudstream/settings.gradle.kts`, `cloudstream/library/.../MainAPI.kt`, `cloudstream/app/.../PluginManager.kt`, `cloudstream/shared/.../ExtensionsViewModel2.kt`, `cloudstream/app/src/main/res/values/strings.xml`, `gradle/build.gradle.kts`, `gradle/jitpack.yml`, `gradle/.../CloudstreamPlugin.kt`, `gradle/.../CloudstreamExtension.kt`, `gradle/.../tasks/Tasks.kt`, `gradle/.../tasks/MakePluginsJsonTask.kt`, `gradle/.../entities/PluginManifest.kt`, `extensions/build.gradle.kts`, `extensions/repo.json`, `extensions/plugins.json@builds`, READMEs dos sete repos e trees recursivos.
