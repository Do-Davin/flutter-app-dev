import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ex1_counter.dart';
import 'ex2_cart.dart';
import 'ex3_wishlist.dart';
import 'ex4_provider_color.dart';
import 'ex5_undo.dart';

void main() {
  runApp(
    // MultiProvider registers multiple models at once.
    // Any widget below can access CartModel OR WishlistModel.
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartModel()),
        ChangeNotifierProvider(create: (_) => WishlistModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 5',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab 5 — Exercises'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const CircleAvatar(child: Text('1')),
            title: const Text('Counter with History'),
            subtitle: const Text('setState + ListView'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CounterScreen()),
            ),
          ),
          const Divider(),
          ListTile(
            leading: const CircleAvatar(child: Text('2')),
            title: const Text('CartModel with Price'),
            subtitle: const Text('ChangeNotifier + Provider'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CartScreen()),
            ),
          ),
          const Divider(),
          ListTile(
            leading: const CircleAvatar(child: Text('3')),
            title: const Text('WishlistModel + MultiProvider'),
            subtitle: const Text('MultiProvider + two ChangeNotifiers'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const WishlistShopScreen()),
            ),
          ),
          const Divider(),
          ListTile(
            leading: const CircleAvatar(child: Text('4')),
            title: const Text('Replace Prop Drilling with Provider'),
            subtitle: const Text('Provider<Color>.value + context.watch'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ColorDemoScreen()),
            ),
          ),
          const Divider(),
          ListTile(
            leading: const CircleAvatar(child: Text('5')),
            title: const Text('Undo in CartModel'),
            subtitle: const Text('canUndo + undo() + disabled button'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const UndoCartScreen()),
            ),
          ),
        ],
      ),
    );
  }
}
