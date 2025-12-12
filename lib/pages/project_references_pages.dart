import 'package:flutter/material.dart';
import 'package:bitcurious/services/bitcurious_api_service.dart';
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

  @override
  void setState(VoidCallback fn) {
    if (!mounted) return;
    super.setState(fn);
  }

  Future<void> _loadProjects() async {
    try {
      final decoded = await BitcuriousApiService.fetchProjects();
      setState(() {
        projects = decoded;
        _isLoading = false;
        _error = null;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = 'Gagal memuat project dari API: $e';
      });
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

    if (projects.isEmpty) {
      return const Center(
        child: Text(
          'Belum ada referensi project.',
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14),
              child: Row(
                children: const [
                  Icon(Icons.bolt_rounded, color: Colors.white),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Project IoT Bernuansa Islami',
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
                  itemCount: projects.length,
                  itemBuilder: (context, index) {
                    final item = projects[index] as Map<String, dynamic>;
                    return _buildProjectCard(item, navy);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectCard(Map<String, dynamic> item, Color navy) {
    final title = (item['title'] ?? 'Tanpa judul').toString();
    final desc = (item['desc'] ?? '').toString();
    final dalil = (item['dalil'] ?? '').toString();
    final List<String> tools = (item['tools'] is List)
        ? (item['tools'] as List).map((e) => e.toString()).toList()
        : <String>[];

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
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
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
            // Title
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),

            // Desc
            if (desc.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 6.0),
                child: Text(
                  desc,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black87,
                    height: 1.5,
                  ),
                ),
              ),

            // Dalil
            if (dalil.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 6.0),
                child: Text(
                  dalil,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.black87,
                    fontStyle: FontStyle.italic,
                    height: 1.4,
                  ),
                ),
              ),

            // Tools
            if (tools.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Wrap(
                  spacing: 6,
                  runSpacing: -4,
                  children: tools.take(4).map((t) {
                    return Chip(
                      label: Text(
                        t,
                        style: const TextStyle(fontSize: 10),
                      ),
                      backgroundColor: const Color(0xFFE3E7FF),
                      materialTapTargetSize:
                          MaterialTapTargetSize.shrinkWrap,
                      visualDensity: VisualDensity.compact,
                    );
                  }).toList(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
