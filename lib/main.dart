import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';
import 'pages/login_page.dart';
import 'pages/dashboard_page.dart';
import 'pages/profile_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const RuckusApp(),
    ),
  );
}

class RuckusApp extends StatelessWidget {
  const RuckusApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Ruckus UI',
      debugShowCheckedModeBanner: false,
      themeMode: themeProvider.themeMode,

      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        dividerColor: Colors.grey.shade300,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        // *** CHANGE 1: Scaffold Background (General page background) ***
        scaffoldBackgroundColor: const Color(0xFF1E1E1E),
        // Note: The cardColor below is not strictly used by Dashboard/Profile cards
        // because those widgets define their own cardColor variable.
        // It's good practice to set it here anyway for consistency.
        cardColor: const Color(0xFF2A2A2A),
        appBarTheme: const AppBarTheme(
          // *** CHANGE 2: AppBar Background (Should match scaffold background) ***
          backgroundColor: Color(0xFF1E1E1E),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        colorScheme: ColorScheme.dark(
          primary: Colors.indigoAccent,
          secondary: Colors.grey,
        ),
        dividerColor: Colors.grey.shade800,
      ),

      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/dashboard': (context) => const HomePage(),
        '/profile': (context) => const ProfileTab(),
      },
    );
  }
}
