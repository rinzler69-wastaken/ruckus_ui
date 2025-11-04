import 'package:flutter/material.dart';
import 'profile_page.dart';
import 'settings_page.dart';
import 'data_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();
  final List<Widget> _pages = [DashboardTab(), DataTab(), ProfileTab()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final String name = (args != null && args['name'] != null)
        ? args['name']
        : 'Andi';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ruckus'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0), // adjust to taste
            child: IconButton(
              icon: const Icon(Icons.settings),
              tooltip: 'Pengaturan',
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => const SettingsPage(),
                    transitionsBuilder: (_, animation, __, child) {
                      const begin = Offset(1.0, 0.0); // slide in from right
                      const end = Offset.zero;
                      const curve = Curves.easeInOut;
                      final tween = Tween(
                        begin: begin,
                        end: end,
                      ).chain(CurveTween(curve: curve));
                      return SlideTransition(
                        position: animation.drive(tween),
                        child: child,
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],

        elevation: 0, // remove shadow
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: Theme.of(context).dividerColor),
        ),
      ),

      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() => _selectedIndex = index);
        },
        children: _pages.map((page) {
          if (page is DashboardTab) return DashboardTab(name: name);
          if (page is ProfileTab) return ProfileTab(name: name);
          return page;
        }).toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        selectedItemColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.blueAccent
            : Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'Data'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}

// Dashboard tab
class DashboardTab extends StatelessWidget {
  final String name;
  const DashboardTab({super.key, this.name = 'Andi'});
  static const double maxContentWidth = 720.0;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? const Color(0xFF2A2A2A) : Colors.white;

    return Center(
      // 1. Center the content
      child: ConstrainedBox(
        // 2. Apply max width constraint
        constraints: const BoxConstraints(
          maxWidth: maxContentWidth, // 720.0
        ),
        child: Column(
          children: [
            // Wrap banner in Material to get elevation
            Padding(
              padding: const EdgeInsets.all(16), // same margin as before
              child: Material(
                elevation: 4, // shadow depth
                borderRadius: BorderRadius.circular(12),
                clipBehavior:
                    Clip.antiAlias, // ensures image respects border radius
                child: Container(
                  width: double.infinity,
                  height: 140,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        isDark ? 'assets/banner_dark.png' : 'assets/banner.png',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Hello, $name!',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            offset: Offset(0, 1),
                            blurRadius: 2,
                            color: Colors.black54,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // const SizedBox(height: 12),

            // Expanded Card for welcome text
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ).copyWith(bottom: 24), // <-- added extra bottom padding

                child: Card(
                  color: cardColor,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Selamat datang di Ruckus, sebuah aplikasi demonstrasi UI sederhana, dibuat dengan Flutter.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 12),
                          Text(
                            'Ini adalah halaman Dashboard. Tekan Data di navbar bawah untuk menuju halaman Data, dan tekan Profil di navbar bawah untuk melihat halaman profil. Untuk membuka Pengaturan, pilih ikon gir di sebelah kanan AppBar (you know what an AppBar is, right?).',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Data tab
// class DataTab extends StatelessWidget {
//   const DataTab({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text(
//         'Halaman Data',
//         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//       ),
//     );
//   }
// }
