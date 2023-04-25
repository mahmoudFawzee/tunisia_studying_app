import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studying_app/data/firebase_apis/firebase_user_data_api.dart';
import 'package:studying_app/data/models/question.dart';
import 'package:studying_app/data/models/user.dart';

class QuizApi {
  final firestore = FirebaseFirestore.instance;
  final FirebaseUserDataApi firebaseUserDataApi = FirebaseUserDataApi();
  Future<List<Question>> getQuiz({
    required String materialName,
    required String lessonName,
  }) async {
    List<Question> questionsList = [];
    final MyUser userData = await firebaseUserDataApi.getData();
    QuerySnapshot<Map<String, dynamic>> firebaseQuiz;
    firebaseQuiz = await firestore
        .collection('studying year')
        .doc(userData.studyingYear)
        .collection('common material')
        .doc(materialName)
        .collection('lessons')
        .doc(lessonName)
        .collection('quiz')
        .get();

    List<QueryDocumentSnapshot<Map<String, dynamic>>> firebaseQuestions =
        firebaseQuiz.docs;
    for (var question in firebaseQuestions) {
      questionsList.add(Question.fromFirebase(question.data()));
    }
    return questionsList;
  }
}
