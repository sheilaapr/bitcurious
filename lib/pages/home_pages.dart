import 'package:flutter/material.dart';
import 'components_categories_pages.dart';
import 'articles_pages.dart';
import 'project_references_pages.dart';
import 'news_pages.dart';
import 'pinned_components_pages.dart';
import 'notes_page.dart';
import 'search_pages.dart';
import 'package:bitcurious/services/news_api_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  late final List<Widget> _pages;
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _pages = const [
      ComponentsCategoriesPage(),
      ArticlesPage(),
      ProjectReferencesPage(),
      PinnedComponentsPage(),
      NotesPage(),
    ];
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onTabChipTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _startSearch() {
    final query = _searchController.text.trim();
    if (query.isEmpty) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SearchPage(initialQuery: query),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color navy = Color(0xFF0B0C3A);
    const Color darkBlue = Color(0xFF000814);

    return Scaffold(
      drawer: _buildDrawer(),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // TOP: AppBar custom + search
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [navy, darkBlue],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Bar atas
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    child: Row(
                      children: [
                        Builder(
                          builder: (context) => IconButton(
                            icon: const Icon(
                              Icons.menu_rounded,
                              color: Colors.white,
                            ),
                            onPressed: () => Scaffold.of(context).openDrawer(),
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          'BitCurious',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(
                            Icons.notifications_none_rounded,
                            color: Colors.white,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Hello,',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: Text(
                      'Sheila!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Search bar
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.06),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Cari komponen, artikel, project...',
                                hintStyle: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 14,
                                ),
                              ),
                              onSubmitted: (_) => _startSearch(),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.arrow_forward_rounded,
                                color: Colors.white,
                              ),
                              onPressed: _startSearch,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),

          // Body putih dengan tab chip & page
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
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  // Tab chip
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        _buildTabChip('Komponen', 0),
                        _buildTabChip('Artikel', 1),
                        _buildTabChip('Project Islami', 2),
                        _buildTabChip('Pinned', 3),
                        _buildTabChip('Notes', 4),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Konten page
                  Expanded(
                    child: _pages[_selectedIndex],
                  ),
                ],
              ),
            ),
          ),

          // Bottom nav
          _buildBottomNav(),
        ],
      ),
      
    );
  }

  Widget _buildTabChip(String label, int index) {
    final bool isSelected = _selectedIndex == index;
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: GestureDetector(
        onTap: () => _onTabChipTapped(index),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF0B0C3A) : Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              if (isSelected)
                BoxShadow(
                  color: const Color(0xFF0B0C3A).withOpacity(0.25),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
            ],
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey.shade800,
              fontSize: 13,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      elevation: 10,
      selectedItemColor: const Color(0xFF0B0C3A),
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.memory_rounded),
          label: 'Komponen',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu_book_rounded),
          label: 'Artikel',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bolt_rounded),
          label: 'Project',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.push_pin_rounded),
          label: 'Pinned',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.note_alt_rounded),
          label: 'Notes',
        ),
      ],
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text('Sheila Apriliani Putri'),
              accountEmail: Text('BitCurious User'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/images/image_sheila.jpg'),
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF0B0C3A),
                    Color(0xFF000814),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const ListTile(
                    leading: Icon(Icons.info_outline_rounded),
                    title: Text('About Us'),
                    subtitle: Text('BitCurious - Pengenalan Elektronika & IoT'),
                  ),
                  const Divider(),
                  // Section berita terkini
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      'Berita Terkini (NewsAPI)',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 200,
                    child: FutureBuilder<List<dynamic>>(
                      future: NewsApiService.fetchTechNews(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.hasError) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              'Gagal memuat berita: ${snapshot.error}',
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.redAccent,
                              ),
                            ),
                          );
                        }
                        final news = snapshot.data ?? [];
                        if (news.isEmpty) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              'Tidak ada berita.',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          );
                        }
                        final limited =
                            news.length > 3 ? news.sublist(0, 3) : news;

                        return ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          itemCount: limited.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 4),
                          itemBuilder: (context, index) {
                            final item = limited[index] as Map<String, dynamic>;
                            final title = (item['title'] ?? '').toString();
                            final source =
                                (item['sourceName'] ?? '').toString();

                            return ListTile(
                              dense: true,
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 12),
                              ),
                              subtitle: source.isNotEmpty
                                  ? Text(
                                      source,
                                      style: const TextStyle(
                                        fontSize: 11,
                                        color: Colors.grey,
                                      ),
                                    )
                                  : null,
                              onTap: () {
                                // Buka halaman berita penuh
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const NewsPage(),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.article_outlined),
                    title: const Text('Lihat semua berita'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const NewsPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
