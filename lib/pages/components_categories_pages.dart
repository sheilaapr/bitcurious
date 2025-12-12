import 'package:flutter/material.dart';
import 'package:bitcurious/pages/component_list_pages.dart';
import 'package:bitcurious/services/bitcurious_api_service.dart';

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
      final Map<String, dynamic> data =
          await BitcuriousApiService.fetchComponentsMap();

      final keys = data.keys
          .whereType<String>()
          .where((k) => k.trim().isNotEmpty)
          .toList()
        ..sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));

      setState(() {
        _categories = ['All', ...keys]; // kita tambahkan kategori "All"
        _isLoading = false;
        _error = null;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = 'Gagal memuat kategori dari API: $e';
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
          'Tidak ada kategori komponen.',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF0B0C3A),
            Color(0xFF000814),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Header
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
              child: Row(
                children: const [
                  Icon(Icons.memory_rounded, color: Colors.white),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Kategori Komponen',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Body putih dengan card kategori
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFFF9FAFF),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(26),
                    topRight: Radius.circular(26),
                  ),
                ),
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                  children: [
                    const Text(
                      'Pilih kategori komponen untuk mulai mengeksplorasi dunia elektronika dan IoT.',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildCategoryGrid(navy),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryGrid(Color navy) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: _categories.map((category) {
        final bool isAll = category == 'All';

        return GestureDetector(
          onTap: () => _openCategory(category),
          child: Container(
            width: 170,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
              boxShadow: [
                BoxShadow(
                  color: isAll
                      ? Colors.black26
                      : Colors.grey.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor:
                      isAll ? Colors.white.withOpacity(0.15) : navy,
                  child: Icon(
                    isAll ? Icons.apps_rounded : Icons.category_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    category,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: isAll ? Colors.white : navy,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
