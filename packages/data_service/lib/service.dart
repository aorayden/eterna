import 'dart:convert';
import 'composition.dart';

class CompositionService {
  /// Преобразует список объектов [Composition] в JSON-строку.
  String compositionsToJson(List<Composition> compositions) {
    // 1. Преобразуем каждый объект Composition в Map.
    final List<Map<String, dynamic>> data = compositions
        .map((composition) => composition.toJson())
        .toList();

    // 2. Кодируем список Map в JSON-строку.
    return jsonEncode(data);
  }

  /// Преобразует JSON-строку обратно в список объектов [Composition].
  List<Composition> compositionsFromJson(String jsonString) {
    if (jsonString.isEmpty) {
      return [];
    }

    // 1. Декодируем строку в список динамических объектов.
    final List<dynamic> data = jsonDecode(jsonString);

    // 2. Преобразуем каждый элемент списка обратно в объект Composition.
    return data
        .map((item) => Composition.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
