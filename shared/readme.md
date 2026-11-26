## Motivação

Este documento é uma explicação para pessoas entenderem o **porquê**, e não o **como**, da arquitetura central do CloudStream daqui em diante.

## Decisões de projeto

As decisões a seguir foram testadas no projeto irmão QuickNovel com muito sucesso e um processo de portabilidade tranquilo. Para inspiração e código em uma base parecida, veja o QuickNovel.

### Estrutura de arquivos

A pasta `shared` deve conter a interface Compose compartilhada entre plataformas e pode atuar como cola para a lógica de negócio. Isso é separado da `library`, que contém as primitivas de um sistema de plugins multiplataforma sem interface.

Observe que não queremos um layout de tela compartilhado, porque cada plataforma tem sua própria linguagem de design e peculiaridades. Em vez disso, os ViewModels devem ficar totalmente separados do processo de renderização, e cada componente de UI deve ser compartilhado entre todas as plataformas. Isso garante que os ViewModels não consigam trapacear com saídas de emergência sujas, uma API com vazamentos ou elementos de interface que sequestram a lógica de negócio.

**Incluir:** *ViewModels*, *componentes de UI* e *tematização*.

**Evitar:** *telas inteiras*, *APIs de plugins* e *XML de layout do Android*.

Observe também que, embora seria bom ter um downloader ou player de vídeo multiplataforma, simplesmente não é viável nem desejável escrever esse sistema. Portanto, cada plataforma deve ter uma implementação separada do comportamento específico, interoperando de perto com os sistemas nativos.

### MVI

MVI (Model View Intent) é a estrutura central que usaremos para construir a interface multiplataforma. A razão dessa decisão é que a arquitetura MVVM atual gera muito código repetitivo e é muito incômoda ao trabalhar com Compose. Usaremos um estado de interface único e imutável, com coleções imutáveis do Kotlin, criando uma UI segura para threads e performática. Além disso, como o viewmodel é compartilhado entre plataformas, ele deve receber a implementação específica de banco de dados/preferências/downloads por injeção de dependência e composição.

**Usar:** *PersistentList*, *val*, *injeção de dependência* e *composição*.

**Evitar:** *List*, *var*, *globais* e *herança*.

Observe que este processo busca substituir a interface atual de forma compatível com versões anteriores. Apenas o grafo de navegação deve mudar para apontar para os novos fragments. Assim podemos reverter se algum problema crítico for encontrado na reescrita em Compose, além de comparar funcionalidades sem precisar fazer checkout.

### Recursos e elementos visuais

**Imagens:** neste projeto o formato aceito é `XML Drawable resources`, em vez de `ImageVector` ou `.svg`. Isso facilita revisão, multiplataforma e edição. `ImageVector` é indesejável porque o arquivo precisa ser revisado para não conter código malicioso e não tem prévia integrada. Já arquivos SVG não são suportados nativamente no Android.

**Tradução:** o CloudStream já tem um conjunto enorme de traduções, mas para facilitar a portabilidade devemos limitar copiar e colar do projeto Android até que tudo seja convertido para Compose. Em parte porque o Weblate ainda não está configurado para o Compose multiplataforma.

**Estilos e temas:** no Compose não existem `styles.xml`/`colors.xml`/`dimens.xml`. Portanto, a estilização é feita inteiramente em código, mas deve usar exatamente as mesmas cores para evitar diferenças visuais ao portar.

**UI/UX:** a experiência pretendida ao usar o CloudStream deve ser a mesma, mas a interface deve ser refrescada para um estilo Material 3, com cantos arredondados e mais foco no tema claro. Porém, não são aceitos interfaces glassmorphic, desfocadas ou com gradientes.

### Configurações e Mihon

O sistema de configurações foi totalmente forkado do projeto Tachiyomi, hoje Mihon. Isso porque o Mihon tem uma das melhores bases de código livre para Android e um sistema declarativo de preferências excelente, sem igual entre os sistemas de configuração Compose testados. Infelizmente, isso não é fornecido como biblioteca e por isso foi forkado importando os arquivos exatos usados.

### Por que Compose?

Durante a vida do CloudStream, o app foi redesenhado e reescrito várias vezes.

**Downloader em C# → Xamarin Nativo → Xamarin multiplataforma → Android Nativo XML → ViewBinding → Compose Multiplatform**

Experimentamos diferentes tecnologias de interface como **Blazor**, **Electron**, **PWA**, **WPF**, **UWP**, **Windows Forms** e **CLI/Console** no CloudStream. Também investigamos projetos em **Flutter** e **React Native**.

Porém, nenhum desses frameworks entregou uma boa experiência de desenvolvimento que fosse ao mesmo tempo performática e multiplataforma. Compose era a única opção real, mas não existia quando começamos o CloudStream 3. Android Nativo XML era simplesmente a opção menos ruim para criar um app Android.

### CloudStream 4?

O app Android atual se chama CloudStream 3, e esta reescrita em Compose se chamará CloudStream 4. Porém, o app Android será atualizado, não substituído pelo Compose. A ideia é uma implantação contínua e gradual de atualizações para todos que usam o app Android. Portanto, CloudStream 4 se refere à nova interface Compose, aos recursos e ao suporte multiplataforma.

## Uso de IA

Devido à popularidade dos LLMs, o CloudStream 3 foi reescrito inteiramente 4 ou mais vezes por pessoas independentes usando Compose para desktop com diferentes modelos de LLM. Essas versões não foram mescladas, por causa da bagunça completa do código gerado por IA, tanto em qualidade quanto em performance.

Portanto, eu (LagradOst) não aceito nem permito nenhum pull request sobre a reescrita em Compose antes que eu coloque as estruturas centrais no lugar. A reescrita em Compose deve ser uma refatoração e uma melhoria de qualidade para todos envolvidos, resolvendo a enorme dívida técnica que já temos. XML e planos antigos forçaram más decisões de projeto, que podemos melhorar bastante. Porém, em nenhum momento quero que IA crie as bases de algo tão importante.

A ideia é fornecer um ponto de partida sólido para que contribuidores de primeira vez e LLMs consigam entender e trabalhar com o código, não entregar um produto o mais rápido possível. Este não é um projeto com apenas uma pessoa envolvida. Uma base de código gerada por IA e bagunçada dificulta muito revisões e contribuições para todos.
