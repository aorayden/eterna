import 'package:flutter/material.dart';
import 'package:preview/screens/export_screen.dart';
import 'package:preview/screens/gallery_screen.dart';
import 'package:preview/screens/import_screen.dart';
import 'package:ui_kit/theme/colors.dart';

void main() => runApp(
  MaterialApp(
    title: 'Eterna Preview',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(scaffoldBackgroundColor: AppColors.screenBackground),

    initialRoute: '/galleryScreen',
    routes: {
      '/galleryScreen': (context) => const GalleryScreen(),
      '/importScreen': (context) => const ImportScreen(),
      '/exportScreen': (context) => const ExportScreen(),
    },
  ),
);
