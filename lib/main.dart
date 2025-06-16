import 'package:flutter/material.dart';
import 'package:xmas_algorithm/screens/xmas_home_page.dart';
import 'theme/theme.dart';

void main() {
  runApp(const XMASApp());
}

class XMASApp extends StatelessWidget {
  const XMASApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'XMAS Word Search',
      theme: appTheme,
      home: const XMASHomePage(),
    );
  }
}
