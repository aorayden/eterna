import 'dart:convert';
import 'dart:io';

import 'package:data_service/artwork_service.dart';
import 'package:data_service/models/artwork_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/components/button.dart';
import 'package:ui_kit/components/input.dart';
import 'package:ui_kit/components/notification.dart';
import 'package:ui_kit/components/select.dart';
import 'package:ui_kit/models/button_enums.dart';
import 'package:ui_kit/models/select_item.dart';
import 'package:ui_kit/theme/colors.dart';
import 'package:ui_kit/theme/text_styles.dart';

class ImportScreen extends StatefulWidget {
  const ImportScreen({super.key});

  @override
  State<ImportScreen> createState() => _ImportScreenState();
}

class _ImportScreenState extends State<ImportScreen> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _dateStartController = TextEditingController();
  final _dateEndController = TextEditingController();
  final _coverController = TextEditingController();

  final String _defaultCover =
      'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a2/Shakespeare.jpg/800px-Shakespeare.jpg';

  String? _selectedGenre;

  final List<SelectItem> _genres = const [
    SelectItem(value: 'painting', text: 'Живопись'),
    SelectItem(value: 'sculpture', text: 'Скульптура'),
    SelectItem(value: 'photo', text: 'Фотография'),
    SelectItem(value: 'graphics', text: 'Графика'),
  ];

  @override
  void initState() {
    super.initState();
    _coverController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _dateStartController.dispose();
    _dateEndController.dispose();
    _coverController.dispose();
    super.dispose();
  }

  // Проверка формата через Regex (базовая)
  bool _isFormatValid(String date) {
    final regex = RegExp(r'^\d{2}\.\d{2}\.\d{4}$');
    return regex.hasMatch(date);
  }

  // Парсинг строки "ДД.ММ.ГГГГ" в DateTime с проверкой календарной корректности
  DateTime? _parseDate(String dateStr) {
    if (!_isFormatValid(dateStr)) return null;

    try {
      final parts = dateStr.split('.');
      final day = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final year = int.parse(parts[2]);

      final date = DateTime(year, month, day);

      // Dart автоматически переносит дни (например, 32 января станет 1 февраля).
      // Нам это не нужно, мы хотим строгую валидацию.
      if (date.year == year && date.month == month && date.day == day) {
        return date;
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  bool _isValidUrl(String url) {
    return Uri.tryParse(url)?.hasAbsolutePath ?? false;
  }

  void _handleManualAdd() {
    final title = _titleController.text.trim();
    final dateStartStr = _dateStartController.text.trim();
    final dateEndStr = _dateEndController.text.trim();
    final coverUrl = _coverController.text.trim();

    // 1. Проверка обязательных полей
    if (title.isEmpty) {
      AppNotification.show(context, message: 'Ошибка: Введите название');
      return;
    }
    if (_selectedGenre == null) {
      AppNotification.show(context, message: 'Ошибка: Выберите жанр');
      return;
    }

    // 2. Парсинг и проверка дат
    DateTime? startDate;
    DateTime? endDate;

    if (dateStartStr.isNotEmpty) {
      startDate = _parseDate(dateStartStr);
      if (startDate == null) {
        AppNotification.show(
          context,
          message: 'Ошибка: Некорректная дата начала (например, 30.02.2023)',
        );
        return;
      }
    }

    if (dateEndStr.isNotEmpty) {
      endDate = _parseDate(dateEndStr);
      if (endDate == null) {
        AppNotification.show(
          context,
          message: 'Ошибка: Некорректная дата окончания',
        );
        return;
      }
    }

    // 3. Логическое сравнение дат
    if (startDate != null && endDate != null) {
      if (startDate.isAfter(endDate)) {
        AppNotification.show(
          context,
          message: 'Ошибка: Дата начала не может быть позже даты окончания',
        );
        return;
      }
    }

    // 4. Проверка обложки
    if (coverUrl.isNotEmpty && !_isValidUrl(coverUrl)) {
      AppNotification.show(
        context,
        message: 'Ошибка: Некорректная ссылка на изображение',
      );
      return;
    }

    // Сохранение
    final newArtwork = ArtworkModel(
      title: title,
      description: _descController.text.trim(),
      yearStart: dateStartStr,
      yearEnd: dateEndStr,
      genre: _selectedGenre!,
      imageUrl: coverUrl.isNotEmpty ? coverUrl : _defaultCover,
    );

    ArtworkService.instance.addArtwork(newArtwork);

    AppNotification.show(context, message: 'Произведение успешно добавлено!');
    _clearForm();
  }

  Future<void> _handleFileImport() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
      );

      if (result == null) return;

      final file = File(result.files.single.path!);
      final content = await file.readAsString();
      final List<dynamic> jsonList = jsonDecode(content);

      int addedCount = 0;

      for (var item in jsonList) {
        if (item is Map<String, dynamic> &&
            item['title'] != null &&
            item['genre'] != null) {
          await ArtworkService.instance.addArtwork(ArtworkModel.fromJson(item));
          addedCount++;
        }
      }

      if (mounted) {
        if (addedCount > 0) {
          AppNotification.show(
            context,
            message: 'Импортировано $addedCount произведений!',
          );
        } else {
          AppNotification.show(
            context,
            message: 'Файл не содержит корректных данных',
          );
        }
      }
    } catch (e) {
      debugPrint('Error importing file: $e');
      if (mounted) {
        AppNotification.show(context, message: 'Ошибка чтения файла');
      }
    }
  }

  void _clearForm() {
    _titleController.clear();
    _descController.clear();
    _dateStartController.clear();
    _dateEndController.clear();
    _coverController.clear();
    setState(() {
      _selectedGenre = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    const double horizontalPadding = 28.0;
    const double verticalGap = 12.0;
    final String currentCoverUrl = _coverController.text.trim();

    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                'Добавить произведение',
                style: AppTextStyles.firstTitle(
                  color: AppColors.textSecondary,
                  height: 1.17,
                ),
              ),
              const SizedBox(height: 36),
              AppInput(
                labelText: 'Название',
                hintText: 'Введите название',
                controller: _titleController,
              ),
              const SizedBox(height: verticalGap),
              AppInput(
                labelText: 'Описание',
                hintText: 'Введите описание',
                controller: _descController,
              ),
              const SizedBox(height: verticalGap),
              AppInput(
                labelText: 'Дата начала создания',
                hintText: 'ДД.ММ.ГГГГ',
                inputFormatter: '##.##.####',
                keyboardType: TextInputType.number, // Удобно для цифр
                controller: _dateStartController,
              ),
              const SizedBox(height: verticalGap),
              AppInput(
                labelText: 'Дата окончания создания',
                hintText: 'ДД.ММ.ГГГГ',
                inputFormatter: '##.##.####',
                keyboardType: TextInputType.number,
                controller: _dateEndController,
              ),
              const SizedBox(height: verticalGap),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  Text(
                    'Жанр',
                    style: AppTextStyles.captionRegular(
                      color: AppColors.inputLabel,
                    ).copyWith(fontSize: 12),
                  ),
                  AppSelect(
                    hintText: 'Выберите жанр',
                    items: _genres,
                    initialValue: _selectedGenre,
                    onChanged: (value) {
                      setState(() {
                        _selectedGenre = value;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: verticalGap),
              AppInput(
                labelText: 'Ссылка на обложку',
                hintText: 'https://example.com/image.jpg',
                controller: _coverController,
              ),

              // --- Предпросмотр ---
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                child: currentCoverUrl.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            height: 200,
                            width: double.infinity,
                            color: Colors.grey[200],
                            child: Image.network(
                              currentCoverUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.broken_image,
                                        color: Colors.grey,
                                        size: 40,
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Не удалось загрузить',
                                        style: AppTextStyles.captionRegular(
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),

              // -------------------
              const SizedBox(height: 24),
              const Divider(
                color: AppColors.divider,
                thickness: 1.2,
                height: 1,
              ),
              const SizedBox(height: 13),
              Text(
                'Добавить с помощью файла',
                style: AppTextStyles.thirdTitleSemibold(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 16),
              AppButton(
                text: 'Прикрепить файл (.json)',
                kind: AppButtonKind.large,
                variant: AppButtonVariant.outlined,
                onPressed: _handleFileImport,
              ),
              const SizedBox(height: 16),
              AppButton(
                text: 'Импортировать',
                kind: AppButtonKind.large,
                variant: AppButtonVariant.filled,
                onPressed: _handleManualAdd,
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
