import 'package:flutter/material.dart';
import 'package:bitcurious/pages/component_list_pages.dart';
import 'package:bitcurious/pages/project_references_pages.dart';
import 'package:bitcurious/pages/articles_pages.dart';
import 'package:bitcurious/pages/saved_pages.dart';

class HomePages extends StatefulWidget {
  const HomePages({super.key});

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    const Color navy = Color(0xFF0B0C3A);
    const Color white = Colors.white;
    const Color yellow = Color(0xFFE8F020);
    const Color grey = Color(0xFFE6E6E6);

    // Daftar kategori utama
    final List<Map<String, dynamic>> categories = [
      {
        'name': 'Controller & Processing Units',
        'color': const Color(0xFFE6E6FA),
      },
      {'name': 'Input & Sensing Devices', 'color': const Color(0xFFE6E6FA)},
      {'name': 'Output & Actuation Devices', 'color': const Color(0xFFE6E6FA)},
      {
        'name': 'Connectivity & Power Modules',
        'color': const Color(0xFFE6E6FA),
      },
    ];

    // Menu sidebar
    final List<Map<String, dynamic>> menuItems = [
      {'icon': Icons.home_rounded, 'text': 'Home'},
      {'icon': Icons.science_rounded, 'text': 'Referensi Proyek Islami'},
      {'icon': Icons.menu_book_rounded, 'text': 'Artikel / Edukasi'},
      {'icon': Icons.bookmark_rounded, 'text': 'Notes Tersimpan'},
      {'icon': Icons.info_outline_rounded, 'text': 'About Us'},
    ];

    return Scaffold(
      backgroundColor: white,

      // === SIDEBAR MENU ===
      drawer: Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
        child: Container(
          decoration: const BoxDecoration(
            color: white,
          ),
          child: Column(
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: navy,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25),
                  ),
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 28,
                      backgroundImage: AssetImage(
                        'assets/images/image_sheila.JPG',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Sheila Apr_',
                          style: TextStyle(
                            color: white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'BitCurious User',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // === MENU ITEM ===
              Expanded(
                child: ListView.builder(
                  itemCount: menuItems.length,
                  itemBuilder: (context, index) {
                    final item = menuItems[index];
                    return _buildDrawerItem(
                      icon: item['icon'],
                      text: item['text'],
                      isActive: selectedIndex == index,
                      onTap: () {
                        setState(() => selectedIndex = index);
                        Navigator.pop(context);

                        // Navigasi sesuai item
                        switch (index) {
                          case 0:
                            break;
                          case 1:
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const ProjectReferencesPage(),
                              ),
                            );
                            break;
                          case 2:
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const ArticlesPage(),
                              ),
                            );
                            break;
                          case 3:
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const SavedPage(),
                              ),
                            );
                            break;
                          case 4:
                            showAboutDialog(
                              context: context,
                              applicationName: 'BitCurious',
                              applicationVersion: '1.0.0',
                              children: const [
                                Text(
                                  'BitCurious adalah aplikasi pembelajaran interaktif '
                                  'yang membantu pengguna memahami komponen elektronik '
                                  'dan konsep Internet of Things (IoT) secara praktis.',
                                ),
                              ],
                            );
                            break;
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),

      // === BODY UTAMA ===
      body: SafeArea(
        child: Column(
          children: [
            // ================= HEADER =================
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: navy,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: navy.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // === Top Bar ===
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Builder(
                        builder: (context) => IconButton(
                          icon: const Icon(Icons.menu, color: white, size: 28),
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                        ),
                      ),
                      const Text(
                        'BitCurious',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: white,
                        ),
                      ),
                      Container(
                        height: 36,
                        width: 36,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('assets/images/image_sheila.JPG'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 26),

                  const Text(
                    'Hello,',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const Text(
                    'Sheila!',
                    style: TextStyle(
                      color: white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // === Indicator dots ===
                  Row(
                    children: [
                      Container(
                        height: 14,
                        width: 14,
                        margin: const EdgeInsets.only(right: 8),
                        decoration: const BoxDecoration(
                          color: grey,
                          shape: BoxShape.circle,
                        ),
                      ),
                      Container(
                        height: 14,
                        width: 14,
                        margin: const EdgeInsets.only(right: 8),
                        decoration: const BoxDecoration(
                          color: grey,
                          shape: BoxShape.circle,
                        ),
                      ),
                      Container(
                        height: 14,
                        width: 70,
                        decoration: BoxDecoration(
                          color: yellow,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 4),
                        child: Container(
                          height: 14,
                          width: 14,
                          decoration: const BoxDecoration(
                            color: white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // === Category label row ===
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  _CategoryChip(label: 'Controllers'),
                  _CategoryChip(label: 'Sensors'),
                  _CategoryChip(label: 'Actuators'),
                  _CategoryChip(label: 'Connectivity'),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ================= GRID KATEGORI =================
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  children: List.generate(categories.length, (index) {
                    final category = categories[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: category['color'],
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 4,
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.memory_rounded,
                            size: 40,
                            color: Colors.black87,
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              category['name'],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 75, 182, 130),
                              foregroundColor: white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ComponentListPage(
                                    categoryName: category['name'],
                                  ),
                                ),
                              );
                            },
                            child: const Text(
                              "See Components",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // === FUNGSI ITEM SIDEBAR ===
  Widget _buildDrawerItem({
    required IconData icon,
    required String text,
    bool isActive = false,
    required VoidCallback onTap,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFFEEF2FF) : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: const Color(0xFF0B0C3A).withOpacity(0.15),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                )
              ]
            : [],
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isActive ? const Color(0xFF0B0C3A) : Colors.black54,
        ),
        title: Text(
          text,
          style: TextStyle(
            color: isActive ? const Color(0xFF0B0C3A) : Colors.black87,
            fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
          ),
        ),
        hoverColor: const Color(0xFFF4F4F4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onTap: onTap,
      ),
    );
  }
}

// Widget chip kategori kecil
class _CategoryChip extends StatelessWidget {
  final String label;
  const _CategoryChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFE6E6E6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.black87,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
