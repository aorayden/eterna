import 'dart:convert';
import 'dart:io';

import 'package:data_service/models/artwork_model.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class ArtworkService {
  static final ArtworkService _instance = ArtworkService._internal();
  static ArtworkService get instance => _instance;

  ArtworkService._internal();

  final ValueNotifier<List<ArtworkModel>> artworksNotifier = ValueNotifier([]);

  static const String _fileName = 'artworks.json';

  Future<void> loadArtworks() async {
    try {
      final file = await _localFile;

      if (!await file.exists()) {
        debugPrint(
          'ArtworkService: Файл сохранения не найден. Старт с пустым списком.',
        );
        return;
      }

      final String content = await file.readAsString();

      if (content.isEmpty) return;

      final List<dynamic> jsonList = jsonDecode(content);

      final List<ArtworkModel> loadedArtworks = jsonList
          .map((json) => ArtworkModel.fromJson(json))
          .toList();

      artworksNotifier.value = loadedArtworks;
      debugPrint(
        'ArtworkService: Загружено ${loadedArtworks.length} произведений.',
      );
    } catch (e) {
      debugPrint('ArtworkService: Ошибка при загрузке данных: $e');
      artworksNotifier.value = [];
    }
  }

  Future<void> addArtwork(ArtworkModel artwork) async {
    final currentList = List<ArtworkModel>.from(artworksNotifier.value);
    currentList.add(artwork);
    artworksNotifier.value = currentList;

    await _saveToDisk(currentList);
  }

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

  Future<File> get _localFile async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/$_fileName');
  }

  Future<void> _saveToDisk(List<ArtworkModel> list) async {
    try {
      final file = await _localFile;

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
