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

  final rowLength = matrix.isNotEmpty ? matrix.first.length : 0;

  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: SizedBox(
      width: rowLength * 32,
      child: ListView.builder(
        itemCount: matrix.length,
        itemBuilder: (context, row) {
          return Row(
            children: List.generate(rowLength, (col) {
              final isHighlighted = positionsFound.contains(
                Offset(row.toDouble(), col.toDouble()),
              );

              final displayChar = (searchPerformed && !isHighlighted)
                  ? '.'
                  : matrix[row][col];

              Color squareBackgroundColor = isHighlighted
                  ? AppColors.secondary
                  : AppColors.primary;

              Color textForegroundColor = displayChar == '.'
                  ? AppColors.secondary
                  : searchPerformed
                  ? AppColors.primary
                  : AppColors.secondary;

              return Container(
                width: 30,
                height: 30,
                margin: const EdgeInsets.all(1),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: squareBackgroundColor,
                  border: Border.all(color: AppColors.tertiary),
                ),
                child: Text(
                  displayChar,
                  style: TextStyle(fontSize: 16, color: textForegroundColor),
                ),
              );
            }),
          );
        },
      ),
    ),
  );
}
