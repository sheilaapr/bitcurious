import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:bitcurious/pages/component_list_pages.dart';

class ComponentsCategoriesPage extends StatefulWidget {
  const ComponentsCategoriesPage({super.key});

  @override
  State<ComponentsCategoriesPage> createState() =>
      _ComponentsCategoriesPageState();
}

class _ComponentsCategoriesPageState extends State<ComponentsCategoriesPage> {
  List<String> _categories = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  @override
  void setState(VoidCallback fn) {
    if (!mounted) return;
    super.setState(fn);
  }

  Future<void> _loadCategories() async {
    try {
      final String jsonStr =
          await rootBundle.loadString('assets/data/components.json');
      final decoded = json.decode(jsonStr);

      if (decoded is! Map<String, dynamic>) {
        setState(() {
          _isLoading = false;
          _error = 'Format components.json tidak sesuai (harus Map).';
        });
        return;
      }

      final keys = decoded.keys
          .whereType<String>()
          .toList();

      keys.sort();

      setState(() {
        _categories = ['All', ...keys]; // tambah kategori "All"
        _isLoading = false;
        _error = null;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = 'Gagal memuat kategori: $e';
      });
    }
  }

  void _openCategory(String categoryName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ComponentListPage(categoryName: categoryName),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color navy = Color(0xFF0B0C3A);

    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            _error!,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.redAccent),
          ),
        ),
      );
    }

    if (_categories.isEmpty) {
      return const Center(
        child: Text(
          'Tidak ada kategori komponen.\nCek kembali components.json.',
          textAlign: TextAlign.center,
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Pilih Kategori Komponen',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: navy,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Kategori diambil dari file components.json\n'
          '(misalnya: Mikrokontroler, Network, Actuator, dsb).',
          style: TextStyle(
            fontSize: 12,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 16),

        // Grid kategori
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: _categories.map((cat) {
            final bool isAll = cat == 'All';
            return GestureDetector(
              onTap: () => _openCategory(cat),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    colors: isAll
                        ? const [
                            Color(0xFF0B0C3A),
                            Color(0xFF1C2C80),
                          ]
                        : const [
                            Color(0xFFFDFDFE),
                            Color(0xFFE9EBFF),
                          ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x22000000),
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                  border: Border.all(
                    color: isAll ? Colors.white70 : Colors.grey.shade300,
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isAll ? Icons.apps_rounded : Icons.memory_rounded,
                      size: 16,
                      color: isAll ? Colors.white : navy,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      isAll ? 'Semua Komponen' : cat,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: isAll ? Colors.white : navy,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
