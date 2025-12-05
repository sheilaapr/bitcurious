import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:bitcurious/pages/component_detail_pages.dart';

class ComponentListPage extends StatefulWidget {
  /// Kalau "All"  => gabungkan semua kategori.
  /// Kalau nama lain (mis. "Controller & Processing Units")
  /// => hanya kategori itu saja.
  final String categoryName;

  const ComponentListPage({
    super.key,
    required this.categoryName,
  });

  @override
  State<ComponentListPage> createState() => _ComponentListPageState();
}

class _ComponentListPageState extends State<ComponentListPage> {
  List<dynamic> components = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    loadComponents();
  }

  // Guard setState supaya aman kalau halaman sudah di-pop
  @override
  void setState(VoidCallback fn) {
    if (!mounted) return;
    super.setState(fn);
  }

  Future<void> loadComponents() async {
    try {
      final String response =
          await rootBundle.loadString('assets/data/components.json');
      final data = json.decode(response);

      if (data is! Map<String, dynamic>) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Format components.json tidak sesuai (bukan Map).';
        });
        return;
      }

      List<dynamic> loaded = [];

      if (widget.categoryName == 'All') {
        // ====== MODE ALL: gabungkan semua list komponen ======
        data.forEach((key, value) {
          if (value is List) {
            loaded.addAll(value);
          }
        });
      } else {
        // ====== MODE KATEGORI TUNGGAL ======
        final target = widget.categoryName.toLowerCase().trim();

        List<dynamic>? found;

        // Cari key yang cocok dengan nama kategori (lebih toleran)
        data.forEach((key, value) {
          final keyStr = key.toString().toLowerCase().trim();
          if (keyStr == target && value is List) {
            found = value;
          }
        });

        if (found != null) {
          loaded = found!;
        } else {
          _errorMessage =
              'Kategori "${widget.categoryName}" tidak ditemukan di components.json.';
        }
      }

      setState(() {
        components = loaded;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Gagal memuat komponen: $e';
      });

      // opsional: tampilkan snackbar kalau halaman masih aktif
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal memuat komponen: $e')),
        );
      }
    }
  }

  /// Ambil satu kalimat pertama dari deskripsi
  String getShortDesc(String desc) {
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
        foregroundColor: white, // judul & ikon putih
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
          'Tidak ada komponen ditemukan.',
          style: TextStyle(fontSize: 14),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: components.length,
      itemBuilder: (context, index) {
        final item = components[index] as Map<String, dynamic>;
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ComponentDetailPage(
                  name: item['name'],
                  description: item['desc'],
                  imageUrl: item['image'],
                  price: (item['price'] as num).toDouble(),
                  categoryName: widget.categoryName == 'All'
                      ? 'Komponen'
                      : widget.categoryName,
                ),
              ),
            );
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: grey,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 5,
                  offset: const Offset(2, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                // Gambar
                Container(
                  height: 80,
                  width: 80,
                  margin: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: AssetImage(item['image']),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // Info komponen
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 12,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['name'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF0B0C3A),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          getShortDesc(item['desc']),
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.black87,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "Rp ${item['price']}",
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.green,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Icon(Icons.chevron_right_rounded, color: navy),
                const SizedBox(width: 12),
              ],
            ),
          ),
        );
      },
    );
  }
}
