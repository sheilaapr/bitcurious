// import 'package:flutter/material.dart';

// import 'component_list_pages.dart';
// import 'articles_pages.dart';
// import 'project_references_pages.dart';
// import 'news_pages.dart';
// import 'pinned_components_pages.dart';

// class HomePages extends StatefulWidget {
//   const HomePages({super.key});

//   @override
//   State<HomePages> createState() => _HomePagesState();
// }

// class _HomePagesState extends State<HomePages> {
//   int _selectedIndex = 0;

//   late final TextEditingController _searchController;

//   final List<Widget> _pages = const [
//     ComponentListPage(categoryName: 'All'),
//     ArticlesPage(),
//     ProjectReferencesPage(),
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _searchController = TextEditingController();
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   /// Guard setState supaya kalau suatu saat ada callback/timer di sini,
//   /// dia tidak akan update state setelah halaman di-pop.
//   @override
//   void setState(VoidCallback fn) {
//     if (!mounted) return;
//     super.setState(fn);
//   }

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   void _onSearchSubmitted(String value) {
//     final query = value.trim();
//     if (query.isEmpty) return;

//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (_) => NewsPage(initialQuery: query),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     const Color navy = Color(0xFF0B0C3A);
//     const Color white = Colors.white;

//     return Scaffold(
//       backgroundColor: navy,
//       appBar: AppBar(
//         backgroundColor: navy,
//         elevation: 0,
//         iconTheme: const IconThemeData(
//           color: white,
//         ),
//         title: const Text(
//           'BitCurious',
//           style: TextStyle(
//             color: white,
//             fontWeight: FontWeight.bold,
//             fontSize: 20,
//           ),
//         ),
//       ),
//       drawer: _buildDrawer(),
//       body: Column(
//         children: [
//           // ====== HEADER TOP ======
//           Padding(
//             padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   'Hello,',
//                   style: TextStyle(
//                     color: Colors.white70,
//                     fontSize: 16,
//                     fontStyle: FontStyle.italic,
//                   ),
//                 ),
//                 const Text(
//                   'Sheila!',
//                   style: TextStyle(
//                     color: white,
//                     fontSize: 26,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 16),

//                 // Search glossy — sekarang untuk berita (News API)
//                 Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 14,
//                     vertical: 6,
//                   ),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(18),
//                     color: Colors.white.withOpacity(0.10),
//                     border: Border.all(color: Colors.white24, width: 1),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.22),
//                         blurRadius: 12,
//                         offset: const Offset(0, 6),
//                       ),
//                     ],
//                   ),
//                   child: Row(
//                     children: [
//                       const Icon(
//                         Icons.search_rounded,
//                         color: Colors.white,
//                         size: 20,
//                       ),
//                       const SizedBox(width: 10),
//                       Expanded(
//                         child: TextField(
//                           controller: _searchController,
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 13,
//                           ),
//                           decoration: const InputDecoration(
//                             isDense: true,
//                             border: InputBorder.none,
//                             hintText:
//                                 'Cari berita teknologi / IoT (mis: esp32, sensor)...',
//                             hintStyle: TextStyle(
//                               color: Colors.white70,
//                               fontSize: 12,
//                             ),
//                           ),
//                           textInputAction: TextInputAction.search,
//                           onSubmitted: _onSearchSubmitted,
//                         ),
//                       ),
//                       IconButton(
//                         icon: const Icon(
//                           Icons.arrow_forward_rounded,
//                           color: Colors.white,
//                           size: 20,
//                         ),
//                         onPressed: () =>
//                             _onSearchSubmitted(_searchController.text),
//                       ),
//                     ],
//                   ),
//                 ),

//                 const SizedBox(height: 18),

//                 // Indicator dots
//                 Row(
//                   children: [
//                     Container(
//                       width: 20,
//                       height: 6,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     const SizedBox(width: 6),
//                     Container(
//                       width: 10,
//                       height: 6,
//                       decoration: BoxDecoration(
//                         color: Colors.white38,
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     const SizedBox(width: 6),
//                     Container(
//                       width: 6,
//                       height: 6,
//                       decoration: BoxDecoration(
//                         color: Colors.white24,
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),

