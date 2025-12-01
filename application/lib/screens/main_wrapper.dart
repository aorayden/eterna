import 'package:eterna/screens/export_screen.dart';
import 'package:eterna/screens/gallery_screen.dart';
import 'package:eterna/screens/import_screen.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/components/navigation.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const GalleryScreen(),
    const ImportScreen(),
    const ExportScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _screens),
      bottomNavigationBar: AppNavigation(
        initialIndex: _selectedIndex,
        onItemSelected: _onItemTapped,
      ),
    );
  }
}
