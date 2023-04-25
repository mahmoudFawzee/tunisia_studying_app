import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studying_app/data/firebase_apis/firebase_user_data_api.dart';
import 'package:studying_app/data/models/material_study.dart';
import 'package:studying_app/data/models/lesson.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:studying_app/data/models/user.dart';

class FirebaseMaterialsApi {
  final FirebaseFirestore _cloudFirestore = FirebaseFirestore.instance;
  final firebaseUserDataApi = FirebaseUserDataApi();

  Future<List<String>> getAllMaterials({
    required String studyingYear,
     String? branch,
  }) async {
    QuerySnapshot<Map<String, dynamic>> commonMaterials = await _cloudFirestore
        .collection('studying year')
        .doc(studyingYear)
        .collection('common material')
        .where(
          'branch',
          arrayContains: branch,
        )
        .get();
    print('branch : $branch');
    List<QueryDocumentSnapshot<Map<String, dynamic>>> data =
        commonMaterials.docs;
    List<String> materialsName = [];
    for (var element in data) {
      materialsName.add(
        element['name'],
      );
    }
    print('materialsName $materialsName');
    return materialsName;
  }

  Future<MaterialStudy> getAMaterial({
    required String materialName,
    required String studyingYear,
  }) async {
    DocumentSnapshot<Map<String, dynamic>> material = await _cloudFirestore
        .collection('studying year')
        .doc(studyingYear)
        .collection('common materials')
        .doc(materialName)
        .get();
    return MaterialStudy.fromJson(material.data());
  }

  Future<List<String>> getMaterialBooks({
    required String materialName,
  }) async {
    //!pdfUrl is the location of the file in the storage.
    //: studyingYear/materialName/
    List<String> pdfsNames = [];
    final MyUser userData = await firebaseUserDataApi.getData();
    String pdfUrl = '/${userData.studyingYear}/$materialName';
    final storageRef = FirebaseStorage.instance.ref(pdfUrl);
    final ListResult result = await storageRef.listAll();
    List<Reference> names = result.items;
    for (var pdf in names) {
      pdfsNames.add(pdf.name);
    }
    return pdfsNames;
  }

  Future<List<Lesson>> getMaterialLessons({
    required String materialName,
    required String studyingYear,
  }) async {
    List<Lesson> myLessons = [];
    QuerySnapshot<Map<String, dynamic>> lessons = await _cloudFirestore
        .collection('studying year')
        .doc(studyingYear)
        .collection('common materials')
        .doc(materialName)
        .collection('lessons')
        .get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> firebaseLessons =
        lessons.docs;

    for (var element in firebaseLessons) {
      myLessons.add(Lesson.fromFirebase(firebaseObj: element.data()));
    }
    return myLessons;
  }

  // Future<List<String>> getLessonVideo({
  //   required String materialName,
  //   required String studyingYear,
  //   required String lessonName,
  // }) async {
  //   DocumentSnapshot<Map<String, dynamic>> lesson = await _cloudFirestore
  //       .collection('studying year')
  //       .doc(studyingYear)
  //       .collection('common materials')
  //       .doc(materialName)
  //       .collection('lessons')
  //       .doc(lessonName)
  //       .get();
  //   var video = lesson.data();
  //   return video!['videoUrl'];
  // }

  Future<List<String>> getMaterialHomework({
    required String materialName,
    required String homeworkName,
    required String homeworkSectionName,
  }) async {
    List<String> names = [];
    final MyUser userData = await firebaseUserDataApi.getData();
    Reference ref = FirebaseStorage.instance.ref().child(
          '${userData.studyingYear}/$materialName/homework/$homeworkName/$homeworkSectionName',
        );
    ListResult examsNames = await ref.listAll();
    //?here we used items instead of prefixes because we want to get the files not folders
    List<Reference> folders = examsNames.items;
    for (var folder in folders) {
      names.add(folder.name);
    }
    return names;
  }
}
