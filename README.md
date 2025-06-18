# XMAS Word Search - Flutter

Aplicativo Flutter para busca da palavra **XMAS** em uma matriz de letras, implementando um algoritmo que encontra todas as ocorrências da palavra na matriz, incluindo orientações horizontal, vertical, diagonal, escrita para trás e até sobreposições.

---

## Funcionalidades

- Carregamento de arquivo `.txt` contendo a matriz de letras.
- Busca completa por todas as ocorrências da palavra **XMAS** nas 8 direções possíveis.
- Exibição da matriz na tela, destacando as letras que fazem parte das palavras encontradas.
- Substituição dos caracteres que não fazem parte de nenhuma ocorrência por pontos (`.`) após a busca.
- Contador do total de ocorrências encontradas.
- Botões para carregar arquivo, e buscar palavras.
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

    Clique no ícone de upload de documento, na appbar, para carregar a matriz.

    Toque no botão flutuante (lupa), no canto inferior direito, para iniciar a busca por ocorrências.

    Realize a rolagem horizontal e vertical da tela, para verificar as ocorrências da palavra "XMAS".

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

- screens/xmas_home_page.dart — Arquivo com estrutura scaffold para layout.
- utils/find_word_in_matrix.dart — Função utilitária com lógica principal.

- widgets/build_matrix_view.dart — Componente da matriz.

## Autor

<table>
  <tr>
    <td align="center">
      <a href="https://github.com/GuiKrause">
        <img src="https://avatars.githubusercontent.com/u/134097567?v=4" width="100px;" alt="Guilherme Krause Ramos"/>
        <br/>
        <sub><b>Guilherme Krause Ramos</b></sub>
      </a>
    </td>
  </tr>
</table>