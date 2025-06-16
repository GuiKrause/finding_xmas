import 'package:flutter/material.dart';
import 'package:xmas_algorithm/models/result.dart';

ResultadoBusca buscarPalavraNaMatriz(List<String> matriz, String palavra) {
  int linhas = matriz.length;
  if (linhas == 0) return ResultadoBusca(0, {});
  int colunas = matriz[0].length;
  int tamanho = palavra.length;
  int total = 0;

  Set<Offset> posicoesEncontradas = {};

  List<List<int>> direcoes = [
    [0, 1], // direita
    [1, 0], // baixo
    [0, -1], // esquerda
    [-1, 0], // cima
    [1, 1], // diagonal ↘
    [-1, -1], // diagonal ↖
    [1, -1], // diagonal ↙
    [-1, 1], // diagonal ↗
  ];

  for (int i = 0; i < linhas; i++) {
    for (int j = 0; j < colunas; j++) {
      for (var dir in direcoes) {
        int dx = dir[0];
        int dy = dir[1];

        int x = i;
        int y = j;

        bool encontrado = true;
        List<Offset> posicaoAtual = [];

        for (int k = 0; k < tamanho; k++) {
          if (x < 0 || x >= linhas || y < 0 || y >= colunas) {
            encontrado = false;
            break;
          }

          if (matriz[x][y] != palavra[k]) {
            encontrado = false;
            break;
          }

          posicaoAtual.add(Offset(x.toDouble(), y.toDouble()));

          x += dx;
          y += dy;
        }

        if (encontrado) {
          total++;
          posicoesEncontradas.addAll(posicaoAtual);
        }
      }
    }
  }

  return ResultadoBusca(total, posicoesEncontradas);
}