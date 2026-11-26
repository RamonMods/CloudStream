# 04 — Novas extensões CloudStream PT-BR para o CloudBrasil

Resposta direta: existem **19 extensões BR prontas para portar** em três repositórios abertos, e as melhores são `Animes Online CC`, `Donghua No Sekai`, `AnimesDigital`, `Vizer` e `OverFlix`; porém **nenhum desses repos declara licença**, o que é o principal risco jurídico do port.

## 1. Linha de base (o que o CloudBrasil já tem)

`RamonMods/CloudBrasil` — GPL-3.0, push em 2026-11-26, `builds/repo.json` e `builds/plugins.json` respondem. 18 plugins: AnimeFire, AnimesCloud, AnimesDigital, AnimesFHD, AnimesOnlineCC, AniTube, CineAgora, DattebayoBR, DonghuaNoSekai, DoramasOnline, Doramogo, EmbedTV, Goyabu, MendigoFlix, PobreFlix, ReiDosEmbeds, StreamFlix, Xtream. Código original do projeto; as extensões derivadas mantêm os créditos dos autores originais (ex.: AnimesFHD).

## 2. Repositórios candidatos

| Repo | URL | Licença | Plugins | Último push | repo.json | Vale portar? |
|---|---|---|---|---|---|---|
| saimuelbr/saimuelrepo | https://github.com/saimuelbr/saimuelrepo | nenhuma | 10 (9 novos) | 2026-10-17 | OK (`builds/repo.json` → `builds/plugins.json`) | **Sim**, maior ganho líquido |
| franciscoalro/CloudstreamRepo | https://github.com/franciscoalro/CloudstreamRepo | nenhuma | 11 (10 novos) | 2026-02-05 | OK (raiz + `builds/`) | **Sim**, mas versões antigas |
| lawlietbr/lietrepo | https://github.com/lawlietbr/lietrepo | nenhuma | 13 (1 novo: SuperFlix) | 2026-11-20 | OK | Parcial — repo PT-BR de terceiros; referência |
| Kraptor123/Cs-Karma | https://github.com/Kraptor123/Cs-Karma | nenhuma | dezenas (multi-idoma; FLIXLATAM, DoramasLatinoX etc.) | 2026-11-24 | OK (pluginLists aponta para branch `builds`, conferir) | Parcial — só filtrar BR |
| admknight/CloudstreamExtensions | https://github.com/admknight/CloudstreamExtensions | nenhuma | mega-repo dinâmico | 2026-11-25 | OK | Não — foco global, ruido |
| phisher98/cloudstream-extensions-phisher | https://github.com/phisher98/cloudstream-extensions-phisher | nenhuma | sem `builds/` nem `repo.json` | 2026-11-24 | Não | Não como repo de plugins |
| zerohora00h/cloudstreamwebtest | https://github.com/zerohora00h/cloudstreamwebtest | nenhuma | plugin OverFlix (TypeScript) | 2026-04-26 | Não | Referência técnica apenas |
| Claudemirovsky/cursedyomi-extensions | https://github.com/Claudemirovsky/cursedyomi-extensions | Apache-2.0 | Tachiyomi PT (AnimesDigital, Vizer) | 2025-01-12 | Não (não é CloudStream) | Fonte de lógica/scraper |
| K3vinb5/Unyo-Extensions | https://github.com/K3vinb5/Unyo-Extensions | GPL-3.0 | Tachiyomi (AnimesDigital) | 2024-11-03 | Não | Fonte de lógica/scraper |
| gsgamebg/spaceanime | https://github.com/gsgamebg/spaceanime | nenhuma | fontes PT em Kotlin/JVM | 2026-11-25 | Não | Fonte de referência |
| hexated/cloudstream-extensions-hexated | https://github.com/hexated/cloudstream-extensions-hexated | GPL-3.0 | grande, sem foco BR | 2024-08-17 | OK | Não |

## 3. Plugins novos disponíveis (fora do CloudBrasil)

| Plugin | Origem | Tipo | Versão/API | Domínio | Vale portar? |
|---|---|---|---|---|---|
| Animes Online CC | franciscoalro | Anime/OVA | v2 / API 1 | animesonlinecc.to | **Sim** (site vivo) |
| Donghua No Sekai | saimuel + franciscoalro | Anime | v1 / API 1 | donghuanosekai.com | **Sim** (site vivo, WP REST) |
| AnimesDigital | saimuel (+ scrapers Tachiyomi) | Anime | v2 / API 1 | animesdigital.org | Sim, com ressalva |
| Vizer | franciscoalro (+ Tachiyomi) | Filme/Série | v1 / API 1 | vizer.tv | Sim, validar domínio |
| OverFlix | saimuel + franciscoalro | Filme/Série | v2 / API 1 | overflix.me | Sim, validar domínio |
| MegaFlix | saimuel + franciscoalro | Filme/Série | v4 / API 1 | megaflix.co | Médio (domínio não resolve aqui) |
| NetCine | saimuel + franciscoalro | Filme/Série/Anime | v7 / API 4 | netcine.biz | Médio (usar a v7) |
| Doramas / Doramas Online | saimuel + franciscoalro | AsianDrama | v2 / API 1 | doramasonline.co | Médio |
| NovelasFlix | franciscoalro | Filme/Série | v1 / API 1 | novelasflix4k.me | Médio |
| EmbedCanais TV | franciscoalro | Live | v1 / API 1 | embedcanais.com | Médio |
| MaxSeries | franciscoalro | Filme/Série | v264 / API 1 | maxseries.pics | Baixo (versão suspeita) |
| SuperFlix | lietrepo | Filme/Série | — | — | Fácil (mesma linhagem de código) |
| AnimesCloud | saimuel | Anime | v4 / API 1 | — | Baixo |
| TopFilmes | saimuel | Filme/Série | v2 / API 2 | topfilmes.biz | Baixo |
| UltraCine | saimuel | Filme/Série | v4 / API 1 | ultracine.org | Baixo |
| Flixlatam / DoramasLatinoX | Cs-Karma | Filme/Dorama | — | — | Baixo (filtrar) |

