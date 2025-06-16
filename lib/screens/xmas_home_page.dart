import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xmas_algorithm/theme/theme.dart';
import 'package:xmas_algorithm/utils/find_word_in_matrix.dart';
import 'package:xmas_algorithm/widgets/build_matrix_view.dart';

class XMASHomePage extends StatefulWidget {
  const XMASHomePage({super.key});

  @override
  State<XMASHomePage> createState() => _XMASHomePageState();
}

class _XMASHomePageState extends State<XMASHomePage> {
  List<String> matriz = [];
  String palavra = "XMAS";
  int totalEncontrado = 0;
  Set<Offset> posicoesEncontradas = {};
  bool buscaRealizada = false;
  bool carregando = false;

  // Controle da janela
  static const int linhasVisiveis = 20;
  int linhaInicial = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('XMAS Word Search'),
        backgroundColor: AppColors.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 10,
                children: [
                  ElevatedButton(
                    onPressed: carregarArquivo,
                    child: const Text('Load Matrix'),
                  ),
                  ElevatedButton(
                    onPressed: calcularXMAS,
                    child: const Text('Search "XMAS"'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text('Total words found: $totalEncontrado'),
              const SizedBox(height: 20),
              if (carregando)
                const CircularProgressIndicator()
              else if (matriz.isEmpty)
                const Text('Nenhuma matriz carregada.')
              else
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        flex: 5,
                        child: buildMatrizView(
                          buscaRealizada: buscaRealizada,
                          matriz: matriz,
                          linhaInicial: linhaInicial,
                          linhasVisiveis: linhasVisiveis,
                          posicoesEncontradas: posicoesEncontradas,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(
                                  linhaInicial > 0
                                      ? AppColors.secondary
                                      : Colors.grey[300],
                                ),
                                foregroundColor: WidgetStateProperty.all(
                                  linhaInicial > 0
                                      ? Colors.white
                                      : Colors.grey[500],
                                ),
                              ),
                              icon: const Icon(Icons.arrow_upward),
                              onPressed: linhaInicial > 0
                                  ? () => moverJanela(-1)
                                  : null,
                            ),
                            const SizedBox(width: 20),
                            IconButton(
                              disabledColor: Colors.grey,
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(
                                  (linhaInicial + linhasVisiveis) <
                                          matriz.length
                                      ? AppColors.secondary
                                      : Colors.grey[300],
                                ),
                                foregroundColor: WidgetStateProperty.all(
                                  (linhaInicial + linhasVisiveis) <
                                          matriz.length
                                      ? Colors.white
                                      : Colors.grey[500],
                                ),
                              ),
                              icon: const Icon(Icons.arrow_downward),
                              onPressed:
                                  (linhaInicial + linhasVisiveis) <
                                      matriz.length
                                  ? () => moverJanela(1)
                                  : null,
                            ),
                            const SizedBox(width: 20),
                            ElevatedButton(
                              onPressed: linhaInicial > 0
                                  ? () {
                                      setState(() {
                                        linhaInicial = 0;
                                      });
                                    }
                                  : null,
                              child: const Text('Top'),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              onPressed:
                                  (linhaInicial + linhasVisiveis) <
                                      matriz.length
                                  ? () {
                                      setState(() {
                                        linhaInicial =
                                            (matriz.length - linhasVisiveis)
                                                .clamp(0, matriz.length);
                                      });
                                    }
                                  : null,
                              child: const Text('Bottom'),
                            ),
                          ],
                        ),
                      ),
                      // SizedBox(height: 60),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> carregarArquivo() async {
    setState(() {
      carregando = true;
      matriz = [];
      totalEncontrado = 0;
      posicoesEncontradas.clear();
      linhaInicial = 0;
      buscaRealizada = false;
    });

    try {
      final conteudo = await rootBundle.loadString('assets/input.txt');
      final linhas = conteudo
          .split('\n')
          .map((linha) => linha.trim())
          .where((l) => l.isNotEmpty)
          .toList();

      setState(() {
        matriz = linhas;
      });
    } catch (e) {
      debugPrint('Erro on load file: $e');
    }

    setState(() {
      carregando = false;
    });
  }

  void calcularXMAS() {
    if (matriz.isEmpty) return;

    final resultado = buscarPalavraNaMatriz(matriz, palavra);

    setState(() {
      totalEncontrado = resultado.total;
      posicoesEncontradas = resultado.posicoes;
      buscaRealizada = true;
    });
  }

  void moverJanela(int delta) {
    setState(() {
      linhaInicial += delta;
      if (linhaInicial < 0) linhaInicial = 0;
      if (linhaInicial > matriz.length - linhasVisiveis) {
        linhaInicial = matriz.length - linhasVisiveis;
      }
    });
  }
}
