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

              return Container(
                width: 30,
                height: 30,
                margin: const EdgeInsets.all(1),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isHighlighted ? Colors.yellow : Colors.white,
                  border: Border.all(color: Colors.black12),
                ),
                child: Text(displayChar, style: const TextStyle(fontSize: 16)),
              );
            }),
          );
        },
      ),
    ),
  );
}
