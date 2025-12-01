import 'package:data_service/artwork_service.dart';
import 'package:flutter/material.dart';
import 'package:preview/screens/main_wrapper.dart';
import 'package:ui_kit/theme/colors.dart';

void main() async {
  // 1. Обязательно для выполнения асинхронного кода до runApp
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Инициализируем сервис и ждем загрузки данных
  // Благодаря await, приложение покажет Splash Screen, пока данные грузятся (обычно доли секунды)
  await ArtworkService.instance.loadArtworks();

  // 3. Запускаем приложение
  runApp(
    MaterialApp(
      title: 'Eterna Preview',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.screenBackground,
        fontFamily: 'Manrope',
      ),
      home: const MainWrapper(),
    ),
  );
}
