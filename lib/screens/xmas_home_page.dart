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

  static const int visibleLines = 20;
  int initialLine = 0;

  @override
  Widget build(BuildContext context) {
    String description =
        "Use the upload icon in the top app bar to load the matrix file. Once loaded, tap the search button to find all occurrences of 'XMAS' in every direction.";
    String tolltipText = "Load Matrix";
    String noMatrixText = "No matrix loaded.";
    String totalFoundText = "Total words found";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondary,
        title: const Text(
          'XMAS Search',
          style: TextStyle(color: AppColors.primary),
        ),
        actions: [
          IconButton(
            onPressed: loadFile,
            icon: const Icon(Icons.upload_file),
            tooltip: tolltipText,
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
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          description,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.quaternary,
                          ),
                        ),
                      )
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
                                totalFoundText,
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
                Expanded(
                  child: Center(
                    child: Text(
                      noMatrixText,
                      style: TextStyle(color: AppColors.quaternary),
                    ),
                  ),
                )
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
                ),
            ],
          ),
        ),
      ),
      floatingActionButton: matrix.isEmpty
          ? null
          : FloatingActionButton(
              onPressed: calculateXMAS,
              backgroundColor: AppColors.secondary,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: AppColors.primary, width: 2),
                borderRadius: BorderRadius.circular(16),
              ),
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
          .map((line) => line.trim())
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

    final result = searchWordInMatrix(matrix, word);

    setState(() {
      totalFound = result.total;
      positionsFound = result.positions;
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
