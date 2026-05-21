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
      pageCount: json['pageCount']?.toString() ?? '-',
      language: json['language'] ?? '-',
      publisher: json['publisher'] ?? '-',
      authors: List<String>.from(json['authors'] ?? []),
    );
  }
}