//           // ====== BODY PUTIH ======
//           Expanded(
//             child: Container(
//               width: double.infinity,
//               decoration: const BoxDecoration(
//                 color: white,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(28),
//                   topRight: Radius.circular(28),
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black26,
//                     blurRadius: 12,
//                     offset: Offset(0, -4),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 children: [
//                   const SizedBox(height: 12),

//                   // Tab label kecil di atas
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         _buildTabChip('Komponen', 0),
//                         _buildTabChip('Artikel', 1),
//                         _buildTabChip('Project Islami', 2),
//                       ],
//                     ),
//                   ),

//                   const SizedBox(height: 12),
//                   const Divider(
//                     height: 1,
//                     thickness: 0.8,
//                   ),

//                   Expanded(
//                     child: IndexedStack(
//                       index: _selectedIndex,
//                       children: _pages,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: _buildBottomNav(),
//     );
//   }

//   Widget _buildTabChip(String label, int index) {
//     final bool isSelected = _selectedIndex == index;

//     return GestureDetector(
//       onTap: () => _onItemTapped(index),
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 200),
//         padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
//         decoration: BoxDecoration(
//           color: isSelected ? const Color(0xFF0B0C3A) : Colors.transparent,
//           borderRadius: BorderRadius.circular(16),
//           border: Border.all(
//             color:
//                 isSelected ? const Color(0xFF0B0C3A) : Colors.grey.shade300,
//           ),
//         ),
//         child: Text(
//           label,
//           style: TextStyle(
//             fontSize: 12,
//             fontWeight: FontWeight.w600,
//             color: isSelected ? Colors.white : Colors.grey.shade700,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildBottomNav() {
//     return BottomNavigationBar(
//       currentIndex: _selectedIndex,
//       onTap: _onItemTapped,
//       elevation: 10,
//       selectedItemColor: const Color(0xFF0B0C3A),
//       unselectedItemColor: Colors.grey,
//       items: const [
//         BottomNavigationBarItem(
//           icon: Icon(Icons.memory_rounded),
//           label: 'Komponen',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.menu_book_rounded),
//           label: 'Artikel',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.bolt_rounded),
//           label: 'Project',
//         ),
//       ],
//     );
//   }

//   Drawer _buildDrawer() {
//     const Color navy = Color(0xFF0B0C3A);

