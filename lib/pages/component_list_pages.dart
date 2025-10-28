import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:bitcurious/pages/component_detail_pages.dart';

class ComponentListPage extends StatefulWidget {
  final String categoryName;

  const ComponentListPage({super.key, required this.categoryName});

  @override
  State<ComponentListPage> createState() => _ComponentListPageState();
}

class _ComponentListPageState extends State<ComponentListPage> {
  List<dynamic> components = [];

  @override
  void initState() {
    super.initState();
    loadComponents();
  }

  Future<void> loadComponents() async {
    final String response = await rootBundle.loadString(
      'assets/data/components.json',
    );
    final data = json.decode(response);

    setState(() {
      components = data[widget.categoryName] ?? [];
    });
  }

  /// Fungsi untuk ambil satu kalimat pertama dari deskripsi
  String getShortDesc(String desc) {
    // Pisahkan berdasarkan titik
    List<String> sentences = desc.split('.');
    if (sentences.isNotEmpty) {
      return sentences.first.trim() + '.';
    } else {
      return desc;
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color navy = Color(0xFF0B0C3A);
    const Color white = Colors.white;
    const Color grey = Color(0xFFF2F2F2);

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: navy,
        foregroundColor: white,
        elevation: 0,
        title: Text(
          widget.categoryName,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: components.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: components.length,
              itemBuilder: (context, index) {
                final item = components[index];
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
                          categoryName: widget.categoryName,
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
                                    color: navy,
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
                        const Icon(Icons.chevron_right_rounded, color: navy),
                        const SizedBox(width: 12),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
