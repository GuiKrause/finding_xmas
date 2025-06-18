import 'package:flutter/material.dart';
import 'package:xmas_algorithm/screens/xmas_home_page.dart';
import 'theme/theme.dart';

void main() {
  runApp(const XMASApp());
}

class XMASApp extends StatelessWidget {
  const XMASApp({super.key});

  final String title = 'XMAS Search';
  final bool debugShowCheckedModeBanner = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: debugShowCheckedModeBanner,
      title: title,
      theme: appTheme,
      home: const XMASHomePage(),
    );
  }
}
