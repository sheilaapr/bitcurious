import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bitcurious/models/component_model.dart';
import 'package:bitcurious/models/project_model.dart';
import 'package:bitcurious/models/article_model.dart';

class BitcuriousApiService {
  static const String _baseUrl = 'https://bitcurious-json.vercel.app';

  // ================== VERSI MODEL (JSON -> MODEL) ======================
  static Future<Map<String, List<ComponentModel>>> fetchComponentsByCategoryModel() async {
    final uri = Uri.parse('$_baseUrl/components.json');
    final res = await http.get(uri);

    if (res.statusCode != 200) {
      throw Exception(
        'Gagal memuat components.json (code: ${res.statusCode}). Body: ${res.body}',
      );
    }

    final decoded = jsonDecode(res.body);
    if (decoded is! Map<String, dynamic>) {
      throw Exception('Format components.json tidak sesuai (harus Map).');
    }

    final Map<String, List<ComponentModel>> result = {};

    decoded.forEach((key, value) {
      if (value is List) {
        final list = value
            .whereType<Map<String, dynamic>>()
            .map((item) => ComponentModel.fromJson(key.toString(), item))
            .toList();
        result[key.toString()] = list;
      }
    });

    return result;
  }

  // Ambil semua komponen (kategori digabung)
  static Future<List<ComponentModel>> fetchAllComponentsModel() async {
    final byCategory = await fetchComponentsByCategoryModel();
    final List<ComponentModel> all = [];
    byCategory.forEach((_, list) => all.addAll(list));
    return all;
  }

  // Ambil daftar project sebagai List<ProjectModel>
  static Future<List<ProjectModel>> fetchProjectsModel() async {
    final uri = Uri.parse('$_baseUrl/projects.json');
    final res = await http.get(uri);

    if (res.statusCode != 200) {
      throw Exception(
        'Gagal memuat projects.json (code: ${res.statusCode}). Body: ${res.body}',
      );
    }

    final decoded = jsonDecode(res.body);
    if (decoded is! List) {
      throw Exception('Format projects.json tidak sesuai (harus List).');
    }

    return decoded
        .whereType<Map<String, dynamic>>()
        .map((item) => ProjectModel.fromJson(item))
        .toList();
  }

  // Ambil daftar artikel sebagai List<ArticleModel>
  static Future<List<ArticleModel>> fetchArticlesModel() async {
    final uri = Uri.parse('$_baseUrl/articles.json');
    final res = await http.get(uri);

    if (res.statusCode != 200) {
      throw Exception(
        'Gagal memuat articles.json (code: ${res.statusCode}). Body: ${res.body}',
      );
    }

    final decoded = jsonDecode(res.body);
    if (decoded is! List) {
      throw Exception('Format articles.json tidak sesuai (harus List).');
    }

    return decoded
        .whereType<Map<String, dynamic>>()
        .map((item) => ArticleModel.fromJson(item))
        .toList();
  }

  // Dipakai oleh ComponentsCategoriesPage & ComponentListPage
  static Future<Map<String, dynamic>> fetchComponentsMap() async {
    final modelMap = await fetchComponentsByCategoryModel();
    // konversi kembali ke Map<String, dynamic> berupa List<Map<String, dynamic>>
    return modelMap.map((key, list) {
      return MapEntry(
        key,
        list.map((c) => c.toJson()).toList(),
      );
    });
  }

  // Dipakai di ProjectReferencesPage & SearchPage
  static Future<List<Map<String, dynamic>>> fetchProjects() async {
    final models = await fetchProjectsModel();
    return models.map((p) => p.toJson()).toList();
  }

  // Dipakai di ArticlesPage & SearchPage
  static Future<List<Map<String, dynamic>>> fetchArticles() async {
    final models = await fetchArticlesModel();
    return models.map((a) => a.toJson()).toList();
  }
}
