import 'dart:convert';
import 'package:flutter/material.dart';

class ArticlesPage extends StatefulWidget {
  const ArticlesPage({super.key});

  @override
  State<ArticlesPage> createState() => _ArticlesPageState();
}

class _ArticlesPageState extends State<ArticlesPage> {
  List<dynamic> articles = [];

  Future<void> _loadArticles() async {
    final data = await DefaultAssetBundle.of(context)
        .loadString('assets/data/articles.json');
    setState(() {
      articles = json.decode(data);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadArticles();
  }

  void _showArticleDetails(BuildContext context, Map<String, dynamic> article) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Text(
          article['title'],
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF0B0C3A),
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                article['desc'],
                style: const TextStyle(fontSize: 14, color: Colors.black87),
              ),
              const SizedBox(height: 10),
              const Text(
                "Sumber:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(
                article['source'],
                style: const TextStyle(
                    color: Colors.blueAccent,
                    fontStyle: FontStyle.italic,
                    fontSize: 13),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: const Text(
              "Tutup",
              style: TextStyle(color: Color(0xFF0B0C3A)),
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Artikel & Edukasi'),
        backgroundColor: const Color(0xFF0B0C3A),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: articles.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final a = articles[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    leading: const Icon(Icons.article,
                        color: Colors.blueAccent, size: 28),
                    title: Text(
                      a['title'],
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    subtitle: Text(
                      a['source'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.black54),
                    ),
                    trailing: TextButton(
                      onPressed: () => _showArticleDetails(context, a),
                      child: const Text(
                        "Read More",
                        style: TextStyle(color: Color(0xFF0B0C3A)),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
