class ContentItem {
  final String id;
  final String title;
  final String description;
  final String thumbnail;
  final String bannerImage;
  final String previewVideo;
  final List<String> categories;
  final String? topRank;
  final bool autoplay;
  final int year;
  final String maturity;
  final String duration;
  final String? starring;
  final String? genre;

  ContentItem({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnail,
    required this.bannerImage,
    required this.previewVideo,
    this.starring,
    this.genre,
    this.categories = const [],
    this.topRank,
    this.autoplay = false,
    required this.year,
    this.maturity = 'NR',
    this.duration = '',
  });

  factory ContentItem.fromJson(Map<String, dynamic> json) {
    return ContentItem(
      starring: json['starring'] ?? '',
      genre: json['genre'] ?? '',
      id: json['id'] ?? json['title'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      bannerImage: json['bannerImage'] ?? '',
      previewVideo: json['previewVideo'] ?? '',
      categories: List<String>.from(json['categories'] ?? []),
      topRank: json['topRank'],
      autoplay: json['autoplay'] ?? false,
      year: json['year'] ?? 0,
      maturity: json['maturity'] ?? 'NR',
      duration: json['duration'] ?? '',
    );
  }
}
