# OpenWarp

> Painel desktop para o **OpenCode CLI** e o **Cloudflare WARP**: status, rotação de IP e retomada de conversa em um só lugar.

| Item | Informação |
|---|---|
| Repositório | [RamonMods/OpenWarp](https://github.com/RamonMods/OpenWarp) |
| Release mais recente | [Página de releases](https://github.com/RamonMods/OpenWarp/releases/latest) |
| Versão atual | **0.5.5** |
| Licença | **Apache-2.0** ([Apache License 2.0](https://www.apache.org/licenses/LICENSE-2.0)) |
| Stack | **Kotlin 2.4** + **Compose Multiplatform 1.12**, Material 3 Expressive |
| Plataforma | **Windows 10 ou mais recente, 64 bits** |

## O que é

O OpenWarp é um painel nativo que reúne o estado da sessão do OpenCode e da conexão Cloudflare WARP em uma janela só: WARP conectado ou desconectado, IP de saída, OpenCode rodando ou parado, monitor ativo e contador de rotações, com registro do que acontece em tempo real.

Ele acompanha o log do OpenCode, identifica erros de limite de uso, troca a rota de saída, valida a conexão e retoma a **mesma conversa** com o modelo que voltou a responder. Tudo é local — não existe servidor, conta ou backend do OpenWarp.

Entre os recursos estão rotação de IP manual e automática, histórico de IPs com país e datacenter, conversas recentes, modos de saída (WARP, automático, Tor, proxy HTTP, WireGuard, VPN Gate e direto), temas do OpenCode e atualização pelo GitHub com conferência de SHA-256.

## Relação com o CloudBrasil

O [RamonMods/CloudBrasil](https://github.com/RamonMods/CloudBrasil) fica no lado das **extensões** do CloudStream; o OpenWarp fica no lado da **infraestrutura de trabalho** do OpenCode. Eles se complementam na rotina do repositório único: quando o limite de cota do provedor cai e os subagentes param, a troca de IP feita pelo OpenWarp — seguida da validação da rota e da retomada da sessão — permite **retomar os subagentes** e seguir produzindo sem esperar o reset da cota.

## Instalação

Baixe o MSI na [página de releases](https://github.com/RamonMods/OpenWarp/releases/latest) e execute. O instalador cria o atalho no menu Iniciar e o MSI já inclui o runtime, sem precisar instalar Java. As configurações ficam em `%USERPROFILE%\.openwarp` e sobrevivem a atualizações.

Requisitos: Windows 10+ (64 bits), [OpenCode CLI](https://opencode.ai) no `PATH` e [Cloudflare WARP](https://www.cloudflare.com/warp/) em modo proxy na porta 40000.

---

Fonte: [README.md do OpenWarp](https://github.com/RamonMods/OpenWarp#readme). Projeto independente, não afiliado nem endossado pela Cloudflare ou pelo OpenCode.
