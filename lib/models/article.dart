class Article {
  final String title;
  final String description;
  final String publishedAt;
  final String url;
  final String urlToImage;

  Article({
    required this.title,
    required this.description,
    required this.publishedAt,
    required this.url,
    required this.urlToImage,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      publishedAt: json['publishedAt'] ?? '',
      url: json['url'] ?? '',
      urlToImage: json['urlToImage'] ?? '',
    );
  }
}
