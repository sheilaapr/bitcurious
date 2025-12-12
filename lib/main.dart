import 'package:flutter/material.dart';
import 'pages/splash_pages.dart';
import 'services/pinned_repository.dart';

Future<void> main() async {
  // Wajib dipanggil dulu kalau mau pakai async sebelum runApp
  WidgetsFlutterBinding.ensureInitialized();

  // Load data pinned dari SharedPreferences
  await PinnedRepository.init();

  // Error widget custom (supaya nggak muncul red screen jelek)
  ErrorWidget.builder = (FlutterErrorDetails details) {
    // Tetap log ke console supaya kalau mau dicek masih kelihatan
    debugPrint('Flutter error: ${details.exceptionAsString()}');
    debugPrintStack(stackTrace: details.stack);

    // Di UI, cukup widget kosong (bisa kamu ganti dengan placeholder lain)
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
