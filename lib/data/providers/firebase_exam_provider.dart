import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studying_app/data/firebase_apis/firebase_user_data_api.dart';
import 'package:studying_app/data/models/exam.dart';
import 'package:studying_app/data/models/lesson.dart';
import 'package:studying_app/data/models/user.dart';
import 'package:studying_app/data/providers/advices_and_notes_provider.dart';
import 'package:studying_app/view/resources/strings/strings_manger.dart';

class FirebaseExamProvider {
  final _userDataApi = FirebaseUserDataApi();
  final _advicesAndNotesProvider = AdvicesAndNotesProvider();
  final _firestore = FirebaseFirestore.instance;
  Future<List<Lesson>> getExamLesson({
    required String materialName,
    required List<dynamic> lessonsNamesList,
  }) async {
    List<Lesson> myLessons = [];
    MyUser user = await _userDataApi.getData();
    QuerySnapshot<Map<String, dynamic>> examLessons = await _firestore
        .collection(FirebaseCollectionsStrings.studyingYear)
        .doc(user.studyingYear)
        .collection(FirebaseCollectionsStrings.materials)
        .doc(materialName)
        .collection(FirebaseCollectionsStrings.lessons)
        .where('name', whereIn: lessonsNamesList)
        .get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> firebaseLessons =
        examLessons.docs;
    print('firebase exam lessons : ${firebaseLessons.length}');
    for (var lesson in firebaseLessons) {
      myLessons.add(
        Lesson.fromFirebase(
          firebaseObj: lesson.data(),
        ),
      );
    }
    return myLessons;
  }

  Future<Map<String, dynamic>> getExamHomeworkMap({
    //required String materialName,
    required String examName,
  }) async {
    MyUser user = await _userDataApi.getData();
    QuerySnapshot<Map<String, dynamic>> firebaseExam = await _firestore
        .collection(FirebaseCollectionsStrings.users)
        .doc(user.email)
        .collection(FirebaseCollectionsStrings.exams)
        .where('name', isEqualTo: examName)
        .limit(1)
        .get();
    Map<String, dynamic> exam = firebaseExam.docs.first.data();
    Exam myExam = Exam.formFirebase(firebaseExam: exam);
    
    return Map<String, dynamic>.from(myExam.examConnectedHomework);
  }

  static T? cast<T>(x) => x is T ? x : null;

  Future<List<dynamic>> getExamNotes({required String materialName}) async {
    return await _advicesAndNotesProvider.getStudyingAdvices(
        materialName: materialName);
  }
}
