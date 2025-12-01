import 'dart:convert';
import 'dart:io';

import 'package:data_service/artwork_service.dart';
import 'package:data_service/models/artwork_model.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:ui_kit/components/button.dart';
import 'package:ui_kit/components/input.dart';
import 'package:ui_kit/components/notification.dart';
import 'package:ui_kit/components/select.dart';
import 'package:ui_kit/models/button_enums.dart';
import 'package:ui_kit/models/select_item.dart';
import 'package:ui_kit/theme/colors.dart';
import 'package:ui_kit/theme/text_styles.dart';

class ExportScreen extends StatefulWidget {
  const ExportScreen({super.key});

  @override
  State<ExportScreen> createState() => _ExportScreenState();
}

class _ExportScreenState extends State<ExportScreen> {
  final TextEditingController _dateStartController = TextEditingController();
  final TextEditingController _dateEndController = TextEditingController();

  String? _selectedGenre = 'all';

  final List<SelectItem> _genres = const [
    SelectItem(value: 'all', text: 'Все'),
    SelectItem(value: 'painting', text: 'Живопись'),
    SelectItem(value: 'sculpture', text: 'Скульптура'),
    SelectItem(value: 'photo', text: 'Фотография'),
    SelectItem(value: 'graphics', text: 'Графика'),
  ];

  @override
  void dispose() {
    _dateStartController.dispose();
    _dateEndController.dispose();
    super.dispose();
  }

  DateTime? _parseDate(String dateStr) {
    try {
      if (dateStr.isEmpty) return null;
      final parts = dateStr.split('.');
      if (parts.length != 3) return null;
      return DateTime(
        int.parse(parts[2]),
        int.parse(parts[1]),
        int.parse(parts[0]),
      );
    } catch (e) {
      return null;
    }
  }

  Future<void> _handleExport({required bool exportAll}) async {
    final allArtworks = ArtworkService.instance.artworksNotifier.value;

    if (allArtworks.isEmpty) {
      AppNotification.show(context, message: 'Нет данных для экспорта');
      return;
    }

    List<ArtworkModel> filteredList = [];

    if (exportAll) {
      filteredList = List.from(allArtworks);
    } else {
      final DateTime? filterStart = _parseDate(_dateStartController.text);
      final DateTime? filterEnd = _parseDate(_dateEndController.text);
      final String genreFilter = _selectedGenre ?? 'all';

      filteredList = allArtworks.where((item) {
        if (genreFilter != 'all' && item.genre != genreFilter) {
          return false;
        }

        final itemDate = _parseDate(item.yearStart);
        if (itemDate != null) {
          if (filterStart != null && itemDate.isBefore(filterStart)) {
            return false;
          }
          if (filterEnd != null && itemDate.isAfter(filterEnd)) return false;
        }

        return true;
      }).toList();
    }

    if (filteredList.isEmpty) {
      AppNotification.show(context, message: 'Ничего не найдено по фильтрам');
      return;
    }

    try {
      const JsonEncoder encoder = JsonEncoder.withIndent('  ');
      final String jsonString = encoder.convert(
        filteredList.map((e) => e.toJson()).toList(),
      );

      final tempDir = await getTemporaryDirectory();
      final String fileName = exportAll
          ? 'full_export.json'
          : 'filtered_export.json';
      final File file = File('${tempDir.path}/$fileName');

      await file.writeAsString(jsonString);

      if (!mounted) return;

      final result = await Share.shareXFiles(
        [XFile(file.path)],
        text: 'Экспорт произведений из приложения Eterna',
        subject: 'Экспорт базы данных', // Тема письма (для email)
      );

      if (result.status == ShareResultStatus.success) {
        AppNotification.show(context, message: 'Файл успешно отправлен!');
      }
    } catch (e) {
      debugPrint('Error exporting: $e');
      if (mounted) {
        AppNotification.show(context, message: 'Ошибка при экспорте');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const double horizontalPadding = 28.0;
    const double verticalGap = 16.0;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              Text(
                'Выгрузить произведения',
                style: AppTextStyles.firstTitle(
                  color: AppColors.textSecondary,
                  height: 1.17,
                  letterSpacing: 0.08,
                ),
              ),

              const SizedBox(height: 36),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  Text(
                    'Жанр',
                    style: AppTextStyles.captionRegular(
                      color: AppColors.inputLabel,
                    ),
                  ),
                  AppSelect(
                    hintText: 'Выберите жанр',
                    items: _genres,
                    initialValue: _selectedGenre,
                    onChanged: (value) =>
                        setState(() => _selectedGenre = value),
                  ),
                ],
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

              const SizedBox(height: 36),

              const Divider(
                color: AppColors.divider,
                thickness: 1.2,
                height: 1,
              ),
              const SizedBox(height: 13),

              Text(
                'Моментальный экспорт',
                style: AppTextStyles.thirdTitleSemibold(
                  color: AppColors.textSecondary,
                  height: 1.41,
                ),
              ),

              const SizedBox(height: 16),

              AppButton(
                text: 'Экспортировать всё',
                kind: AppButtonKind.large,
                variant: AppButtonVariant.outlined,
                onPressed: () => _handleExport(exportAll: true),
              ),

              const SizedBox(height: 16),

              AppButton(
                text: 'Экспортировать',
                kind: AppButtonKind.large,
                variant: AppButtonVariant.filled,
                onPressed: () => _handleExport(exportAll: false),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
