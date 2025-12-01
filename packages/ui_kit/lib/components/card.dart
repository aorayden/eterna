import 'package:flutter/material.dart';

class Card extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;
  final VoidCallback? onTap;

  const Card({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity, // Или фиксированная ширина, например 300
        height: 180, // Высота карточки как на макете
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), // Сильное скругление углов
          image: DecorationImage(
            image: NetworkImage(imageUrl), // Или AssetImage для локальных фото
            fit: BoxFit.cover, // Картинка заполняет весь контейнер
          ),
        ),
        // ClipRRect нужен, если мы хотим добавить эффект нажатия (InkWell) поверх,
        // но здесь мы просто используем Container.
        // Чтобы текст читался, добавим градиент поверх картинки.
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(
                  0.1,
                ), // Сверху чуть темнее (или прозрачно)
                Colors.black.withOpacity(
                  0.6,
                ), // Снизу темнее для читаемости текста
              ],
              stops: const [0.4, 1.0], // Градиент начинается с середины
            ),
          ),
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.end, // Текст прижат к низу, но...
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // На макете текст распределен: заголовок выше, дата ниже.
              // Используем Spacer или MainAxisAlignment.spaceBetween, если нужно разнести их.
              // Но на фото они выглядят как единый блок внизу-слева.
              // Если текст по центру слева, то меняем MainAxisAlignment.
              const Spacer(), // Толкает контент вниз, если нужно

              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  height: 1.2, // Межстрочный интервал
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 8), // Отступ между заголовком и датой

              Text(
                subtitle,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold, // На макете год тоже жирный
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
