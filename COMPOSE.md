# Guia de migração para Compose

## 1. MVI em vez de MVVM

O projeto atual do CloudStream usa a arquitetura MVVM de forma simplificada. A interface chama funções do viewmodel, que responde com campos `LiveData` observados. Isso funcionou, mas gera muito código repetitivo e cria atrito.

Para facilitar o trabalho com Compose, a nova arquitetura será baseada em **MVI**. Resumindo: o viewmodel expõe uma única classe imutável observada e recebe todos os eventos da interface por uma única classe selada. Toda a tela deve poder ser recriada a partir desse estado, e todas as interações devem poder ser repetidas usando apenas o callback de eventos.

Para uma explicação detalhada, veja: https://www.youtube.com/watch?v=b2z1jvD4VMQ

Isso faz parte do esforço para tornar o CloudStream multiplataforma, pois permite separar interface e lógica.

## 2. Bibliotecas compatíveis com KMP

Planejamos usar o Kotlin Multiplatform (KMP) para compilar o código em diferentes arquiteturas. Para isso, só podemos usar bibliotecas compatíveis com KMP — nada de Java. Portanto, todo pull request deve garantir que usa apenas bibliotecas compatíveis com KMP.

## 3. Mudanças na interface

Ao migrar para a nova interface em Compose, você tem a oportunidade de melhorá-la. Porém, isso deve servir para refrescar a interface, não para redesenhar tudo. É importante frisar que o processo não pode perder nenhuma funcionalidade da interface antiga e deve ser bem conservador ao adicionar novas.
