class News {
  final String title;
  final String content;
  final String imageUrl;
  const News({
    required this.title,
    required this.content,
    required this.imageUrl,
  });

  factory News.fromFirebase(
      Map<String, dynamic> oneNew) {
    final String title = oneNew['title'];
    final String content = oneNew['content'];
    final String imageUrl = oneNew['imageUrl'];
    return News(
      title: title,
      content: content,
      imageUrl: imageUrl,
    );
  }
}
