class Book {
  final String title;
  final String subtitle;
  final String description;
  final String coverImage;
  final List<String> genres;
  final String publishedDate;
  final String isbn;
  final String pageCount;
  final String language;
  final String publisher;
  final List<String> authors;

  Book({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.coverImage,
    required this.genres,
    required this.publishedDate,
    required this.isbn,
    required this.pageCount,
    required this.language,
    required this.publisher,
    required this.authors,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'] ?? 'Unknown',
      subtitle: json['subtitle'] ?? '-',
      description: json['description'] ?? '-',
      coverImage: json['coverImage'] ?? '',
      genres: List<String>.from(json['genres'] ?? []),
      publishedDate: json['publishedDate'] ?? '-',
      isbn: json['isbn'] ?? '-',
      pageCount: json['pageCount'] ?? '-',
      language: json['language'] ?? '-',
      publisher: json['publisher'] ?? '-',
      authors: List<String>.from(json['authors'] ?? []),
    );
  }
}
  final String image;
  final String birthdate;

  Character({
    required this.fullName,
    required this.nickname,
    required this.hogwartsHouse,
    required this.interpretedBy,
    required this.children,
    required this.image,
    required this.birthdate,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      fullName: json['fullName'] ?? 'Unknown',
      nickname: json['nickname'] ?? '-',
      hogwartsHouse: json['hogwartsHouse'] ?? '-',
      interpretedBy: json['interpretedBy'] ?? '-',
      children: json['children'] ?? [],
      image: json['image'] ?? '',
      birthdate: json['birthdate'] ?? '-',
    );
  }
}