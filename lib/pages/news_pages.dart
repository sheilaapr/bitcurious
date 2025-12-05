import 'package:flutter/material.dart';
import 'package:bitcurious/services/news_services.dart';

class NewsPage extends StatefulWidget {
  final String? initialQuery;

  const NewsPage({
    super.key,
    this.initialQuery,
  });

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final NewsService _service = NewsService();
  late final TextEditingController _searchController;

  bool _loading = false;
  String? _error;
  List<NewsArticle> _articles = [];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(
      text: widget.initialQuery ?? '',
    );
    _loadNews(keyword: widget.initialQuery);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  /// Guard setState supaya kalau Future selesai setelah halaman di-back,
  /// dia tidak akan mencoba update state lagi (menghindari kilat merah).
  @override
  void setState(VoidCallback fn) {
    if (!mounted) return;
    super.setState(fn);
  }

  Future<void> _loadNews({String? keyword}) async {
    setState(() {
      _loading = true;
      _error = null;
      _articles = [];
    });

    try {
      final result = await _service.fetchTechNews(keyword: keyword);
      setState(() {
        _articles = result;
      });
    } catch (e) {
      setState(() {
        _error = 'Gagal memuat berita: $e';
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  void _onSearchSubmitted(String value) {
    final q = value.trim();
    _loadNews(keyword: q.isEmpty ? null : q);
  }

  void _showNewsDetail(NewsArticle article) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          article.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (article.imageUrl != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    article.imageUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        const SizedBox.shrink(),
                  ),
                ),
              const SizedBox(height: 10),
              Text(
                article.description.isEmpty
                    ? 'Tidak ada ringkasan tersedia.'
                    : article.description,
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 12),
              Text(
                'Sumber: ${article.sourceName}',
                style: const TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.black54,
                ),
              ),
              if (article.publishedAt != null) ...[
                const SizedBox(height: 4),
                Text(
                  'Dipublikasikan: '
                  '${article.publishedAt!.day.toString().padLeft(2, '0')}-'
                  '${article.publishedAt!.month.toString().padLeft(2, '0')}-'
                  '${article.publishedAt!.year}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black45,
                  ),
                ),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color navy = Color(0xFF0B0C3A);
    const Color white = Colors.white;

    return Scaffold(
      backgroundColor: navy,
      appBar: AppBar(
        backgroundColor: navy,
        elevation: 0,
        foregroundColor: white,
        title: const Text(
          'Berita Teknologi & IoT',
          style: TextStyle(
            color: white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          // Search bar di atas
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: Colors.white.withOpacity(0.10),
                border: Border.all(color: Colors.white24, width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.22),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.search_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                      decoration: const InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                        hintText:
                            'Cari berita (mis: IoT, elektronik, AI)...',
                        hintStyle: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                      textInputAction: TextInputAction.search,
                      onSubmitted: _onSearchSubmitted,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_forward_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                    onPressed: () =>
                        _onSearchSubmitted(_searchController.text),
                  ),
                ],
              ),
            ),
          ),

          // Body putih
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 12,
                    offset: Offset(0, -4),
                  ),
                ],
              ),
              child: _buildBody(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    const Color navy = Color(0xFF0B0C3A);

    if (_loading && _articles.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(
            _error!,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.redAccent),
          ),
        ),
      );
    }

    if (_articles.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Text(
            'Belum ada berita.\nCoba ubah kata kunci pencarian.',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      itemCount: _articles.length,
      itemBuilder: (context, index) {
        final a = _articles[index];
        return GestureDetector(
          onTap: () => _showNewsDetail(a),
          child: Container(
            margin: const EdgeInsets.only(bottom: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: const LinearGradient(
                colors: [
                  Color(0xFFFDFDFE),
                  Color(0xFFE9EBFF),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x22000000),
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                // Gambar kecil
                if (a.imageUrl != null)
                  Container(
                    height: 80,
                    width: 80,
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey[300],
                      image: DecorationImage(
                        image: NetworkImage(a.imageUrl!),
                        fit: BoxFit.cover,
                        onError: (_, __) {},
                      ),
                    ),
                  )
                else
                  Container(
                    height: 80,
                    width: 80,
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey[200],
                    ),
                    child: const Icon(Icons.newspaper_rounded),
                  ),

                // Teks
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          a.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: navy,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          a.sourceName,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                        ),
                        if (a.publishedAt != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 2.0),
                            child: Text(
                              '${a.publishedAt!.day.toString().padLeft(2, '0')}-'
                              '${a.publishedAt!.month.toString().padLeft(2, '0')}-'
                              '${a.publishedAt!.year}',
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.black45,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
          ),
        );
      },
    );
  }
}
