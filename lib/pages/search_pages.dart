import 'package:flutter/material.dart';
import 'package:bitcurious/services/bitcurious_api_service.dart';
import 'package:bitcurious/pages/component_detail_pages.dart';
import 'package:bitcurious/pages/project_detail_page.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchPage extends StatefulWidget {
  final String initialQuery;

  const SearchPage({
    super.key,
    required this.initialQuery,
  });

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController _controller;
  bool _isLoading = true;
  String? _error;
  List<Map<String, dynamic>> _componentResults = [];
  List<Map<String, dynamic>> _projectResults = [];
  List<Map<String, dynamic>> _articleResults = [];

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialQuery);
    _performSearch(widget.initialQuery);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _performSearch(String query) async {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) {
      setState(() {
        _componentResults = [];
        _projectResults = [];
        _articleResults = [];
        _isLoading = false;
        _error = null;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      // Ambil semua data dari API
      final componentsMap = await BitcuriousApiService.fetchComponentsMap();
      final projects = await BitcuriousApiService.fetchProjects();
      final articles = await BitcuriousApiService.fetchArticles();

      // Flatten components (tiap item diberi category-nya)
      final List<Map<String, dynamic>> allComponents = [];
      componentsMap.forEach((key, value) {
        if (value is List) {
          for (final raw in value) {
            final item = Map<String, dynamic>.from(raw as Map<String, dynamic>);
            item['category'] = key.toString();
            allComponents.add(item);
          }
        }
      });

      final comps = allComponents.where((c) {
        final name = (c['name'] ?? '').toString().toLowerCase();
        final desc = (c['desc'] ?? '').toString().toLowerCase();
        return name.contains(q) || desc.contains(q);
      }).toList();

      final projs = projects
          .where((p) {
            final map = p as Map<String, dynamic>;
            final title = (map['title'] ?? '').toString().toLowerCase();
            final desc = (map['desc'] ?? '').toString().toLowerCase();
            return title.contains(q) || desc.contains(q);
          })
          .map((e) => Map<String, dynamic>.from(e))
          .toList();

      final arts = articles
          .where((a) {
            final map = a as Map<String, dynamic>;
            final title = (map['title'] ?? '').toString().toLowerCase();
            final desc = (map['desc'] ?? '').toString().toLowerCase();
            return title.contains(q) || desc.contains(q);
          })
          .map((e) => Map<String, dynamic>.from(e))
          .toList();

      setState(() {
        _componentResults = comps;
        _projectResults = projs;
        _articleResults = arts;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = 'Gagal melakukan pencarian: $e';
      });
    }
  }

  Future<void> _openArticleUrl(String url) async {
    if (url.isEmpty) return;

    final uri = Uri.tryParse(url);
    if (uri == null) return;

    // Minimal validasi skema (biar gak error kalau string bukan url)
    if (uri.scheme != 'http' && uri.scheme != 'https') return;

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color navy = Color(0xFF0B0C3A);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: navy,
        foregroundColor: Colors.white,
        title: TextField(
          controller: _controller,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Cari komponen / artikel / project...',
            hintStyle: TextStyle(color: Colors.white54),
          ),
          textInputAction: TextInputAction.search,
          onSubmitted: (value) => _performSearch(value),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => _performSearch(_controller.text),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      _error!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.redAccent),
                    ),
                  ),
                )
              : _buildResultsBody(),
    );
  }

  Widget _buildResultsBody() {
    if (_componentResults.isEmpty &&
        _projectResults.isEmpty &&
        _articleResults.isEmpty) {
      return const Center(
        child: Text(
          'Tidak ditemukan hasil untuk kata kunci tersebut.',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      children: [
        if (_componentResults.isNotEmpty) ...[
          const Text(
            'Komponen',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          ..._componentResults.map(_buildComponentResultCard),
          const SizedBox(height: 16),
        ],
        if (_projectResults.isNotEmpty) ...[
          const Text(
            'Project Islami',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          ..._projectResults.map(_buildProjectResultCard),
          const SizedBox(height: 16),
        ],
        if (_articleResults.isNotEmpty) ...[
          const Text(
            'Artikel',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          ..._articleResults.map(_buildArticleResultCard),
        ],
      ],
    );
  }

  Widget _buildComponentResultCard(Map<String, dynamic> item) {
    final String name = (item['name'] ?? 'Tanpa nama').toString();
    final String desc = (item['desc'] ?? '').toString();
    final String imageUrl = (item['image'] ?? '').toString();
    final double? price =
        (item['price'] is num) ? (item['price'] as num).toDouble() : null;

    final bool isNetwork = imageUrl.startsWith('http://') ||
        imageUrl.startsWith('https://');

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
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(14),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: imageUrl.isNotEmpty
                    ? (isNetwork
                        ? Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                                const Icon(Icons.memory_rounded),
                          )
                        : Image.asset(
                            imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                                const Icon(Icons.memory_rounded),
                          ))
                    : const Icon(Icons.memory_rounded),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                  if (desc.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      desc,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                  if (price != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      'Rp ${price.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF0B0C3A),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectResultCard(Map<String, dynamic> item) {
    final String title = (item['title'] ?? 'Tanpa judul').toString();
    final String desc = (item['desc'] ?? '').toString();

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProjectDetailPage(project: item),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
            if (desc.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                desc,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black87,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildArticleResultCard(Map<String, dynamic> item) {
    final String title = (item['title'] ?? 'Tanpa judul').toString();
    final String desc = (item['desc'] ?? '').toString();
    final String source = (item['source'] ?? '').toString();

    // Prioritas: field 'url' (kalau ada). Kalau JSON kamu nyimpen link di 'source', tetap bisa fallback.
    final String url = (item['url'] ?? item['source'] ?? '').toString();

    return GestureDetector(
      onTap: () => _openArticleUrl(url),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (source.isNotEmpty)
              Text(
                source,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.blueGrey,
                ),
              ),
            const SizedBox(height: 2),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
            if (desc.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                desc,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black87,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
