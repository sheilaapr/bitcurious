import 'dart:convert';
import 'package:flutter/material.dart';

class ProjectReferencesPage extends StatefulWidget {
  const ProjectReferencesPage({super.key});

  @override
  State<ProjectReferencesPage> createState() => _ProjectReferencesPageState();
}

class _ProjectReferencesPageState extends State<ProjectReferencesPage> {
  List<dynamic> projects = [];
  List<bool> expandedStates = [];

  Future<void> _loadProjects() async {
    final data = await DefaultAssetBundle.of(context)
        .loadString('assets/data/projects.json');
    final jsonResult = json.decode(data);
    setState(() {
      projects = jsonResult;
      expandedStates = List<bool>.filled(projects.length, false);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadProjects();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Referensi Proyek Islami'),
        backgroundColor: const Color(0xFF0B0C3A),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: projects.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: projects.length,
              itemBuilder: (context, index) {
                final p = projects[index];
                final expanded = expandedStates[index];

                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.lightbulb,
                                color: Colors.amber, size: 28),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                p['title'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          p['desc'],
                          maxLines: expanded ? null : 2,
                          overflow: expanded
                              ? TextOverflow.visible
                              : TextOverflow.ellipsis,
                        ),
                        if (expanded) ...[
                          const SizedBox(height: 10),
                          Text(
                            "Dalil: ${p['dalil']}",
                            style: const TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "Alat dan Bahan:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0B0C3A),
                            ),
                          ),
                          const SizedBox(height: 4),
                          ...List<Widget>.from(
                            (p['alat_bahan'] as List).map(
                              (item) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 2),
                                child: Row(
                                  children: [
                                    const Icon(Icons.circle,
                                        size: 8, color: Colors.black54),
                                    const SizedBox(width: 8),
                                    Expanded(child: Text(item)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],

                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
