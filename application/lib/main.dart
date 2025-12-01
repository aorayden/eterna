import 'package:data_service/artwork_service.dart';
import 'package:eterna/screens/main_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/theme/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ArtworkService.instance.loadArtworks();

  runApp(
    MaterialApp(
      title: 'Eterna - Art Gallery (MVP)',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.screenBackground,
        fontFamily: 'Manrope',
      ),
      home: const MainWrapper(),
    ),
  );
}
