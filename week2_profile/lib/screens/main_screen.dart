import 'package:flutter/material.dart';
import 'package:week2_profile/screens/dashboard_screen.dart';
import 'package:week2_profile/screens/shop_screen.dart';
import 'package:week2_profile/screens/profile_card_screen.dart';
import 'package:week2_profile/screens/profile_screen.dart';
import 'package:week2_profile/theme/app_theme.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  final List<Widget> screens = [
    const DashboardScreen(),
    const ShopScreen(),
    const ProfileCardScreen(),
    const ProfileScreen(),
  ];

  final List<String> titles = [
    "Dashboard",
    "Shop",
    "Profile Card",
    "Personal Profile",
  ];

  void _onItemTapped(int index) {
    setState(() => selectedIndex = index);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          titles[selectedIndex],
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppTheme.primaryPurple,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: AppTheme.primaryPurple),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Dashboard'),
              selected: selectedIndex == 0,
              onTap: () => _onItemTapped(0),
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text('Shop'),
              selected: selectedIndex == 1,
              onTap: () => _onItemTapped(1),
            ),
            ListTile(
              leading: const Icon(Icons.badge),
              title: const Text('Profile Card'),
              selected: selectedIndex == 2,
              onTap: () => _onItemTapped(2),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Personal Profile'),
              selected: selectedIndex == 3,
              onTap: () => _onItemTapped(3),
            ),
          ],
        ),
      ),
      body: screens[selectedIndex],
    );
  }
}
