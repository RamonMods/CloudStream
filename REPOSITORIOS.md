# Repositórios de plugins CloudStream

Lista obtida por GitHub Code Search (`repo.json` com `manifestVersion`) em 26/11/2026. A lista da comunidade em rentry.org/cs3-repos pede código de acesso nesta data, então esta tabela é a fonte verificável.

> **Nota:** a tabela é um levantamento técnico de repositórios públicos. O projeto CloudBrasil não usa servidores, contas ou serviços de terceiros; os links servem apenas como referência de código e comparação.

| Repositório | Idioma/região | Observação |
|---|---|---|
| [`RamonMods/CloudBrasil`](https://github.com/RamonMods/CloudBrasil) | pt-br | Nosso. Animes, filmes, séries, doramas e ao vivo |
| [`saimuelbr/saimuelrepo`](https://github.com/saimuelbr/saimuelrepo) | pt-br | BR; `.cs3`/`.jar` prontos |
| [`CakesTwix/cloudstream-extensions-uk`](https://github.com/CakesTwix/cloudstream-extensions-uk) | ucraniano | Referência de implementação |
| [`Bnyro/GermanProviders`](https://github.com/Bnyro/GermanProviders) | alemão | Referência de implementação |
| [`zzikozz/frenchCS`](https://github.com/zzikozz/frenchCS) | francês | Referência de implementação |
| [`mo7AmMeD64/cs-ar`](https://github.com/mo7AmMeD64/cs-ar) | árabe | Referência de implementação |
| [`redowan99/Redowan-CloudStream`](https://github.com/redowan99/Redowan-CloudStream) | — | Referência de implementação |
| [`Kraptor123/Cs-GizliKeyif`](https://github.com/Kraptor123/Cs-GizliKeyif) | turco | Referência de implementação |
| [`Kraptor123/Cs-Karma`](https://github.com/Kraptor123/Cs-Karma) | turco | Referência de implementação |
| [`Wiojelt/TurkSinema`](https://github.com/Wiojelt/TurkSinema) | turco | Referência de implementação |
| [`Wiojelt/TurkSpor`](https://github.com/Wiojelt/TurkSpor) | turco | Referência de implementação |
| [`Wiojelt/WioSpor`](https://github.com/Wiojelt/WioSpor) | turco | Referência de implementação |
| [`Wiojelt/WioSinema`](https://github.com/Wiojelt/WioSinema) | turco | Referência de implementação |
| [`Wiojelt/WioLand`](https://github.com/Wiojelt/WioLand) | turco | Referência de implementação |
| [`Luna712/Luna712-CloudStream-Extensions`](https://github.com/Luna712/Luna712-CloudStream-Extensions) | — | Referência de implementação |
| [`blackhope01/cloudstream-plugins`](https://github.com/blackhope01/cloudstream-plugins) | — | Referência de implementação |
| [`Emre-Kahveci/CloudStreamHub`](https://github.com/Emre-Kahveci/CloudStreamHub) | — | Hub de plugins |
| [`WaroenkTV/m3u8`](https://github.com/WaroenkTV/m3u8) | — | Relacionado a M3U8 |

> Repositórios listados apenas como **referência técnica**. Não copiar código sem observar a licença de cada um. Nenhum conteúdo destes repos entra no CloudBrasil.

## Como saber se um repositório está vivo

1. Baixe `repo.json` da URL informada. Precisa responder 200 e conter `manifestVersion`.
2. Leia `pluginLists` e baixe cada `plugins.json`.
3. Para cada plugin, verifique se a URL do `.cs3` responde 200.
4. Confira `status` (1 = publicado), `apiVersion`, `version`, `fileHash` e `fileSize`.
5. Visite o site do provider com UA de navegador; se der 403/timeout, o plugin provavelmente está quebrado.

## Como adicionar ao CloudStream

No app: **Configurações → Extensões → Adicionar repositório** → cole a URL crua do `repo.json`.

Exemplo (CloudBrasil):

```
https://raw.githubusercontent.com/RamonMods/CloudBrasil/main/builds/repo.json
```

Ou o shortcode `CloudBrasil`.

## Modelo mínimo de repo.json

```json
{
  "name": "NomeDoRepo",
  "iconUrl": "https://github.com/usuario.png",
  "description": "Descrição curta",
  "manifestVersion": 1,
  "pluginLists": [
    "https://raw.githubusercontent.com/usuario/repo/main/builds/plugins.json"
  ]
}
```
