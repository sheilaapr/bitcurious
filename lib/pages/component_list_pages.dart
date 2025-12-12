import 'package:flutter/material.dart';
import 'package:bitcurious/pages/component_detail_pages.dart';
import 'package:bitcurious/services/bitcurious_api_service.dart';

class ComponentListPage extends StatefulWidget {
  final String categoryName; // "All" atau nama kategori

  const ComponentListPage({
    super.key,
    required this.categoryName,
  });

  @override
  State<ComponentListPage> createState() => _ComponentListPageState();
}

class _ComponentListPageState extends State<ComponentListPage> {
  List<Map<String, dynamic>> components = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadComponents();
  }
  
    @override
  void setState(VoidCallback fn) {
    if (!mounted) return;
    super.setState(fn);
  }

  Future<void> _loadComponents() async {
    try {
      final Map<String, dynamic> data =
          await BitcuriousApiService.fetchComponentsMap();

      List<Map<String, dynamic>> loaded = [];

      if (widget.categoryName == 'All') {
        // menggabungkan semua kategori
        data.forEach((key, value) {
          if (value is List) {
            loaded.addAll(value.cast<Map<String, dynamic>>());
          }
        });
      } else {
                final target = widget.categoryName.toLowerCase().trim();

        List<dynamic>? found;
               data.forEach((key, value) {
          final keyStr = key.toString().toLowerCase().trim();
          if (keyStr == target && value is List) {
            found = value;
          }
        });

        if (found != null) {
          loaded = found!.cast<Map<String, dynamic>>();
        } else {
          _errorMessage =
              'Kategori "${widget.categoryName}" tidak ditemukan di data API.';
        }
      }

      setState(() {
        components = loaded;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Gagal memuat komponen dari API: $e';
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal memuat komponen: $e')),
        );
      }
    }
  }

  String _shortDesc(String desc) {
    final sentences = desc.split('.');
    if (sentences.isNotEmpty && sentences.first.trim().isNotEmpty) {
      return '${sentences.first.trim()}.';
    }
    return desc;
  }

  @override
  Widget build(BuildContext context) {
    const Color navy = Color(0xFF0B0C3A);
    const Color white = Colors.white;
    const Color grey = Color(0xFFF2F2F2);

    final title = widget.categoryName == 'All'
        ? 'Semua Komponen'
        : widget.categoryName;

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: navy,
        foregroundColor: white,
        elevation: 0,
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: _buildBody(navy, grey),
    );
  }

  Widget _buildBody(Color navy, Color grey) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            _errorMessage!,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.redAccent),
          ),
        ),
      );
    }

    if (components.isEmpty) {
      return const Center(
        child: Text(
          'Tidak ada komponen pada kategori ini.',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return Container(
      color: grey,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: components.length,
        itemBuilder: (context, index) {
          final item = components[index];
          return _buildComponentCard(item, navy);
        },
      ),
    );
  }

  Widget _buildComponentCard(Map<String, dynamic> item, Color navy) {
    final String name = item['name'] ?? 'Tanpa nama';
    final String desc = item['desc'] ?? '';
    final double? price =
        (item['price'] is num) ? (item['price'] as num).toDouble() : null;
    final String imageUrl = item['image'] ?? '';

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ComponentDetailPage(component: item),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            // Gambar komponen dari URL
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(16),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: imageUrl.isNotEmpty
                    ? Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            const Icon(Icons.memory_rounded),
                      )
                    : const Icon(Icons.memory_rounded),
              ),
            ),
            const SizedBox(width: 12),

            // Info komponen
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 4),
                    if (desc.isNotEmpty)
                      Text(
                        _shortDesc(desc),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 12,
                        ),
                      ),
                    if (price != null) ...[
                      const SizedBox(height: 6),
                      Text(
                        'Rp ${price.toStringAsFixed(0)}',
                        style: const TextStyle(
                          color: Color(0xFF0B0C3A),
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(width: 6),
            Icon(Icons.chevron_right_rounded, color: navy),
          ],
        ),
      ),
    );
  }
}
