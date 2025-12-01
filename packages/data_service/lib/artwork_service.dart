import 'dart:convert';
import 'dart:io';

import 'package:data_service/models/artwork_model.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class ArtworkService {
  // --- Singleton ---
  static final ArtworkService _instance = ArtworkService._internal();
  static ArtworkService get instance => _instance;

  ArtworkService._internal();

  // --- State ---
  // ValueNotifier позволяет UI подписываться на изменения списка
  final ValueNotifier<List<ArtworkModel>> artworksNotifier = ValueNotifier([]);

  // Имя файла для сохранения
  static const String _fileName = 'artworks.json';

  // --- Public Methods ---

  /// Загрузка данных с диска. Вызывается в main.dart перед запуском UI.
  Future<void> loadArtworks() async {
    try {
      final file = await _localFile;

      // Если файла нет, просто выходим (список останется пустым)
      if (!await file.exists()) {
        debugPrint(
          'ArtworkService: Файл сохранения не найден. Старт с пустым списком.',
        );
        return;
      }

      final String content = await file.readAsString();

      // Если файл пустой, тоже выходим
      if (content.isEmpty) return;

      final List<dynamic> jsonList = jsonDecode(content);

      // Преобразуем JSON в модели
      final List<ArtworkModel> loadedArtworks = jsonList
          .map((json) => ArtworkModel.fromJson(json))
          .toList();

      artworksNotifier.value = loadedArtworks;
      debugPrint(
        'ArtworkService: Загружено ${loadedArtworks.length} произведений.',
      );
    } catch (e) {
      debugPrint('ArtworkService: Ошибка при загрузке данных: $e');
      // В случае ошибки (например, битый JSON) можно сбросить список
      artworksNotifier.value = [];
    }
  }

  /// Добавление нового произведения и сохранение на диск.
  Future<void> addArtwork(ArtworkModel artwork) async {
    // 1. Обновляем список в памяти (для мгновенной реакции UI)
    final currentList = List<ArtworkModel>.from(artworksNotifier.value);
    currentList.add(artwork);
    artworksNotifier.value = currentList;

    // 2. Асинхронно сохраняем в файл
    await _saveToDisk(currentList);
  }

  /// Полная очистка данных (удаление файла).
  Future<void> clear() async {
    artworksNotifier.value = [];
    try {
      final file = await _localFile;
      if (await file.exists()) {
        await file.delete();
        debugPrint('ArtworkService: Данные очищены.');
      }
    } catch (e) {
      debugPrint('ArtworkService: Ошибка очистки: $e');
    }
  }

  // --- Private Helpers ---

  /// Получение пути к файлу в папке документов приложения.
  Future<File> get _localFile async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/$_fileName');
  }

  /// Сериализация списка и запись в файл.
  Future<void> _saveToDisk(List<ArtworkModel> list) async {
    try {
      final file = await _localFile;

      // Превращаем модели в JSON
      final List<Map<String, dynamic>> jsonList = list
          .map((item) => item.toJson())
          .toList();

      final String jsonString = jsonEncode(jsonList);

      await file.writeAsString(jsonString);
      debugPrint('ArtworkService: Данные сохранены на диск.');
    } catch (e) {
      debugPrint('ArtworkService: Ошибка сохранения: $e');
    }
  }
}
