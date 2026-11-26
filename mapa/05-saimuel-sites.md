# Sites dos plugins do `saimuelbr/saimuelrepo` — status e domínios atuais

Pesquisa somente-leitura (26/11/2026). Domínios extraídos das **strings dos `.jar` publicados** em `builds/` (o repo não tem código-fonte das extensões; a wiki do CloudStream marca o repo como *closed-source*, embora o README mencione GPL-3.0). Verificação com `curl.exe` (UA Chrome, `--noproxy "*"`, `-L`). **Nenhum código foi copiado.**

| Plugin | URL no plugin | Domínio atual (confirmado) | HTTP | API / JSON | WebView / CF | Conteúdo |
|---|---|---|---|---|---|---|
| NetCine | `nnn1.lat` (DNS morto) | `netcine.cfd` / `netcineyt.lat` | 200 / 200 | `netcineyt.lat/wp-json/...` = JSON 200; `netcine.cfd/wp-json` = 403 | Cloudflare | Filmes + séries, catálogo TMDB |
| PobreFlix | `www.pobreflixtv.club` | `www.pobreflixtv.fitness` (redirect) | 200 | `e/getplay.php?id=` devolve HTML (SPA), não JSON | Cloudflare | Filmes, séries, animes |
| TopFilmes | `www.topfilmes.biz` | `www.topfilmes.biz` | 200 | Sem WP/API (`/wp-json` 404) — scraping HTML | Cloudflare | Filmes (catálogo próprio) |
| AnimesCloud | `animes.strp2p.com`, `animeshd.cloud`, `animesdrive.online` | `animesdrive.cloud` (redirect de `.online`) | 200 | **WP REST aberto**: `/wp-json/` 200, `/wp-json/dooplayer/v2/` 200 JSON | Cloudflare (sem challenge) | Animes |
| MegaFlix | `megaflix.lat` (DNS morto), `megafrixapi.com` (1 byte) | `megaflix.lol` / `megaflix3.site` | 200 / 200 | `megaflix.lol/wp-json` 403; `megaflix3.site` é SPA sem REST real | Cloudflare | Filmes + séries, TMDB |
| UltraCine | `ultracine.org` (DNS morto), `embedplay.upn.one` | `ultracine.autos` / `www.ultracinetv.lat` | 200 / 200 | `ultracinetv.lat/wp-json` 200 (JSON curto); `ultracine.autos` sem API | Cloudflare | Filmes, séries, animes, doramas |
| DonghuaNoSekai | `donghuanosekai.com` | `donghuanosekai.com` | 200 | **WP REST + admin-ajax** (`/wp-json/wp/v2/posts` 200 JSON) | Cloudflare (sem challenge) | Donghuas/animes chineses legendados PT |
| Doramas | `doramasonline.co` | `doramasonline.co` → `router.parklogic.com` (estacionado) | 200 (JS redirect) | Nenhuma | openresty, anti-adblock | **Sem catálogo próprio confirmado — morto** |
| AnimesDigital | `animesdigital.org` | `animesdigital.org` | 200 | **WP REST aberto**: `/wp-json/wp/v2/posts` 200 JSON | Cloudflare (sem challenge) | Animes |
| OverFlix | `www.overflix.me` → `overflix.cc` (DNS morto), `fshd.link/api` | `www.overflix.living` (ex-`.locker`/`.center`) | 200 | `/api/options` e `/api/players` = **401 JSON** (exige chave); `fshd.link` 405/401 | Cloudflare | Filmes + séries, player externo |

## Detalhes por plugin

- **NetCine** — `nnn1.lat` não resolve. Rede viva usa `.lat` com rotação: `netcinebn.lat` e `netcineri.lat` → `netcineyt.lat`; `netcine.cfd` é o espelho estável com TMDB.
- **PobreFlix** — `.club` redireciona 301 para `.fitness`. `getplay.php` retorna o HTML da home (roteamento SPA), ou seja, a extração não é via JSON.
- **TopFilmes** — site estático/HTML, sem WordPress. É o caso mais simples de scraper direto, mas sem contrato de API.
- **AnimesCloud** — os hosts `animes.strp2p.com`, `animeshd.cloud` e `embedplay.upn.one` servem a **mesma página "Player" de 4 KB** que resolve `/api/public/resolve?file1=#hash` e, no clique, mostra "The system is under maintenance". É player-ofuscado, não catálogo. O catálogo real é `animesdrive.cloud` (WP REST + endpoint `dooplayer/v2`).
- **MegaFlix** — `megaflix.lat` morreu e `megafrixapi.com` responde 1 byte. `megaflix.lol` tem o mesmo layout do `netcine.cfd` (rede irmã) e bloqueia REST com 403.
- **UltraCine** — `ultracine.org`, `ultracine.me`, `ultracine.site`, `ultracine.blog` e `ultracinetv.lat` puro não resolvem; vivos: `ultracine.autos` (de `ultracine.lol`) e `www.ultracinetv.lat` (de `play.ultracine.click`). O player `embedplay.upn.one` injeta um overlay invisível que abre `gigaduckgo.com` em clique — **não reimplementar esse comportamento**.
- **DonghuaNoSekai** — WordPress completo e REST público; melhor alvo técnico da lista.
- **Doramas** — domínio estacionado em `router.parklogic.com` com JS anti-adblock; não há site de conteúdo acessível.
- **AnimesDigital** — WordPress REST público porém com posts curtos (1.476 bytes em `per_page=1`).
- **OverFlix** — `www.overflix.me` redireciona para `overflix.cc`, que não resolve. O sobrevivente da rede é `www.overflix.living`; APIs internas exigem autenticação (401).

## Recomendação para o CloudBrasil (reimplementar do zero)

**Prioridade alta — valem reimplementar:**
1. **DonghuaNoSekai** — WP REST aberto, nicho (donghua legendado PT) com pouca concorrência, sem clickjacking.
2. **AnimesCloud** (via `animesdrive.cloud`) — WP REST + `dooplayer/v2` público; ignore os players `.strp2p.com`/`.upn.one`.
3. **AnimesDigital** — WP REST aberto, catálogo de animes; implementação pequena.

**Prioridade média:** **TopFilmes** (HTML simples) e **PobreFlix** (SPA com `getplay.php`) — viáveis, mas exigem scraping e podem quebrar a cada redeploy.

**Evitar:** NetCine e MegaFlix (domínios rotativos + REST 403), UltraCine e OverFlix (players com redirecionamento/clickjacking e API 401), Doramas (morto).

**Nota legal/técnica:** o README diz GPL-3.0, mas os fontes Kotlin não estão publicados e a wiki do CloudStream classifica o repo como *closed-source*. Tratar como licença não declarada: observar o comportamento HTTP e escrever implementação própria, sem reutilizar código, nomes de classes, strings de ofuscação nem assets dos `.jar`.

**Limitações:** status é snapshot de uma única rodada; domínios de streaming rotacionam rápido (muitos `.lat`/`.cfd`/`.autos`). Não foi feita verificação de reprodução de vídeo de fato, apenas de catálogo/API e do comportamento dos players.
