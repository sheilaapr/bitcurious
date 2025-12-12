class ProjectModel {
  final String title;
  final String desc;
  final String dalil;
  final List<String> tools;

  ProjectModel({
    required this.title,
    required this.desc,
    required this.dalil,
    required this.tools,
  });

  /// JSON -> ProjectModel
  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    final rawTools = (json['tools'] is List)
        ? json['tools'] as List
        : <dynamic>[];

    return ProjectModel(
      title: (json['title'] ?? '').toString(),
      desc: (json['desc'] ?? '').toString(),
      dalil: (json['dalil'] ?? '').toString(),
      tools: rawTools.map((e) => e.toString()).toList(),
    );
  }

  /// ProjectModel -> Map
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'desc': desc,
      'dalil': dalil,
      'tools': tools,
    };
  }
}
