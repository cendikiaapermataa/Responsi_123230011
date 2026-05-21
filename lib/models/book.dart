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
    // Helper to try multiple keys and nested structures
    String _firstString(Map m, List<String> keys) {
      for (final k in keys) {
        if (m.containsKey(k) && m[k] != null) return m[k].toString();
      }
      return '';
    }

    // Extract cover from several possible shapes
    String cover = '';
    final dynamic coverCandidate =
        json['coverImage'] ??
        json['cover'] ??
        json['image'] ??
        json['thumbnail'] ??
        json['cover_url'] ??
        json['image_url'];
    if (coverCandidate != null) {
      if (coverCandidate is String) {
        cover = coverCandidate;
      } else if (coverCandidate is Map) {
        try {
          cover = _firstString(Map<String, dynamic>.from(coverCandidate), [
            'url',
            'small',
            'thumb',
            'href',
          ]);
        } catch (_) {
          cover = '';
        }
      } else {
        cover = coverCandidate.toString();
      }
    }
    if (cover.startsWith('//')) cover = 'https:$cover';

    // Authors (handle list of strings or list of maps)
    List<String> authors = [];
    if (json['authors'] is List) {
      try {
        authors = (json['authors'] as List)
            .map((e) {
              if (e == null) return '';
              if (e is String) return e;
              if (e is Map) {
                return (e['name'] ??
                        e['fullName'] ??
                        e['full_name'] ??
                        e['author'] ??
                        e['title'] ??
                        '')
                    .toString();
              }
              return e.toString();
            })
            .where((s) => s.isNotEmpty)
            .toList();
      } catch (_) {
        authors = [];
      }
    } else if (json['author'] != null) {
      authors = [json['author'].toString()];
    } else if (json['writer'] != null) {
      authors = [json['writer'].toString()];
    }

    // title/description/publisher/page/isbn/published date variations
    final title = _firstString(json, ['title', 'name']);
    final subtitle = _firstString(json, ['subtitle', 'tagline']);
    final description = _firstString(json, [
      'description',
      'summary',
      'overview',
      'about',
    ]);
    String publishedDate = _firstString(json, [
      'publishedDate',
      'published',
      'released',
      'releaseDate',
      'date',
      'published_date',
    ]);
    String isbn = _firstString(json, ['isbn', 'id', 'isbn10', 'isbn13']);
    if (isbn.isEmpty &&
        json.containsKey('identifiers') &&
        json['identifiers'] is Map) {
      isbn = _firstString(Map<String, dynamic>.from(json['identifiers']), [
        'isbn_10',
        'isbn_13',
        'isbn',
      ]);
    }
    String pageCount = _firstString(json, ['pageCount', 'pages', 'page_count']);
    String publisher = '';
    if (json['publisher'] is List) {
      try {
        publisher = (json['publisher'] as List)
            .map((e) => e.toString())
            .join(', ');
      } catch (_) {
        publisher = '';
      }
    } else {
      publisher = _firstString(json, ['publisher', 'publishers']);
    }

    if (publishedDate.isEmpty) {
      if (json['published'] is Map) {
        try {
          publishedDate = _firstString(
            Map<String, dynamic>.from(json['published']),
            ['date', 'year'],
          );
        } catch (_) {
          // ignore
        }
      }
    }

    return Book(
      title: title.isNotEmpty ? title : 'Unknown',
      subtitle: subtitle.isNotEmpty ? subtitle : '-',
      description: description.isNotEmpty ? description : '-',
      coverImage: cover,
      genres: (json['genres'] is List)
          ? List<String>.from((json['genres'] as List).map((e) => e.toString()))
          : [],
      publishedDate: publishedDate.isNotEmpty ? publishedDate : '-',
      isbn: isbn.isNotEmpty ? isbn : '-',
      pageCount: pageCount.isNotEmpty ? pageCount : '-',
      language: _firstString(json, ['language', 'lang']),
      publisher: publisher.isNotEmpty ? publisher : '-',
      authors: authors,
    );
  }
}
