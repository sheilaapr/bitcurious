// lib/services/pinned_repository.dart

class PinnedComponent {
  final String name;
  final String description;
  final String imageUrl;
  final double price;
  final String categoryName;

  PinnedComponent({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.categoryName,
  });
}

class PinnedRepository {
  static final List<PinnedComponent> _items = [];

  static List<PinnedComponent> get items => List.unmodifiable(_items);

  static bool isPinned(String name, String categoryName) {
    return _items.any(
      (c) => c.name == name && c.categoryName == categoryName,
    );
  }

  static void add(PinnedComponent component) {
    if (!isPinned(component.name, component.categoryName)) {
      _items.add(component);
    }
  }

  static void remove(String name, String categoryName) {
    _items.removeWhere(
      (c) => c.name == name && c.categoryName == categoryName,
    );
  }

  static void toggle(PinnedComponent component) {
    if (isPinned(component.name, component.categoryName)) {
      remove(component.name, component.categoryName);
    } else {
      add(component);
    }
  }
}
