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
  List<String> matrix = [];
  String word = "XMAS";
  int totalFound = 0;
  Set<Offset> positionsFound = {};
  bool searchPerformed = false;
  bool loading = false;

  // Controle da janela
  static const int visibleLines = 20;
  int initialLine = 0;

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
                    onPressed: loadFile,
                    child: const Text('Load Matrix'),
                  ),
                  ElevatedButton(
                    onPressed: calculateXMAS,
                    child: const Text('Search "XMAS"'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text('Total words found: $totalFound'),
              const SizedBox(height: 20),
              if (loading)
                const CircularProgressIndicator()
              else if (matrix.isEmpty)
                const Text('No matrix loaded.')
              else
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        flex: 5,
                        child: buildMatrixView(
                          searchPerformed: searchPerformed,
                          matrix: matrix,
                          initialLine: initialLine,
                          visibleLines: visibleLines,
                          positionsFound: positionsFound,
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
                                  initialLine > 0
                                      ? AppColors.secondary
                                      : Colors.grey[300],
                                ),
                                foregroundColor: WidgetStateProperty.all(
                                  initialLine > 0
                                      ? Colors.white
                                      : Colors.grey[500],
                                ),
                              ),
                              icon: const Icon(Icons.arrow_upward),
                              onPressed: initialLine > 0
                                  ? () => moveWindow(-1)
                                  : null,
                            ),
                            const SizedBox(width: 20),
                            IconButton(
                              disabledColor: Colors.grey,
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(
                                  (initialLine + visibleLines) < matrix.length
                                      ? AppColors.secondary
                                      : Colors.grey[300],
                                ),
                                foregroundColor: WidgetStateProperty.all(
                                  (initialLine + visibleLines) < matrix.length
                                      ? Colors.white
                                      : Colors.grey[500],
                                ),
                              ),
                              icon: const Icon(Icons.arrow_downward),
                              onPressed:
                                  (initialLine + visibleLines) < matrix.length
                                  ? () => moveWindow(1)
                                  : null,
                            ),
                            const SizedBox(width: 20),
                            ElevatedButton(
                              onPressed: initialLine > 0
                                  ? () {
                                      setState(() {
                                        initialLine = 0;
                                      });
                                    }
                                  : null,
                              child: const Text('Top'),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              onPressed:
                                  (initialLine + visibleLines) < matrix.length
                                  ? () {
                                      setState(() {
                                        initialLine =
                                            (matrix.length - visibleLines)
                                                .clamp(0, matrix.length);
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

  Future<void> loadFile() async {
    setState(() {
      loading = true;
      matrix = [];
      totalFound = 0;
      positionsFound.clear();
      initialLine = 0;
      searchPerformed = false;
    });

    try {
      final content = await rootBundle.loadString('assets/input.txt');
      final lines = content
          .split('\n')
          .map((linha) => linha.trim())
          .where((l) => l.isNotEmpty)
          .toList();

      setState(() {
        matrix = lines;
      });
    } catch (e) {
      debugPrint('Erro on load file: $e');
    }

    setState(() {
      loading = false;
    });
  }

  void calculateXMAS() {
    if (matrix.isEmpty) return;

    final resultado = searchWordInMatrix(matrix, word);

    setState(() {
      totalFound = resultado.total;
      positionsFound = resultado.positions;
      searchPerformed = true;
    });
  }

  void moveWindow(int delta) {
    setState(() {
      initialLine += delta;
      if (initialLine < 0) initialLine = 0;
      if (initialLine > matrix.length - visibleLines) {
        initialLine = matrix.length - visibleLines;
      }
    });
  }
}
