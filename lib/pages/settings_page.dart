import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    // final bool isBianco = themeProvider.isBianco;
    final bool effectiveIsBianco =
        themeProvider.preference == ThemePreference.bianco ||
        (themeProvider.preference == ThemePreference.system &&
            Theme.of(context).brightness == Brightness.light);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Pengaturan'),
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: Theme.of(context).dividerColor),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Tema',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _themeButton(
                    context,
                    'Bianco',
                    themeProvider.preference == ThemePreference.bianco,
                    true, // highlight as Bianco when active
                    ThemePreference.bianco,
                  ),
                  const SizedBox(width: 16),
                  _themeButton(
                    context,
                    'Nero',
                    themeProvider.preference == ThemePreference.nero,
                    false, // highlight as Nero when active
                    ThemePreference.nero,
                  ),
                  const SizedBox(width: 16),
                  _themeButton(
                    context,
                    'System',
                    themeProvider.preference == ThemePreference.system,
                    effectiveIsBianco, // highlight as Bianco or Nero depending on effective theme
                    ThemePreference.system,
                  ),
                ],
              ),

              const SizedBox(height: 40),
              TextButton(
                onPressed: () => _showAbout(context),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  backgroundColor: Theme.of(
                    context,
                  ).colorScheme.surface.withOpacity(0.1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('About'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _themeButton(
    BuildContext context,
    String label,
    bool active,
    bool highlightAsBianco,
    ThemePreference preference,
  ) {
    // highlightAsBianco == true -> use Bianco-style highlight (black fill + white text)
    // highlightAsBianco == false -> use Nero-style highlight (white fill + black text)
    final Color activeFill = highlightAsBianco ? Colors.black : Colors.white;
    final Color activeText = highlightAsBianco ? Colors.white : Colors.black;
    final Color inactiveBorder =
        Theme.of(context).brightness == Brightness.light
        ? Colors.grey.shade400
        : Colors.grey.shade500;

    return GestureDetector(
      onTap: () => context.read<ThemeProvider>().setTheme(preference),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: active ? activeFill : Colors.transparent,
          border: Border.all(color: active ? activeFill : inactiveBorder),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: active ? activeText : Colors.grey,
          ),
        ),
      ),
    );
  }

  void _showAbout(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Ruckus'),
        content: const Text(
          'A simple Flutter UI Demonstration.\nby Art Fazil\n\nv1.0.0.mendoan.',
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
