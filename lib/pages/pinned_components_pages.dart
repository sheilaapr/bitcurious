import 'package:flutter/material.dart';
import 'package:bitcurious/services/pinned_repository.dart';
import 'package:bitcurious/pages/component_detail_pages.dart';

class PinnedComponentsPage extends StatefulWidget {
  const PinnedComponentsPage({super.key});

  @override
  State<PinnedComponentsPage> createState() => _PinnedComponentsPageState();
}

class _PinnedComponentsPageState extends State<PinnedComponentsPage> {
  /// Guard setState supaya tidak error kalau dipanggil
  /// setelah halaman di-pop (dispose).
  @override
  void setState(VoidCallback fn) {
    if (!mounted) return;
    super.setState(fn);
  }

  void _removePinned(PinnedComponent component) {
    setState(() {
      PinnedRepository.remove(component.name, component.categoryName);
    });
  }

  @override
  Widget build(BuildContext context) {
    const Color navy = Color(0xFF0B0C3A);
    const Color white = Colors.white;

    final pinned = PinnedRepository.items;

    return Scaffold(
      backgroundColor: navy,
      appBar: AppBar(
        backgroundColor: navy,
        elevation: 0,
        foregroundColor: white,
        title: const Text(
          'Pinned Components',
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
        child: pinned.isEmpty
            ? const Center(
                child: Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Text(
                    'Belum ada komponen yang di-pinned.\n'
                    'Coba buka detail komponen dan tekan tombol "Add to Pinned".',
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            : ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                itemCount: pinned.length,
                itemBuilder: (context, index) {
                  final item = pinned[index];
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
                            builder: (_) => ComponentDetailPage(
                              name: item.name,
                              description: item.description,
                              imageUrl: item.imageUrl,
                              price: item.price,
                              categoryName: item.categoryName,
                            ),
                          ),
                        ).then((_) {
                          // refresh list ketika balik (kalau user unpin di detail)
                          setState(() {});
                        });
                      },
                      leading: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey[300],
                          image: DecorationImage(
                            image: AssetImage(item.imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      title: Text(
                        item.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          Text(
                            item.categoryName,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "Rp ${item.price.toStringAsFixed(0)}",
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.green,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.push_pin,
                          color: Colors.redAccent,
                        ),
                        onPressed: () => _removePinned(item),
                        tooltip: 'Hapus dari Pinned',
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
