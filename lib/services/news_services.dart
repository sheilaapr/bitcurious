// lib/services/news_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

/// Ganti dengan API key dari newsapi.org
const String NEWS_API_KEY = 'f9dfed1d3fab47ac93995c61e23bf67e';

class NewsArticle {
  final String title;
  final String description;
  final String url;
  final String? imageUrl;
  final String sourceName;
  final DateTime? publishedAt;

  NewsArticle({
    required this.title,
    required this.description,
    required this.url,
    required this.sourceName,
    this.imageUrl,
    this.publishedAt,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      title: (json['title'] ?? '') as String,
      description: (json['description'] ?? '') as String,
      url: (json['url'] ?? '') as String,
      imageUrl: json['urlToImage'] as String?,
      sourceName: (json['source']?['name'] ?? '') as String,
      publishedAt: json['publishedAt'] != null
          ? DateTime.tryParse(json['publishedAt'] as String)
          : null,
    );
  }
}

class NewsService {
  static const String _baseUrl = 'https://newsapi.org/v2/everything';

  /// Ambil berita seputar teknologi, IoT, elektronika (bahasa Indonesia kalau ada).
  Future<List<NewsArticle>> fetchTechNews({String? keyword}) async {
    final query = keyword == null || keyword.trim().isEmpty
        ? 'iot OR "internet of things" OR elektronika OR mikrokontroler'
        : keyword;

    final uri = Uri.parse(_baseUrl).replace(queryParameters: {
      'apiKey': NEWS_API_KEY,
      'q': query,
      'language': 'id',        // coba berita berbahasa Indonesia dulu
      'sortBy': 'publishedAt',
      'pageSize': '20',
    });

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception(
        'HTTP ${response.statusCode}: ${response.body}',
      );
    }

    final Map<String, dynamic> body =
        jsonDecode(response.body) as Map<String, dynamic>;

    if (body['status'] != 'ok') {
      final msg = (body['message'] ?? 'Unknown error').toString();
      throw Exception('NewsAPI error: $msg');
    }

    final List<dynamic> articlesJson = body['articles'] as List<dynamic>;
    return articlesJson
        .map((a) => NewsArticle.fromJson(a as Map<String, dynamic>))
        .toList();
  }
}
