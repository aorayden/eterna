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

  String? _selectedGenre;

  final List<SelectItem> _genres = const [
    SelectItem(value: 'painting', text: 'Живопись'),
    SelectItem(value: 'sculpture', text: 'Скульптура'),
    SelectItem(value: 'photo', text: 'Фотография'),
    SelectItem(value: 'graphics', text: 'Графика'),
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _dateStartController.dispose();
    _dateEndController.dispose();
    _coverController.dispose();
    super.dispose();
  }

  bool _isValidDate(String date) {
    final regex = RegExp(r'^\d{2}\.\d{2}\.\d{4}$');
    return regex.hasMatch(date);
  }

  void _handleManualAdd() {
    final title = _titleController.text.trim();
    final dateStart = _dateStartController.text.trim();
    final dateEnd = _dateEndController.text.trim();

    if (title.isEmpty) {
      AppNotification.show(context, message: 'Ошибка: Введите название');
      return;
    }
    if (_selectedGenre == null) {
      AppNotification.show(context, message: 'Ошибка: Выберите жанр');
      return;
    }
    if (dateStart.isNotEmpty && !_isValidDate(dateStart)) {
      AppNotification.show(
        context,
        message: 'Ошибка: Неверный формат даты начала (ДД.ММ.ГГГГ)',
      );
      return;
    }
    if (dateEnd.isNotEmpty && !_isValidDate(dateEnd)) {
      AppNotification.show(
        context,
        message: 'Ошибка: Неверный формат даты окончания',
      );
      return;
    }

    final newArtwork = ArtworkModel(
      title: title,
      description: _descController.text.trim(),
      yearStart: dateStart,
      yearEnd: dateEnd,
      genre: _selectedGenre!,
      imageUrl: _coverController.text.trim().isNotEmpty
          ? _coverController.text.trim()
          : 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a2/Shakespeare.jpg/800px-Shakespeare.jpg',
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

      if (addedCount > 0) {
        if (mounted) {
          AppNotification.show(
            context,
            message: 'Импортировано $addedCount произведений!',
          );
        }
      } else {
        if (mounted) {
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
                hintText: '--.--.----',
                inputFormatter: '##.##.####',
                controller: _dateStartController,
              ),
              const SizedBox(height: verticalGap),

              AppInput(
                labelText: 'Дата окончания создания',
                hintText: '--.--.----',
                inputFormatter: '##.##.####',
                controller: _dateEndController,
              ),
              const SizedBox(height: verticalGap),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  Text(
                    'Жанр',
                    // Используем стиль CaptionRegular (14px), но переопределяем размер до 12px,
                    // как было в исходном коде.
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
                labelText: 'Обложка',
                hintText: 'Введите ссылку',
                controller: _coverController,
              ),

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