## 4. Teste de sites ao vivo (UA de Chrome, 2026-11-26)

| Site | HTTP | Content-Type | Resultado / dica de API ou seletor |
|---|---|---|---|
| animesonlinecc.to | 200 | text/html; charset=UTF-8 | 39.695 B, título "Animes Online - Assistir Animes Online Grátis". WordPress: `/wp-json/wp/v2/posts` responde 200 JSON (posts vazio — usar tipos customizados). Busca: `#searchform`, `.live-search`, `.search-resp` |
| animesonlinecc.com | 200 | text/html;charset=UTF-8 | 3.084 B, sem título — espelho/prova de vida; preferir `.to` |
| donghuanosekai.com | 200 | text/html; charset=UTF-8 | 272.016 B, título ativo. **WP REST confirmado**: `/wp-json/wp/v2/posts?per_page=1` → JSON com post de 2026-11-25. Melhor alvo de API |
| doramasonline.co | 200 | text/html | 5.600 B, "Redirecting..." — challenge/JS, conteúdo não confirmado |
| betteranime.net | 200 | text/html | 5.600 B, "Redirecting..." — challenge/JS, conteúdo não confirmado |
| novelasflix4k.me | 308 | — | Redirecionamento permanente; seguir para domínio final antes de portar |
| animesbrasil.com | 200 | text/html | 114 B — página mínima/placeholder |
| animesdigital.org | timeout | — | DNS resolve (Cloudflare 172.67.222.167), HTTP não completou no ambiente |
| overflix.me / vizer.tv / tomatao.tv / ultracine.org / topfilmes.biz / netcine.biz / megaflix.co / embedcanais.com / maxseries.pics / youcine.* | ERR | — | DNS não resolveu **neste ambiente** (pode ser filtro local, não prova de que o site morreu) |

Nota: `animeonline.cc` não resolve; o plugin usa `animesonlinecc.to`.

## 5. Top 10 recomendado (prioridade de port)

| # | Extensão | Por quê | Esforço |
|---|---|---|---|
| 1 | Animes Online CC | Site 200 ativo + .cs3 pronto; maior valor imediato | Baixo |
| 2 | Donghua No Sekai | Site 200 com WP REST funcional; duas fontes para comparar | Baixo |
| 3 | AnimesDigital | Plugin pronto + dois scrapers open source (Apache-2.0/GPL-3.0) | Médio |
| 4 | Vizer | Plugin pronto + scraper Tachiyomi com DTO e extrator | Médio |
| 5 | OverFlix | Duas implementações (Kotlin e TS) para cross-check | Médio |
| 6 | MegaFlix | Duas implementações, categorias já no CloudBrasil | Médio |
| 7 | NetCine | Versão v7/API 4 mais recente no saimuelrepo | Médio |
| 8 | Doramas Online | Categoria AsianDrama complementa Doramogo | Médio |
| 9 | NovelasFlix | Nicho novo, sem concorrência no CloudBrasil | Médio |
| 10 | SuperFlix | Mesma árvore do CloudBrasil, port quase direto | Baixo |

Segunda leva: AnimesCloud, TopFilmes, UltraCine, EmbedCanais TV, MaxSeries, Flixlatam.

## 6. Riscos e limitações

- **Licença**: nenhum dos três repos BR (saimuel, franciscoalro, lietrepo) declara licença no GitHub. Portar código-fonte para o CloudBrasil (GPL-3.0) sem autorização é risco jurídico. Preferir reimplementar a partir do comportamento do site, ou pedir autorização aos autores.
- **Versões**: vários plugins usam API 1/2 (antiga); o CloudBrasil atual usa API 7 em alguns plugins — revisar assinatura de `MainAPI()` antes de compilar.
- **Domínios**: plugin pronto ≠ site vivo. Validar cada domínio na máquina final (aqui houve DNS bloqueado/filter).
- **limite**: `gh search code` estourou a cota de hora (HTTP 403) durante a varredura de `tomatao`/`vizer`; os resultados de code search anteriormente coletados foram aproveitados. Testes HTTP com UA tiveram timeout em `animesdigital.org` e outros domínios não resolveram no ambiente — não conclusão definitiva de indisponibilidade.