//     return Drawer(
//       child: Column(
//         children: [
//           DrawerHeader(
//             decoration: const BoxDecoration(
//               color: navy,
//             ),
//             child: Row(
//               children: [
//                 const CircleAvatar(
//                   radius: 32,
//                   backgroundImage:
//                       AssetImage('assets/images/image_sheila.JPG'),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: const [
//                       Text(
//                         'Sheila Apriliani Putri',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 18,
//                         ),
//                       ),
//                       SizedBox(height: 4),
//                       Text(
//                         'Elektronika & IoT Enthusiast',
//                         style: TextStyle(
//                           color: Colors.white70,
//                           fontSize: 12,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           ListTile(
//             leading: const Icon(Icons.home_rounded),
//             title: const Text('Home'),
//             onTap: () {
//               Navigator.pop(context);
//             },
//           ),
//           ListTile(
//             leading: const Icon(Icons.push_pin_rounded),
//             title: const Text('Pinned Components'),
//             onTap: () {
//               Navigator.pop(context);
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (_) => const PinnedComponentsPage(),
//                 ),
//               );
//             },
//           ),
//           ListTile(
//             leading: const Icon(Icons.newspaper_rounded),
//             title: const Text('Berita Teknologi (API Publik)'),
//             onTap: () {
//               Navigator.pop(context);
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (_) => const NewsPage(),
//                 ),
//               );
//             },
//           ),
//           ListTile(
//             leading: const Icon(Icons.info_outline_rounded),
//             title: const Text('About Us'),
//             onTap: () {
//               Navigator.pop(context);
//               _showAboutDialog();
//             },
//           ),
//           const Spacer(),
//           ListTile(
//             leading: const Icon(Icons.logout),
//             title: const Text('Logout'),
//             onTap: () {
//               Navigator.pop(context);
//               // Implementasi logout jika ada
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   void _showAboutDialog() {
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: const Text('About BitCurious'),
//         content: const Text(
//           'BitCurious adalah aplikasi pengenalan komponen elektronika dan IoT\n'
//           'serta referensi project bernuansa Islami.',
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Tutup'),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';

import 'components_categories_pages.dart';
import 'articles_pages.dart';
import 'project_references_pages.dart';
import 'news_pages.dart';
import 'pinned_components_pages.dart';

class HomePages extends StatefulWidget {
  const HomePages({super.key});

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  int _selectedIndex = 0;

  late final TextEditingController _searchController;

  // Tab 0 → kategori komponen
  // Tab 1 → artikel
  // Tab 2 → project Islami
  // Tab 3 → pinned
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _pages = const [
      ComponentsCategoriesPage(),
      ArticlesPage(),
      ProjectReferencesPage(),
      PinnedComponentsPage(),
    ];
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Guard kalau nanti ada callback di sini
  @override
  void setState(VoidCallback fn) {
    if (!mounted) return;
    super.setState(fn);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onSearchSubmitted(String value) {
    final query = value.trim();
    if (query.isEmpty) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => NewsPage(initialQuery: query),
      ),
    );
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
        iconTheme: const IconThemeData(
          color: white,
        ),
        title: const Text(
          'BitCurious',
          style: TextStyle(
            color: white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      drawer: _buildDrawer(),
      body: Column(
        children: [
          // ====== HEADER TOP (welcome + search berita) ======
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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

                // Search berita (News API)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: Colors.white.withOpacity(0.10),
                    border: Border.all(color: Colors.white24, width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.22),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.search_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                          decoration: const InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                            hintText:
                                'Cari berita teknologi / IoT (mis: esp32, sensor)...',
                            hintStyle: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                          textInputAction: TextInputAction.search,
                          onSubmitted: _onSearchSubmitted,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                        onPressed: () =>
                            _onSearchSubmitted(_searchController.text),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 18),

                // Indicator dots
                Row(
                  children: [
                    Container(
                      width: 20,
                      height: 6,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      width: 10,
                      height: 6,
                      decoration: BoxDecoration(
                        color: Colors.white38,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ====== BODY PUTIH ======
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 12,
                    offset: Offset(0, -4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const SizedBox(height: 12),

                  // Tab label kecil di atas
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildTabChip('Komponen', 0),
                        _buildTabChip('Artikel', 1),
                        _buildTabChip('Project Islami', 2),
                        _buildTabChip('Pinned', 3),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),
                  const Divider(
                    height: 1,
                    thickness: 0.8,
                  ),

                  Expanded(
                    child: IndexedStack(
                      index: _selectedIndex,
                      children: _pages,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildTabChip(String label, int index) {
    final bool isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF0B0C3A) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color:
                isSelected ? const Color(0xFF0B0C3A) : Colors.grey.shade300,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : Colors.grey.shade700,
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
      ],
    );
  }

  Drawer _buildDrawer() {
    const Color navy = Color(0xFF0B0C3A);

    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: navy,
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 32,
                  backgroundImage:
                      AssetImage('assets/images/image_sheila.JPG'),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Sheila Aziza',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Elektronika & IoT Enthusiast',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_rounded),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.newspaper_rounded),
            title: const Text('Berita Teknologi (API Publik)'),
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
          ListTile(
            leading: const Icon(Icons.info_outline_rounded),
            title: const Text('About Us'),
            onTap: () {
              Navigator.pop(context);
              _showAboutDialog();
            },
          ),
          const Spacer(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              Navigator.pop(context);
              // Implementasi logout jika ada
            },
          ),
        ],
      ),
    );
  }

  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('About BitCurious'),
        content: const Text(
          'BitCurious adalah aplikasi pengenalan komponen elektronika dan IoT\n'
          'serta referensi project bernuansa Islami.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }
}
