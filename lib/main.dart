import 'package:flutter/material.dart';
import 'pages/splash_pages.dart';

void main() {
  runApp(const BitCuriousApp());
}

class BitCuriousApp extends StatelessWidget {
  const BitCuriousApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BitCurious',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0C1445)),
      ),
      home: const SplashPages(),
    );
  }
}
