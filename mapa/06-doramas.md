# Doramas (`doramasonline.co`) — site morto, não reimplementar

Levantamento somente-leitura em 26/11/2026. O módulo que havia sido criado em
`lietrepo/DoramasOnline` foi **apagado** (não chegou a ser commitado). Nenhum
outro módulo do `lietrepo` foi tocado.

## Achado

`https://doramasonline.co` não serve mais o catálogo de doramas. O domínio
está estacionado e monetizado via ParkLogic: cada caminho responde HTTP 200 com
uma página "Redirecting..." de ~5,6 KB que executa um JavaScript de
anti-adblock e faz `POST https://router.parklogic.com/`. O roteador devolve
HTML de estacionamento; em um navegador real a cadeia termina no portal
**HeadlineLogic** (`headlinelogic.com/?d=doramasonline.co&…`).

| URL testada | Resultado |
|---|---|
| `https://doramasonline.co/` | 200, 5.604 B — desafio JS da ParkLogic |
| `https://doramasonline.co/category/drama/` | 200, 5.643 B — mesmo desafio |
| `https://doramasonline.co/wp-json/wp/v2/posts?per_page=1` | 200, 5.666 B — mesmo desafio (nenhum JSON) |
| `https://doramasonline.co/robots.txt` | 200, corpo `User-agent: *` / `Disallow: /` |
| `https://doramasonline.co/.IGV0hOcNusVJOgqoD1HuWTk0PssdueKB` | 200 — só `window.history.back()` |
| `POST https://router.parklogic.com/` | HTML "This page has been created by ParkLogic" |
| Chrome real em `https://doramasonline.co/` | `https://headlinelogic.com/?d=doramasonline.co&pcid=56&a=false&uuid=…&brand=doramasonline.co` |
| `https://doramasonline.net/` | 200, WordPress real, mas **outro site** (tema `temanormal`) |
| `https://doramasonline.com/` | 403 → hugedomains.com (domínio à venda) |

## Evidência de que o site já existiu

Wayback guarda a home antiga (`https://web.archive.org/web/20250823072725/https://doramasonline.co/`,
77 KB), o sitemap de séries (2025-11-27) e os arquivos do tema
**ToroFilm 2.5.9**. O HTML arquivado mostra cards `ul.post-lst > li#post-N >
article.post`, busca `GET /?s=`, seletor de temporadas
`.sel-temp a[data-season][data-post]` com AJAX
`POST /wp-admin/admin-ajax.php` (`action=action_select_season`) e player em
`.video-player iframe[data-src]`. Tudo isso é histórico: nenhuma dessas URLs
responde conteúdo no domínio atual.

## Conclusão

**Não há o que implementar.** Mesmo com `usesWebView = true` para resolver o
desafio JS, o destino é uma página de notícias estacionada, sem catálogo,
sem episódios e sem player. Manter um plugin com esse `mainUrl` só geraria
listas vazias e falsos positivos. Marcar como **morto / evitar**, ao lado de
UltraCine e OverFlix na recomendação de `05-saimuel-sites.md`.

Caso o domínio volte a servir o ToroFilm no futuro, os seletores acima são o
ponto de partida para uma implementação original — mas isso deve ser
reconfirmado com HTTP fresco antes de qualquer código.
