import 'package:flutter/material.dart';

/// Абстрактный класс, содержащий палитру цветов приложения.
///
/// Использование констант позволяет легко менять цветовую схему в одном месте..
/// .. и поддерживать единый стиль во всем приложении.
abstract class AppColors {
  /// Основной акцентный цвет приложения (фирменный синий).
  /// Используется для активных кнопок, ссылок и ключевых элементов интерфейса.
  static const Color accent = Color(0xFF2074F2);

  /// Цвет неактивного акцентного элемента.
  /// Применяется для задизэйбленных (disabled) кнопок или элементов, ..
  /// .. которые пока недоступны для взаимодействия.
  static const Color accentInactive = Color(0xFFC5D2FF);

  /// Основной черный цвет для текста и заголовков.
  static const Color black = Color(0xFF2D2C2C);

  /// Основной белый цвет фона или текста на темном фоне.
  static const Color white = Color(0xFFF7F7F7);

  /// Цвет для отображения ошибок, предупреждений и деструктивных действий.
  static const Color error = Color(0xFFFF4646);

  /// Цвет для отображения успешных операций или статусов.
  static const Color success = Color(0xFF00B412);

  /// Цвет обводки (границы) карточек или контейнеров.
  /// Используется для визуального разделения блоков на белом фоне.
  static const Color cardStroke = Color(0xFFF2F2F2);

  /// Цвет фона полей ввода (Input fields).
  static const Color inputBackground = Color(0xFFF7F7FA);

  /// Цвет границы полей ввода в обычном состоянии.
  static const Color inputStroke = Color(0xFFE6E6E6);

  /// Цвет иконок внутри полей ввода (например, иконка глаза для пароля или поиска).
  static const Color inputIcon = Color(0xFFBFC7D1);

  /// Цвет текста-подсказки (placeholder) в полях ввода, когда текст еще не введен.
  static const Color placeholder = Color(0xFF98989A);

  /// Цвет для вторичного текста, описаний и подписей.
  static const Color description = Color(0xFF8787A1);
}
