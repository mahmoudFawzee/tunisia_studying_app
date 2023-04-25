import 'package:studying_app/data/firebase_apis/firebase_user_data_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studying_app/data/models/user.dart';

class AdvicesAndNotesProvider {
  final _firebaseUserDataApi = FirebaseUserDataApi();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<List<dynamic>> getStudyingAdvices({
    required String materialName,
  }) async {
    MyUser studyingYear = await _firebaseUserDataApi.getData();
    List<dynamic> advices = [];
    DocumentSnapshot<Map<String, dynamic>> firebaseAdvices = await _firestore
        .collection('studying year')
        .doc(studyingYear.studyingYear)
        .collection('common material')
        .doc(materialName)
        .get();
    Map<String, dynamic>? allFirebaseAdvices = firebaseAdvices.data();
    advices = allFirebaseAdvices!['advices'];
    return advices;
  }

  Future<List<dynamic>> getMaterialNotes({
    required String materialName,
  }) async {
    MyUser studyingYear = await _firebaseUserDataApi.getData();
    List<dynamic> notes = [];
    DocumentSnapshot<Map<String, dynamic>> firebaseNotes = await _firestore
        .collection('studying year')
        .doc(studyingYear.studyingYear)
        .collection('common material')
        .doc(materialName)
        .get();
    Map<String, dynamic>? allFirebaseAdvices = firebaseNotes.data();
    notes = allFirebaseAdvices!['notes'];
    return notes;
  }
}
