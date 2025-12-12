import 'package:flutter/material.dart';
import 'package:bitcurious/services/pinned_repository.dart';

class ComponentDetailPage extends StatefulWidget {
  final Map<String, dynamic> component;

  const ComponentDetailPage({
    super.key,
    required this.component,
  });

  @override
  State<ComponentDetailPage> createState() => _ComponentDetailPageState();
}

class _ComponentDetailPageState extends State<ComponentDetailPage> {
  bool _isDescExpanded = false;
  bool _isPinned = false;

  @override
  void initState() {
    super.initState();
    _checkPinned();
  }
  
  @override
  void setState(VoidCallback fn) {
    if (!mounted) return;
    super.setState(fn);
  }

  void _checkPinned() {
    final name = widget.component['name']?.toString() ?? '';
    final category = widget.component['category']?.toString() ?? '';

    _isPinned = PinnedRepository.items.any(
      (c) => c.name == name && c.categoryName == category,
    );
  }

  void _togglePinned() {
    final name = widget.component['name']?.toString() ?? '';
    final desc = widget.component['desc']?.toString() ?? '';
    final imageUrl = widget.component['image']?.toString() ?? '';
    final category = widget.component['category']?.toString() ?? '';
    final double price = (widget.component['price'] is num)
        ? (widget.component['price'] as num).toDouble()
        : 0.0;

    if (!_isPinned) {
      // Tambah ke pinned
      final pinned = PinnedComponent(
        name: name,
        description: desc,
        imageUrl: imageUrl,
        price: price,
        categoryName: category,
      );
      PinnedRepository.add(pinned);

      setState(() {
        _isPinned = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Berhasil menambahkan "$name" ke Pinned'),
        ),
      );
    } else {
      // Lepas dari pinned (opsional, bisa dijadikan unpin)
      PinnedRepository.remove(name, category);
      setState(() {
        _isPinned = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Berhasil menghapus "$name" dari Pinned'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color navy = Color(0xFF0B0C3A);
    const Color darkBg = Color(0xFF020315);

    final String name = widget.component['name'] ?? 'Tanpa nama';
    final String desc = widget.component['desc'] ?? '';
    final String imageUrl = widget.component['image'] ?? '';
    final double? price = (widget.component['price'] is num)
        ? (widget.component['price'] as num).toDouble()
        : null;

    final String category = widget.component['category'] ?? '';
    final List<String> tags = (widget.component['tags'] is List)
        ? (widget.component['tags'] as List)
            .map((e) => e.toString())
            .toList()
        : <String>[];

    return Scaffold(
      backgroundColor: darkBg,
      appBar: AppBar(
        backgroundColor: navy,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(
          name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: Column(
        children: [
          // Bagian atas: gambar + info singkat
          Container(
            width: double.infinity,
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
            padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            child: Row(
              children: [
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: imageUrl.isNotEmpty
                        ? Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                                const Icon(Icons.memory_rounded,
                                    color: Colors.white),
                          )
                        : const Icon(
                            Icons.memory_rounded,
                            color: Colors.white,
                            size: 36,
                          ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (category.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            category,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      if (price != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          'Rp ${price.toStringAsFixed(0)}',
                          style: const TextStyle(
                            color: Color(0xFF00E0FF),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Body putih + read more + tombol pinned
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
                padding:
                    const EdgeInsets.fromLTRB(20, 20, 20, 24),
                children: [
                  
                  if (tags.isNotEmpty)
                    Wrap(
                      spacing: 8,
                      runSpacing: -4,
                      children: tags.map((t) {
                        return Chip(
                          label: Text(
                            t,
                            style: const TextStyle(fontSize: 11),
                          ),
                          backgroundColor: const Color(0xFFE3E7FF),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          visualDensity: VisualDensity.compact,
                        );
                      }).toList(),
                    ),

                  if (tags.isNotEmpty) const SizedBox(height: 16),

                  // Judul Deskripsi
                  const Text(
                    'Deskripsi',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0B0C3A),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // TEKS DESKRIPSI + READ MORE
                  _buildDescription(desc),

                  const SizedBox(height: 20),

                  // Tombol ADD TO PINNED
                  _buildPinnedButton(),

                  const SizedBox(height: 20),

                  // Field tambahan (kalau ada di map)
                  ..._buildExtraFields(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription(String desc) {
    final bool showReadMore = desc.length > 140; 

    final String textToShow;
    if (!_isDescExpanded && showReadMore) {
      textToShow = desc.substring(0, 140) + '...';
    } else {
      textToShow = desc;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          desc.isEmpty
              ? 'Belum ada deskripsi untuk komponen ini.'
              : textToShow,
          textAlign: TextAlign.justify,
          style: const TextStyle(
            fontSize: 13,
            height: 1.6,
            color: Colors.black87,
          ),
        ),
        if (showReadMore)
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                setState(() {
                  _isDescExpanded = !_isDescExpanded;
                });
              },
              child: Text(
                _isDescExpanded ? 'Read less' : 'Read more',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildPinnedButton() {
    const Color navy = Color(0xFF0B0C3A);

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: _togglePinned,
        style: ElevatedButton.styleFrom(
          backgroundColor: _isPinned ? Colors.grey[400] : navy,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          elevation: 4,
        ),
        icon: Icon(
          _isPinned ? Icons.push_pin : Icons.push_pin_outlined,
        ),
        label: Text(
          _isPinned ? 'Pinned' : 'Add to Pinned',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  List<Widget> _buildExtraFields() {
    const ignoreKeys = {
      'name',
      'desc',
      'image',
      'price',
      'category',
      'tags',
    };

    final entries = widget.component.entries
        .where((e) => !ignoreKeys.contains(e.key))
        .toList();

    if (entries.isEmpty) return [];

    List<Widget> widgets = [];

    for (final e in entries) {
      final key = e.key;
      final value = e.value;
      String textValue;

      if (value is List) {
        textValue = value.map((v) => v.toString()).join(', ');
      } else {
        textValue = value.toString();
      }

      if (textValue.trim().isEmpty) continue;

      widgets.add(const SizedBox(height: 8));
      widgets.add(
        Text(
          key,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF0B0C3A),
          ),
        ),
      );
      widgets.add(const SizedBox(height: 4));
      widgets.add(
        Text(
          textValue,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.black87,
          ),
        ),
      );
      widgets.add(const SizedBox(height: 12));
    }

    return widgets;
  }
}
