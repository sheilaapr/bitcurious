// lib/models/article_model.dart

class ArticleModel {
  final String title;
  final String desc;
  final String source; // url artikel
  final String image;  // thumbnail (boleh kosong)

  ArticleModel({
    required this.title,
    required this.desc,
    required this.source,
    required this.image,
  });

  /// JSON -> ArticleModel
  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      title: (json['title'] ?? '').toString(),
      desc: (json['desc'] ?? '').toString(),
      source: (json['source'] ?? '').toString(),
      image: (json['image'] ?? '').toString(),
    );
  }

  /// ArticleModel -> Map
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'desc': desc,
      'source': source,
      'image': image,
    };
  }
}
