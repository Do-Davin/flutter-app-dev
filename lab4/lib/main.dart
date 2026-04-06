// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:lab4/screens/home_screen.dart';
// import 'package:lab4/screens/profile_screen.dart';
// import 'package:lab4/screens/settings_screen.dart';

// final router = GoRouter(
//   initialLocation: '/home',
//   routes: [
//     GoRoute(path: '/home', builder: (_, __) => const HomeScreen()),
//     GoRoute(path: '/profile', builder: (_, __) => const ProfileScreen()),
//     GoRoute(path: '/settings', builder: (_, __) => const SettingsScreen()),
//   ],
// );

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp.router(
//       debugShowCheckedModeBanner: false,
//       title: 'Lab 4',
//       theme: ThemeData(colorSchemeSeed: Colors.indigo),
//       routerConfig: router,
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:lab4/screens/home_screen.dart';
// import 'package:lab4/screens/profile_screen.dart';
// import 'package:lab4/screens/settings_screen.dart';
// import 'package:lab4/screens/item_detail_screen.dart';

// final router = GoRouter(
//   initialLocation: '/home',
//   routes: [
//     GoRoute(
//       path: '/home',
//       builder: (_, __) => const HomeScreen(),
//       routes: [
//         GoRoute(
//           path: 'item/:id', // resolves to /home/item/:id
//           builder: (_, state) {
//             final id = state.pathParameters['id']!;
//             return ItemDetailScreen(id: id);
//           },
//         ),
//       ],
//     ),
//     GoRoute(path: '/profile', builder: (_, __) => const ProfileScreen()),
//     GoRoute(path: '/settings', builder: (_, __) => const SettingsScreen()),
//   ],
// );

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp.router(
//       debugShowCheckedModeBanner: false,
//       title: 'Lab 4',
//       theme: ThemeData(colorSchemeSeed: Colors.indigo),
//       routerConfig: router,
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:lab4/screens/cart_screen.dart';
import 'package:lab4/screens/catalog_screen.dart';
import 'package:lab4/screens/profile_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lab 4',
      theme: ThemeData(colorSchemeSeed: Colors.indigo),
      // home: const ProfileScreen(),
      // home: const CartScreen(),
      home: const CatalogScreen(),
    );
  }
}
