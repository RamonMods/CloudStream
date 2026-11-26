<div align="center">

# CloudStream

**⚠️ Aviso: por padrão o app não traz nenhuma fonte de vídeo. Você precisa instalar extensões para adicionar funcionalidade.**

<a href="https://github.com/recloudstream/cloudstream/releases/download/pre-release/app-prerelease-release.apk"><img src=".github/images/download-cloudstream-pre.png" alt="Baixar CloudStream pré-release" width="430"/></a>

[![Discord](https://invidget.switchblade.xyz/5Hus6fM)](https://discord.gg/5Hus6fM)

</div>

## Índice

- [Sobre](#sobre)
- [Instalação](#instalacao)
- [Como contribuir](#contribuindo)
- [Problemas](#problemas)
- [Extensões](#extensoes)
- [Idiomas](#idiomas)
- [Mapa do ecossistema CloudBrasil](#mapa-do-ecossistema)
- [Outras fontes](#outras-fontes)

<a id="sobre"></a>

## Sobre

CloudStream é um centro de mídia que prioriza liberdade e flexibilidade para usuários e desenvolvedores. É um player multimídia baseado em extensões, com suporte a listas de acompanhamento. Existem extensões para visualizar vídeos de diversas fontes, como LibriVox (audiolivros), YouTube, Twitch, iptv-org e outras.

**Não crie extensões ilegais nem use extensões que hospedem mídia com direitos autorais.** Para entender a posição do projeto sobre DMCA e EUCD, leia a página da organização [reCloudStream](https://github.com/recloudstream).

### Recursos

- **Sem anúncios**
- Sem rastreamento ou analytics
- Marcadores
- Suporte a celular e TV
- Chromecast
- Sistema de extensões para personalização

<a id="instalacao"></a>

## Instalação

A documentação oficial traz os passos para instalar e configurar o CloudStream:

- [Começando com o CloudStream](https://recloudstream.github.io/csdocs/)
- [Versões (releases)](https://github.com/recloudstream/cloudstream/releases)
- [Pré-release (build automática)](https://github.com/recloudstream/cloudstream/releases/download/pre-release/app-prerelease-release.apk)

<a id="contribuindo"></a>

## Como contribuir

Aceitamos contribuições de boa vontade. Para começar, veja a [aba de issues](https://github.com/recloudstream/cloudstream/issues). Antes de mexer na interface, leia o [guia de migração para Compose](COMPOSE.md) e a [política de uso de IA](AI-POLICY.md), ambos em português neste repositório.

<a id="problemas"></a>

## Problemas

Aceitamos issues e pull requests, mas pedimos que use um [modelo](https://github.com/recloudstream/cloudstream/issues/new/choose):

- [Modelo de relatório de bug](https://github.com/recloudstream/cloudstream/issues/new?assignees=&labels=bug&projects=&template=application-bug.yml): informe versão baixada, dispositivo, versão do Android (e da API, se possível), comportamento esperado e real, e principalmente passos claros para reproduzir.
- [Modelo de sugestão](https://github.com/recloudstream/cloudstream/issues/new?assignees=&labels=enhancement&projects=&template=feature-request.yml): antes de enviar, verifique se a sugestão já existe.

<a id="extensoes"></a>

## Extensões

O guia para desenvolvedores de extensões fica na documentação oficial: [Guia: Primeiros passos](https://recloudstream.github.io/csdocs/devs/gettingstarted/).

Neste repositório você encontra:

| Arquivo | Conteúdo |
|---|---|
| [ARQUITETURA.md](ARQUITETURA.md) | Módulos do app, sistema de plugins, `#EXTINF`/`.cs3`, `repo.json` e `plugins.json` |
| [ECOSSISTEMA.md](ECOSSISTEMA.md) | Todos os repositórios da organização `recloudstream` e o papel de cada um |
| [REPOSITORIOS.md](REPOSITORIOS.md) | Repositórios de plugins conhecidos e como verificar se estão vivos |
| [scripts/clonar-ecossistema.ps1](scripts/clonar-ecossistema.ps1) | Clona o ecossistema inteiro em uma pasta única |

### Extensões brasileiras (CloudBrasil)

O repositório de extensões PT-BR é o **[RamonMods/CloudBrasil](https://github.com/RamonMods/CloudBrasil)** — separado deste repo (aqui fica o app e o mapa; lá ficam as extensões).

No app: **Configurações → Extensões → Adicionar repositório** e cole:

```
https://raw.githubusercontent.com/RamonMods/CloudBrasil/main/builds/repo.json
```

Ou use o shortcode `CloudBrasil`.

<a id="idiomas"></a>

## Idiomas

Mesmo sem contribuir com código ou documentação, você pode ajudar com traduções. A contribuição é muito bem-vinda:

<a href="https://hosted.weblate.org/engage/cloudstream/">
  <img src="https://hosted.weblate.org/widgets/cloudstream/-/app/multi-auto.svg" alt="Status das traduções" />
</a>

<a id="mapa-do-ecossistema"></a>

## Mapa do ecossistema

O app é só uma parte do projeto. A organização `recloudstream` mantém 25 repositórios: plugin Gradle, extensões oficiais, lista de repositórios, documentação, bibliotecas e forks. Veja o levantamento completo em [ECOSSISTEMA.md](ECOSSISTEMA.md) e o fluxo de build em [ARQUITETURA.md](ARQUITETURA.md).

<a id="outras-fontes"></a>

## Outras fontes

- [Solução de problemas](https://recloudstream.github.io/csdocs/troubleshooting/)
- [Outros repositórios de plugins](https://recloudstream.github.io/csdocs/repositories/)
- Configuração para outros dispositivos: [Android TV](https://recloudstream.github.io/csdocs/other-devices/tv/), [Windows](https://recloudstream.github.io/csdocs/other-devices/windows/), [Linux](https://recloudstream.github.io/csdocs/other-devices/linux/)
- Site: https://dweb.link/ipns/cloudstream.on.fleek.co/

## Aviso legal

Este repositório é um projeto de software livre (GPL-3.0) e não hospeda nem indexa conteúdo audiovisual. Extensões recomendadas não são moderadas nem endossadas oficialmente. Se você é titular de direitos autorais e identificar uma extensão que os viole, avise os mantenedores.

## Licença

GPL-3.0 — ver [LICENSE](LICENSE).
