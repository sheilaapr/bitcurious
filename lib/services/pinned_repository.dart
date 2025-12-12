import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class PinnedComponent {
  final String name;
  final String description;
  final String imageUrl;
  final double price;
  final String categoryName;

  PinnedComponent({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.categoryName,
  });

  // ====== JSON Serialization ======

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'price': price,
      'categoryName': categoryName,
    };
  }

  factory PinnedComponent.fromJson(Map<String, dynamic> json) {
    return PinnedComponent(
      name: (json['name'] ?? '').toString(),
      description: (json['description'] ?? '').toString(),
      imageUrl: (json['imageUrl'] ?? '').toString(),
      price: (json['price'] is num)
          ? (json['price'] as num).toDouble()
          : 0.0,
      categoryName: (json['categoryName'] ?? '').toString(),
    );
  }
}

class PinnedRepository {
  static const String _storageKey = 'bitcurious_pinned_components';

  // List yang dipakai UI
  static final List<PinnedComponent> items = [];

  // Panggil sekali saat app start (di main.dart) untuk load data dari storage
  static Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_storageKey);

    if (raw == null || raw.isEmpty) return;

    final List<dynamic> list = jsonDecode(raw) as List<dynamic>;

    items
      ..clear()
      ..addAll(
        list
            .whereType<Map<String, dynamic>>()
            .map((e) => PinnedComponent.fromJson(e)),
      );
  }

  static Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(
      items.map((c) => c.toJson()).toList(),
    );
    await prefs.setString(_storageKey, encoded);
  }

  // Tambah pinned (hindari duplikat)
  static void add(PinnedComponent component) {
    final exists = items.any(
      (c) =>
          c.name == component.name &&
          c.categoryName == component.categoryName,
    );

    if (!exists) {
      items.add(component);
      _save(); // simpan ke SharedPreferences
    }
  }

  // Hapus pinned
  static void remove(String name, String categoryName) {
    items.removeWhere(
      (c) => c.name == name && c.categoryName == categoryName,
    );
    _save();
  }

  /// Hapus semua pinned (kalau suatu saat perlu)
  static Future<void> clearAll() async {
    items.clear();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_storageKey);
  }
}
