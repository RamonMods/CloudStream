<div align="center">

# CloudStream

**Edição brasileira do CloudStream (CloudBrasil)**

**⚠️ Aviso: por padrão o app não traz nenhuma fonte de vídeo. Você precisa instalar extensões para adicionar funcionalidade.**

<a href="https://github.com/RamonMods/CloudStream/releases/latest"><img src="https://img.shields.io/github/v/release/RamonMods/CloudStream?style=for-the-badge&logo=android&logoColor=white&label=Baixar%20APK" alt="Baixar APK" height="50"/></a>

**Discord: em breve.**

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

**Não crie extensões ilegais nem use extensões que hospedem mídia com direitos autorais.** A posição do projeto sobre DMCA e EUCD está descrita no aviso legal deste repositório.

### Recursos

- **Sem anúncios**
- Sem rastreamento ou analytics
- Marcadores
- Suporte a celular e TV
- Chromecast
- Sistema de extensões para personalização

<a id="instalacao"></a>

## Instalação

- [Baixar a versão mais recente](https://github.com/RamonMods/CloudStream/releases/latest) — os APKs são publicados automaticamente em toda tag `v*`.
- [APKs de teste compilados pela CI](https://github.com/RamonMods/CloudStream/actions/workflows/build-apk.yml) — para acompanhar mudanças antes de uma versão marcada.
- [Arquitetura e compilação](ARQUITETURA.md) — para compilar a partir do código-fonte.

Esta edição usa o identificador próprio `com.ramonmods.cloudstream`, então pode ser instalada ao lado do app original sem conflito. No Android, é preciso permitir a instalação de apps de fontes desconhecidas para o APK baixado.

<a id="contribuindo"></a>

## Como contribuir

Aceitamos contribuições de boa vontade. Para começar, veja a [aba de issues](https://github.com/RamonMods/CloudStream/issues). Antes de mexer na interface, leia o [guia de migração para Compose](COMPOSE.md) e a [política de uso de IA](AI-POLICY.md), ambos em português neste repositório.

<a id="problemas"></a>

## Problemas

Aceitamos issues e pull requests, mas pedimos que use um [modelo](https://github.com/RamonMods/CloudStream/issues/new/choose):

- [Modelo de relatório de bug](https://github.com/RamonMods/CloudStream/issues/new?labels=bug&template=application-bug.yml): informe versão baixada, dispositivo, versão do Android (e da API, se possível), comportamento esperado e real, e principalmente passos claros para reproduzir.
- [Modelo de sugestão](https://github.com/RamonMods/CloudStream/issues/new?labels=enhancement&template=feature-request.yml): antes de enviar, verifique se a sugestão já existe.

<a id="extensoes"></a>

## Extensões

O funcionamento das extensões está documentado em [ARQUITETURA.md](ARQUITETURA.md), que explica o formato `.cs3`, o `repo.json`, o `plugins.json` e o sistema de plugins do app.

Neste repositório você encontra:

| Arquivo | Conteúdo |
|---|---|
| [ARQUITETURA.md](ARQUITETURA.md) | Módulos do app, sistema de plugins, `#EXTINF`/`.cs3`, `repo.json` e `plugins.json` |
| [ECOSSISTEMA.md](ECOSSISTEMA.md) | Todos os repositórios mapeados do ecossistema e o papel de cada um |
| [REPOSITORIOS.md](REPOSITORIOS.md) | Repositórios de plugins conhecidos e como verificar se estão vivos |
| [scripts/clonar-ecossistema.ps1](scripts/clonar-ecossistema.ps1) | Clona o ecossistema inteiro em uma pasta única |

### Extensões brasileiras (CloudBrasil)

O repositório de extensões PT-BR é o **[RamonMods/CloudBrasil](https://github.com/RamonMods/CloudBrasil)** — separado deste repo (aqui fica o app e o mapa; lá ficam as extensões).

No app: **Configurações → Extensões → Adicionar repositório** e cole:

```
https://raw.githubusercontent.com/RamonMods/CloudBrasil/main/builds/repo.json
```

Esse repositório já vem configurado na primeira instalação, mas pode ser removido pelo usuário.

### IPTV / TV ao vivo

Em **Configurações → Extensões → Adicionar IPTV**, cole a URL do seu servidor (ou do M3U) e, se o login não estiver no link, informe usuário e senha. O app valida a conta antes de salvar e mostra o **vencimento** e as **conexões** quando o provedor informa esses dados.

A extensão **Xtream** do CloudBrasil precisa estar instalada para os canais aparecerem. Nenhuma credencial é enviada para este repositório — elas ficam só no aparelho.

<a id="idiomas"></a>

## Idiomas

As traduções ficam em `app/src/main/res/values-*` e podem ser editadas direto no repositório. Contribuições de tradução são muito bem-vindas.

<a id="mapa-do-ecossistema"></a>

## Mapa do ecossistema

O app é só uma parte do projeto. O levantamento técnico dos repositórios mapeados (plugin Gradle, extensões, lista de repositórios, documentação, bibliotecas e forks) está em [ECOSSISTEMA.md](ECOSSISTEMA.md), com o fluxo de build em [ARQUITETURA.md](ARQUITETURA.md) e os detalhes em [mapa/](mapa/).

<a id="outras-fontes"></a>

## Outras fontes

- [Como o app funciona](mapa/01-app.md)
- [Sistema de plugins](mapa/02-plugins.md)
- [Bibliotecas internas](mapa/03-libs.md)
- [Novas extensões mapeadas](mapa/04-extensoes-novas.md)
- [Situação dos sites avaliados](mapa/05-saimuel-sites.md)

## Aviso legal

Este repositório é um projeto de software livre (GPL-3.0) e não hospeda nem indexa conteúdo audiovisual. Extensões recomendadas não são moderadas nem endossadas oficialmente. Se você é titular de direitos autorais e identificar uma extensão que os viole, avise os mantenedores.

## Licença

GPL-3.0 — ver [LICENSE](LICENSE).

---

Mantido por **RamonMods**. Código sob GPL-3.0, com créditos históricos aos colaboradores do projeto original.
