import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:bitcurious/pages/project_detail_page.dart';

class ProjectReferencesPage extends StatefulWidget {
  const ProjectReferencesPage({super.key});

  @override
  State<ProjectReferencesPage> createState() => _ProjectReferencesPageState();
}

class _ProjectReferencesPageState extends State<ProjectReferencesPage> {
  List<dynamic> projects = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadProjects();
  }

  /// Guard setState supaya tidak dipanggil setelah halaman di-pop (dispose)
  @override
  void setState(VoidCallback fn) {
    if (!mounted) return;
    super.setState(fn);
  }

  Future<void> _loadProjects() async {
    try {
      final jsonStr =
          await rootBundle.loadString('assets/data/projects.json');
      final decoded = json.decode(jsonStr);

      if (decoded is List) {
        setState(() {
          projects = decoded;
          _isLoading = false;
          _error = null;
        });
      } else {
        setState(() {
          _isLoading = false;
          _error = 'Format projects.json tidak sesuai (harus List).';
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = 'Gagal memuat project: $e';
      });
    }
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
          'Project Islami',
          style: TextStyle(
            color: white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
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
    );
  }

  Widget _buildBody() {
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

    if (projects.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Belum ada data project.\nCek kembali projects.json.',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: projects.length,
      itemBuilder: (context, index) {
        final proj = projects[index] as Map<String, dynamic>;
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: const Color(0xFFF5F5FF),
            boxShadow: const [
              BoxShadow(
                color: Color(0x22000000),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProjectDetailPage(project: proj),
                ),
              );
            },
            leading: const Icon(
              Icons.bolt_rounded,
              color: Color(0xFF0B0C3A),
            ),
            title: Text(
              proj['title'] ?? 'Tanpa Judul',
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 15,
              ),
            ),
            subtitle: Text(
              proj['short_desc'] ?? '',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );
      },
    );
  }
}
