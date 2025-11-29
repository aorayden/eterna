import 'package:flutter/material.dart';
import 'package:ui_kit/config.dart';

/// Абстрактный класс, содержащий кастомные иконки приложения.
///
/// Иконки загружаются из шрифта, указанного в [PackageConfig.fontFamily].
/// Использование векторных иконок (шрифта) обеспечивает четкость на экранах с любой плотностью пикселей.
abstract class AppIcons {
  /// Иконка галереи.
  /// Используется для навигации.
  static const IconData gallery = IconData(
    0xea01,
    fontFamily: PackageConfig.fontFamily,
    fontPackage: PackageConfig.packageName,
  );

  /// Иконка экспорта.
  /// Используется для навигации.
  static const IconData export = IconData(
    0xea02,
    fontFamily: PackageConfig.fontFamily,
    fontPackage: PackageConfig.packageName,
  );

  /// Иконка импорта.
  /// Используется для навигации.
  static const IconData import = IconData(
    0xea03,
    fontFamily: PackageConfig.fontFamily,
    fontPackage: PackageConfig.packageName,
  );

  /// Иконка отправки.
  /// Используется для уведомлений.
  static const IconData send = IconData(
    0xea04,
    fontFamily: PackageConfig.fontFamily,
    fontPackage: PackageConfig.packageName,
  );

  /// Иконка скрепки.
  /// Используется для прикрепления файлов форме.
  static const IconData attach = IconData(
    0xea05,
    fontFamily: PackageConfig.fontFamily,
    fontPackage: PackageConfig.packageName,
  );

  /// Иконка документа.
  /// Обозначает текстовые файлы.
  static const IconData document = IconData(
    0xea06,
    fontFamily: PackageConfig.fontFamily,
    fontPackage: PackageConfig.packageName,
  );

  /// Иконка галочки.
  /// Используется для подтверждения действия, обозначения выбранного элемента или успешного статуса.
  static const IconData check = IconData(
    0xea07,
    fontFamily: PackageConfig.fontFamily,
    fontPackage: PackageConfig.packageName,
  );

  /// Иконка закрытия в круге (залитая).
  /// Используется для очистки полей ввода.
  static const IconData closeFilled = IconData(
    0xea08,
    fontFamily: PackageConfig.fontFamily,
    fontPackage: PackageConfig.packageName,
  );

  /// Иконка закрытия (крестик).
  /// Стандартная иконка для закрытия модальных окон или шторок.
  static const IconData close = IconData(
    0xea09,
    fontFamily: PackageConfig.fontFamily,
    fontPackage: PackageConfig.packageName,
  );

  /// Иконка скачивания.
  /// Используется для загрузки файлов на устройство.
  static const IconData download = IconData(
    0xea0a,
    fontFamily: PackageConfig.fontFamily,
    fontPackage: PackageConfig.packageName,
  );

  /// Иконка удаления (корзина).
  /// Используется для необратимого удаления элементов.
  static const IconData delete = IconData(
    0xea0b,
    fontFamily: PackageConfig.fontFamily,
    fontPackage: PackageConfig.packageName,
  );

  /// Иконка меню (гамбургер).
  /// Используется для вызова бокового меню или навигации.
  static const IconData menu = IconData(
    0xea0c,
    fontFamily: PackageConfig.fontFamily,
    fontPackage: PackageConfig.packageName,
  );

  /// Иконка добавления.
  /// Используется для контроллеров.
  static const IconData add = IconData(
    0xea0d,
    fontFamily: PackageConfig.fontFamily,
    fontPackage: PackageConfig.packageName,
  );

  /// Стрелка вниз.
  /// Используется в выпадающих списках (dropdown) или для разворачивания контента (аккордеон).
  static const IconData arrowDown = IconData(
    0xea0e,
    fontFamily: PackageConfig.fontFamily,
    fontPackage: PackageConfig.packageName,
  );

  /// Стрелка вправо (шеврон).
  /// Используется для навигации вперед или обозначения кликабельных элементов списка.
  static const IconData arrowRight = IconData(
    0xea0f,
    fontFamily: PackageConfig.fontFamily,
    fontPackage: PackageConfig.packageName,
  );

  /// Стрелка влево (шеврон).
  /// Используется в кнопке "Назад" в навигационной панели.
  static const IconData arrowLeft = IconData(
    0xea10,
    fontFamily: PackageConfig.fontFamily,
    fontPackage: PackageConfig.packageName,
  );

  /// Иконка фильтра (воронка/слайдеры).
  /// Используется для вызова настроек фильтрации и сортировки списков.
  static const IconData filter = IconData(
    0xea11,
    fontFamily: PackageConfig.fontFamily,
    fontPackage: PackageConfig.packageName,
  );

  /// Иконка поиска.
  /// Используется в строке поиска.
  static const IconData search = IconData(
    0xea12,
    fontFamily: PackageConfig.fontFamily,
    fontPackage: PackageConfig.packageName,
  );
}
