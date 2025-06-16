import 'package:flutter/material.dart';
import 'package:xmas_algorithm/theme/theme.dart';

Widget buildMatrixView({
  required List<String> matrix,
  required int initialLine,
  required int visibleLines,
  required Set<Offset> positionsFound,
  required bool searchPerformed,
}) {
  if (matrix.isEmpty) return const SizedBox();

  int columns = matrix[0].length;
  double cellSize = 25;
  double cellMargin = 2;

  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(visibleLines, (i) {
        int linhaIndex = initialLine + i;
        if (linhaIndex >= matrix.length) return const SizedBox();

        return Row(
          children: List.generate(columns, (j) {
            Offset position = Offset(linhaIndex.toDouble(), j.toDouble());
            bool marked = positionsFound.contains(position);

            String char;

            if (!searchPerformed) {
              char = matrix[linhaIndex][j];
            } else {
              char = marked ? matrix[linhaIndex][j] : '.';
            }

            return Container(
              width: cellSize,
              height: cellSize,
              alignment: Alignment.center,
              margin: EdgeInsets.all(cellMargin / 2),
              decoration: BoxDecoration(
                color: marked ? AppColors.highlight : AppColors.borderCell,
                border: Border.all(color: AppColors.borderCell),
              ),
              child: Text(
                char,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: marked ? FontWeight.bold : FontWeight.normal,
                  color: Colors.black,
                ),
              ),
            );
          }),
        );
      }),
    ),
  );
}
