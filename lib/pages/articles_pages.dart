import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:bitcurious/services/bitcurious_api_service.dart';

class ArticlesPage extends StatefulWidget {
  const ArticlesPage({super.key});

  @override
  State<ArticlesPage> createState() => _ArticlesPageState();
}

class _ArticlesPageState extends State<ArticlesPage> {
  List<dynamic> articles = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadArticles();
  }

  @override
  void setState(VoidCallback fn) {
    if (!mounted) return;
    super.setState(fn);
  }

  Future<void> _loadArticles() async {
    try {
      final decoded = await BitcuriousApiService.fetchArticles();
      setState(() {
        articles = decoded;
        _error = null;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Gagal memuat artikel dari API: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _openUrl(String url) async {
    if (url.isEmpty) return;
    final uri = Uri.tryParse(url);
    if (uri == null) return;
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
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
            style: const TextStyle(color: Colors.redAccent),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    if (articles.isEmpty) {
      return const Center(
        child: Text(
          'Belum ada artikel.',
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
                  Icon(Icons.menu_book_rounded, color: Colors.white),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Artikel IoT & Elektronika',
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

            // Body
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
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    final item = articles[index] as Map<String, dynamic>;
                    return _buildArticleCard(item, navy);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildArticleCard(Map<String, dynamic> item, Color navy) {
    final title = (item['title'] ?? 'Tanpa judul').toString();
    final url = (item['source'] ?? '').toString(); // source berisi URL
    final desc = (item['desc'] ?? '').toString();

    // tampilkan host / domain sebagai sumber
    String sourceLabel = url;
    final uri = Uri.tryParse(url);
    if (uri != null && uri.host.isNotEmpty) {
      sourceLabel = uri.host;
    }

    return GestureDetector(
      onTap: () => _openUrl(url),
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(14),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sumber
            if (sourceLabel.isNotEmpty)
              Text(
                sourceLabel,
                style: TextStyle(
                  color: navy,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            if (sourceLabel.isNotEmpty) const SizedBox(height: 6),

            // Judul
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),

            // Deskripsi
            if (desc.isNotEmpty)
              Text(
                desc,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black87,
                ),
              ),

            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  url.isEmpty ? 'Tidak ada link' : 'Buka artikel',
                  style: TextStyle(
                    color: url.isEmpty ? Colors.grey : navy,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: 4),
                if (url.isNotEmpty)
                  Icon(Icons.open_in_new_rounded,
                      size: 16, color: navy),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
