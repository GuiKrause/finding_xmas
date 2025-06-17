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

  Color resolveButtonColor(bool enabled) =>
      enabled ? AppColors.secondary : Colors.grey[300]!;

  Color resolveIconColor(bool enabled) =>
      enabled ? Colors.white : Colors.grey[500]!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondary,
        title: const Text('XMAS Word Search', style: TextStyle(
          color: AppColors.primary
        ),),
        actions: [
          IconButton(
            onPressed: loadFile,
            icon: const Icon(Icons.upload_file),
            tooltip: 'Load Matrix',
            style: FilledButton.styleFrom(
              foregroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                width: double.infinity,
                child: matrix.isEmpty
                    ? null
                    : Card(
                      color: AppColors.secondary,
                      elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Total words found',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                '$totalFound',
                                style: const TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
              if (loading)
                const CircularProgressIndicator()
              else if (matrix.isEmpty)
                Expanded(child: Center(child: const Text('No matrix loaded.')))
              else
                Expanded(
                  flex: 5,
                  child: buildMatrixView(
                    searchPerformed: searchPerformed,
                    matrix: matrix,
                    initialLine: initialLine,
                    visibleLines: visibleLines,
                    positionsFound: positionsFound,
                  ),
                ), // SizedBox(height: 60),
            ],
          ),
        ),
      ),
      floatingActionButton: matrix.isEmpty
          ? null
          : FloatingActionButton(
              onPressed: calculateXMAS,
              backgroundColor: AppColors.secondary,
              child: Icon(Icons.search),
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
        loading = false;
      });
    } catch (e) {
      debugPrint('Erro on load file: $e');
      setState(() {
        loading = false;
      });
    }
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
