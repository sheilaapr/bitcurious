class ComponentModel {
  final String name;
  final String desc;
  final String image;
  final double? price;
  final String category; // nama kategori, misal "sensor"

  ComponentModel({
    required this.name,
    required this.desc,
    required this.image,
    required this.category,
    this.price,
  });

  /// JSON -> ComponentModel
  factory ComponentModel.fromJson(String category, Map<String, dynamic> json) {
    return ComponentModel(
      name: (json['name'] ?? '').toString(),
      desc: (json['desc'] ?? '').toString(),
      image: (json['image'] ?? '').toString(),
      price: (json['price'] is num)
          ? (json['price'] as num).toDouble()
          : null,
      category: category,
    );
  }

  /// ComponentModel -> Map (kalau suatu saat perlu kirim/serialize lagi)
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'desc': desc,
      'image': image,
      'price': price,
      'category': category,
    };
  }
}
