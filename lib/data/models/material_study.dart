class MaterialStudy {
  final String name;
  final String pdfUrl;
  final List<String> notes;
  final List<String> advices;
  final List<String> lessons;
  const MaterialStudy({
    required this.name,
    required this.pdfUrl,
    required this.notes,
    required this.advices,
    required this.lessons,
  });
  factory MaterialStudy.fromJson(Map<String, dynamic>? jsonObject) {
    //todo: get the data map from the firebase and
    //convert it to the MaterialStudy object.
    final name = jsonObject!['name'];
    final pdfUrl = jsonObject['pdfUrl'];
    final lessons = jsonObject['lessons'];
    final notes = jsonObject['notes'];
    final advices = jsonObject['advices'];
    return MaterialStudy(
      name: name,
      pdfUrl: pdfUrl,
      notes: notes,
      advices: advices,
      lessons: lessons,
    );
  }
}
