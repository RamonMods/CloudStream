## Biblioteca de extensões do CloudStream

Esta é a superfície oficial da API para todos os plugins do CloudStream.

Para garantir que todos os plugins funcionem tanto na versão estável quanto na pré-release, precisamos manter compatibilidade binária em toda mudança. Toda alteração nova deve ser marcada com `@Prerelease` para evitar uso acidental por quem desenvolve extensões.

Usamos a validação de compatibilidade binária do Kotlin:

```
./gradlew checkKotlinAbi
```

Se por algum motivo você precisar atualizar a compatibilidade binária, edite manualmente `api/jvm/library.api` ou use:

```
./gradlew updateKotlinAbi
```
