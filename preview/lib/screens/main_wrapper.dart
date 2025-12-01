import 'package:flutter/material.dart';
import 'package:preview/screens/export_screen.dart';
import 'package:preview/screens/gallery_screen.dart';
import 'package:preview/screens/import_screen.dart';
import 'package:ui_kit/components/navigation.dart'; // Файл с AppNavigation (из прошлого шага)

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _selectedIndex = 0;

  // Список экранов для каждой вкладки
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
      // IndexedStack сохраняет состояние экранов (не перезагружает их при переключении)
      body: IndexedStack(index: _selectedIndex, children: _screens),
      bottomNavigationBar: AppNavigation(
        initialIndex: _selectedIndex,
        onItemSelected: _onItemTapped,
      ),
    );
  }
}
