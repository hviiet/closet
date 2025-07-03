import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'outfit_list_screen.dart';
import 'collection_list_screen.dart';
import 'settings_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  void _changeTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  late final List<Widget> _screens;

  // Modern Navigation Destinations for Material Design 3
  final List<NavigationDestination> _navigationDestinations = [
    const NavigationDestination(
      icon: Icon(Icons.checkroom_outlined),
      selectedIcon: Icon(Icons.checkroom),
      label: 'Clothings',
      tooltip: 'View your clothing items',
    ),
    const NavigationDestination(
      icon: Icon(Icons.style_outlined),
      selectedIcon: Icon(Icons.style),
      label: 'Outfits',
      tooltip: 'Manage your outfits',
    ),
    const NavigationDestination(
      icon: Icon(Icons.collections_outlined),
      selectedIcon: Icon(Icons.collections),
      label: 'Collections',
      tooltip: 'Browse your collections',
    ),
    const NavigationDestination(
      icon: Icon(Icons.settings_outlined),
      selectedIcon: Icon(Icons.settings),
      label: 'Settings',
      tooltip: 'App settings',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _screens = [
      HomeScreen(onNavigateToTab: _changeTab),
      const OutfitListScreen(),
      const CollectionListScreen(),
      const SettingsScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: _navigationDestinations,
        animationDuration: const Duration(milliseconds: 300),
      ),
    );
  }
}
