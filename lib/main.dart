import 'package:flutter/material.dart';
import 'pages/splash_pages.dart';

void main() {
  // Pastikan binding sudah siap sebelum set error handler
  WidgetsFlutterBinding.ensureInitialized();

  // Ganti tampilan default layar merah error Flutter
  ErrorWidget.builder = (FlutterErrorDetails details) {
    // Tetap log ke console supaya kalau mau dicek masih kelihatan
    debugPrint('Flutter error: ${details.exceptionAsString()}');
    debugPrintStack(stackTrace: details.stack);

    // Jangan tampilkan apa-apa di UI (no kilat merah/putih),
    // cukup widget kosong.
    return const SizedBox.shrink();
  };

  // Tetap kirim error ke console (tanpa red screen overlay)
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
  };

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
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0C1445),
        ),
      ),
      home: const SplashPages(),
    );
  }
}
