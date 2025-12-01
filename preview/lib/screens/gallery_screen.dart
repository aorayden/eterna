import 'package:flutter/material.dart';
import 'package:ui_kit/components/search.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [AppSearch(onChanged: (value) {})],
        ),
      ),
    );
  }
}
