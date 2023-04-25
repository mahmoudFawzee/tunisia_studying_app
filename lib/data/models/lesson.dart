class Lesson {
  final String name;
  final int order;
  final String vidUrl;
  const Lesson({
    required this.name,
    required this.order,
    required this.vidUrl,
  });

  factory Lesson.fromFirebase({required Map<String, dynamic> firebaseObj}) {
    final name = firebaseObj['name'];
    final order = firebaseObj['order'];
    final vidUrl = firebaseObj['videoId'];

    return Lesson(
      name: name,
      order: order,
      vidUrl: vidUrl,
    );
  }
}
