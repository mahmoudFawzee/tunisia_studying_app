import 'package:cloud_firestore/cloud_firestore.dart';

class Exam {
  final String examName;
  final String materialName;
  final DateTime examDate;
  final List<dynamic> lessons;
  final Map<String, dynamic> examConnectedHomework;
  const Exam({
    required this.examDate,
    required this.examName,
    required this.lessons,
    required this.materialName,
    required this.examConnectedHomework,
  });

  Map<String, Object?> toFirestoreObj() {
    return {
      'name': examName,
      'date': examDate,
      'materialName': materialName,
      'lessons': lessons,
      'homework': examConnectedHomework,
    };
  }

  factory Exam.formFirebase({
    required Map<String, dynamic> firebaseExam,
  }) {
    final name = firebaseExam['name'];
    Timestamp timestamp = firebaseExam['date'];
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp.seconds * 1000);
    //print(date);
    final materialName = firebaseExam['materialName'];
    //print(materialName);
    final lessons = firebaseExam['lessons'];
    //print(lessons);
    final connectedHomework = Map<String,dynamic>.from(firebaseExam['homework']);
    print(connectedHomework);
    return Exam(
      examDate: date,
      examName: name,
      lessons: lessons,
      materialName: materialName,
      examConnectedHomework: connectedHomework,
    );
  }

  @override
  String toString() {
    // TODO: implement toString
    return ' exam date is :$examDate \n name : $examName \n  name : $examName';
  }

  String formatDate() {
    if (examDate.hour > 12) {
      int hour = examDate.hour - 12;
      return 'يوم ${examDate.month}/${examDate.day} - $hour:${examDate.minute}';
    }
    return 'يوم ${examDate.month}/${examDate.day} - ${examDate.hour}:${examDate.minute}';
  }
}
