class ArtworkModel {
  final String title;
  final String description;
  final String yearStart;
  final String yearEnd;
  final String genre;
  final String imageUrl;

  ArtworkModel({
    required this.title,
    required this.description,
    required this.yearStart,
    required this.yearEnd,
    required this.genre,
    this.imageUrl =
        'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0f/1665_Girl_with_a_Pearl_Earring.jpg/800px-1665_Girl_with_a_Pearl_Earring.jpg',
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'yearStart': yearStart,
      'yearEnd': yearEnd,
      'genre': genre,
      'imageUrl': imageUrl,
    };
  }

  factory ArtworkModel.fromJson(Map<String, dynamic> json) {
    return ArtworkModel(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      yearStart: json['yearStart'] ?? '',
      yearEnd: json['yearEnd'] ?? '',
      genre: json['genre'] ?? '',
      imageUrl: json['imageUrl'] ?? 'https://via.placeholder.com/150',
    );
  }
}
