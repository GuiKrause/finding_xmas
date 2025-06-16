# XMAS Word Search - Flutter

Aplicativo Flutter para busca da palavra **XMAS** em uma matriz de letras, implementando um algoritmo que encontra todas as ocorrências da palavra na matriz, incluindo orientações horizontal, vertical, diagonal, escrita para trás e até sobreposições.

---

## Funcionalidades

- Carregamento de arquivo `.txt` contendo a matriz de letras.
- Busca completa por todas as ocorrências da palavra **XMAS** nas 8 direções possíveis.
- Exibição da matriz na tela, destacando as letras que fazem parte das palavras encontradas.
- Substituição dos caracteres que não fazem parte de nenhuma ocorrência por pontos (`.`) após a busca.
- Contador do total de ocorrências encontradas.
- Botões para carregar arquivo, iniciar busca e navegar pela matriz (rolagem, ir ao topo e final).
- Interface limpa e simples, usando tema personalizado.

---

## Como usar

1. Coloque o arquivo de entrada `input.txt` dentro da pasta `assets` do projeto (pasta já configurada no `pubspec.yaml`).

2. Certifique-se de ter o Flutter instalado em sua máquina. [Flutter Installation Guide](https://flutter.dev/docs/get-started/install)

3. No terminal, dentro da pasta do projeto, rode:

   ```bash
   flutter pub get
   flutter run
   ```

4. No app:

    Clique em Carregar Arquivo TXT para carregar a matriz.

    Clique em Buscar "XMAS" para iniciar a busca das ocorrências.

    Use os botões de navegação para percorrer a matriz.

## Algoritmo de busca

- Percorre toda a matriz, buscando a palavra "XMAS" em todas as direções:

    - Horizontal (direita e esquerda)

    - Vertical (para baixo e para cima)

    - Diagonais (4 direções)

- Encontra todas as ocorrências, inclusive as sobrepostas.

- Armazena as posições de todas as letras encontradas para destacar na UI.

## Estrutura do Projeto

- main.dart — Código principal do app e lógica da UI.

- theme/theme.dart — Definição de cores e tema personalizado.

- assets/input.txt — Arquivo de entrada com a matriz de letras.

## Autor

Guilherme - contato.guilhermekrause@gmail.com