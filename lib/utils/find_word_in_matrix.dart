import 'package:flutter/material.dart';
import 'package:xmas_algorithm/models/result.dart';

Result searchWordInMatrix(List<String> matrix, String word) {
  int lines = matrix.length;
  if (lines == 0) return Result(0, {});
  int columns = matrix[0].length;
  int size = word.length;
  int total = 0;

  Set<Offset> positionsFound = {};

  List<List<int>> directions = [
    [0, 1], // right
    [1, 0], // down
    [0, -1], // left
    [-1, 0], // up
    [1, 1], // diagonal ↘
    [-1, -1], // diagonal ↖
    [1, -1], // diagonal ↙
    [-1, 1], // diagonal ↗
  ];

  for (int i = 0; i < lines; i++) {
    for (int j = 0; j < columns; j++) {
      for (var dir in directions) {
        int dx = dir[0];
        int dy = dir[1];

        int x = i;
        int y = j;

        bool found = true;
        List<Offset> currentPosition = [];

        for (int k = 0; k < size; k++) {
          if (x < 0 || x >= lines || y < 0 || y >= columns) {
            found = false;
            break;
          }

          if (matrix[x][y] != word[k]) {
            found = false;
            break;
          }

          currentPosition.add(Offset(x.toDouble(), y.toDouble()));

          x += dx;
          y += dy;
        }

        if (found) {
          total++;
          positionsFound.addAll(currentPosition);
        }
      }
    }
  }

  return Result(total, positionsFound);
}