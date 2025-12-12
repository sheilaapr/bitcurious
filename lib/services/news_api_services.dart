import 'dart:convert';
import 'package:http/http.dart' as http;

// API key dengan daftar di https://newsapi.org/
const String newsApiKey = 'f9dfed1d3fab47ac93995c61e23bf67e';

class NewsApiService {
  static const String _baseUrl = 'newsapi.org';

  // Ambil berita teknologi / IoT terbaru.
  //
  // Di sini kita pakai endpoint `/v2/everything` supaya hasilnya lebih kaya,
  // dengan kata kunci terkait IoT dan elektronik.
  static Future<List<dynamic>> fetchTechNews() async {
    if (newsApiKey.isEmpty) {
      return [];
    }

    final uri = Uri.https(
      _baseUrl,
      '/v2/everything',
      {
        // kata kunci bisa kamu ubah sesuai kebutuhan
        'q': 'iot OR elektronik OR "internet of things" OR sensor',
        'pageSize': '10',
        'sortBy': 'publishedAt',
        'language': 'id',
        'apiKey': newsApiKey,
      },
    );

    final res = await http.get(uri);

    final decoded = jsonDecode(res.body);
    if (decoded is! Map<String, dynamic>) {
      throw Exception('Format response NewsAPI tidak valid.');
    }

    // NewsAPI pakai field "status" = "ok" / "error"
    final status = decoded['status']?.toString() ?? 'unknown';
    if (res.statusCode != 200 || status != 'ok') {
      final message = decoded['message'] ?? 'Terjadi kesalahan pada NewsAPI.';
      throw Exception('NewsAPI error ($status): $message');
    }

    final List<dynamic> articles = decoded['articles'] ?? [];

    return articles.map((raw) {
      final map = raw as Map<String, dynamic>;
      final source = (map['source'] ?? {}) as Map<String, dynamic>;
      return {
        'title': map['title'] ?? '',
        'description': map['description'] ?? '',
        'url': map['url'] ?? '',
        'urlToImage': map['urlToImage'] ?? '',
        'sourceName': source['name'] ?? '',
        'publishedAt': map['publishedAt'] ?? '',
      };
    }).toList();
  }
}
