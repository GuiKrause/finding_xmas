import 'package:flutter/material.dart';
import 'package:xmas_algorithm/theme/theme.dart';

Widget buildMatrizView({
  required List<String> matriz,
  required int linhaInicial,
  required int linhasVisiveis,
  required Set<Offset> posicoesEncontradas,
  required bool buscaRealizada,
}) {
  if (matriz.isEmpty) return const SizedBox();

  int colunas = matriz[0].length;
  double cellSize = 25;
  double cellMargin = 2;

  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(linhasVisiveis, (i) {
        int linhaIndex = linhaInicial + i;
        if (linhaIndex >= matriz.length) return const SizedBox();

        return Row(
          children: List.generate(colunas, (j) {
            Offset posicao = Offset(linhaIndex.toDouble(), j.toDouble());
            bool destacado = posicoesEncontradas.contains(posicao);

            String char;

            if (!buscaRealizada) {
              char = matriz[linhaIndex][j];
            } else {
              char = destacado ? matriz[linhaIndex][j] : '.';
            }

            return Container(
              width: cellSize,
              height: cellSize,
              alignment: Alignment.center,
              margin: EdgeInsets.all(cellMargin / 2),
              decoration: BoxDecoration(
                color: destacado ? AppColors.highlight : AppColors.borderCell,
                border: Border.all(color: AppColors.borderCell),
              ),
              child: Text(
                char,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: destacado ? FontWeight.bold : FontWeight.normal,
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
