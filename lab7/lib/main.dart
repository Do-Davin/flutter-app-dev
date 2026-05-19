import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lab7/models/cart_item.dart';
import 'package:lab7/models/post.dart';
import 'package:lab7/screens/cart_screen.dart';
import 'package:lab7/screens/notes_screen.dart';
import 'package:lab7/screens/paginated_screen.dart';
import 'package:lab7/screens/post_cache_screen.dart';
import 'package:lab7/services/prefs_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CartItemAdapter());
  Hive.registerAdapter(PostAdapter());
  await Hive.openBox<CartItem>('cart');
  await Hive.openBox<Post>('posts');
  await Hive.openBox<Post>('paginated_posts');

  String theme = await PrefsService.getTheme();
  String language = await PrefsService.getLanguage();

  runApp(MyApp(theme: theme, language: language));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.theme, required this.language});

  final String theme;
  final String language;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late String theme;
  late String language;

  @override
  void initState() {
    super.initState();
    theme = widget.theme;
    language = widget.language;
  }

  ThemeMode get themeMode {
    if (theme == 'light') {
      return ThemeMode.light;
    }

    if (theme == 'dark') {
      return ThemeMode.dark;
    }

    return ThemeMode.system;
  }

  void updateTheme(String value) {
    setState(() {
      theme = value;
    });
  }

  void updateLanguage(String value) {
    setState(() {
      language = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 7',
      themeMode: themeMode,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: HomeScreen(
        settingsScreen: SettingsScreen(
          theme: theme,
          language: language,
          onThemeChanged: updateTheme,
          onLanguageChanged: updateLanguage,
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.settingsScreen});

  final Widget settingsScreen;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lab 7')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => settingsScreen),
                );
              },
              child: const Text('Exercise 1: Settings'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NotesScreen()),
                );
              },
              child: const Text('Exercise 2: Notes'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CartScreen()),
                );
              },
              child: const Text('Exercise 3: Cart'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PostCacheScreen(),
                  ),
                );
              },
              child: const Text('Exercise 4: Posts Cache'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PaginatedScreen(),
                  ),
                );
              },
              child: const Text('Exercise 5: Infinite Posts'),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    super.key,
    required this.theme,
    required this.language,
    required this.onThemeChanged,
    required this.onLanguageChanged,
  });

  final String theme;
  final String language;
  final ValueChanged<String> onThemeChanged;
  final ValueChanged<String> onLanguageChanged;

  Future<void> saveTheme(BuildContext context, String value) async {
    await PrefsService.setTheme(value);
    onThemeChanged(value);

    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Theme saved')));
    }
  }

  Future<void> saveLanguage(BuildContext context, String value) async {
    await PrefsService.setLanguage(value);
    onLanguageChanged(value);

    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Language saved')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Theme'),
            DropdownButton<String>(
              value: theme,
              isExpanded: true,
              items: const [
                DropdownMenuItem(value: 'system', child: Text('System')),
                DropdownMenuItem(value: 'light', child: Text('Light')),
                DropdownMenuItem(value: 'dark', child: Text('Dark')),
              ],
              onChanged: (value) {
                if (value != null) {
                  saveTheme(context, value);
                }
              },
            ),
            const SizedBox(height: 24),
            const Text('Language'),
            DropdownButton<String>(
              value: language,
              isExpanded: true,
              items: const [
                DropdownMenuItem(value: 'en', child: Text('English')),
                DropdownMenuItem(value: 'km', child: Text('Khmer')),
              ],
              onChanged: (value) {
                if (value != null) {
                  saveLanguage(context, value);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
