class NewsArticle {
  final String title;
  final String url;
  final String description;
  final String? imageUrl;
  final String source;
  final DateTime publishedAt;

  NewsArticle({
    required this.title,
    required this.description,
    required this.url,
    this.imageUrl,
    required this.source,
    required this.publishedAt,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    // Ensure description is never null
    final String description = json['description'] ?? '';

    return NewsArticle(
      title: json['title'] ?? '',
      description: description, // Description is now guaranteed to be a String
      url: json['url'] ?? '',
      imageUrl: json['urlToImage'],
      source: json['source']?['name'] ?? '',
      publishedAt: DateTime.parse(json['publishedAt']),
    );
  }
}
