import 'package:studying_app/data/firebase_apis/firebase_user_data_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studying_app/data/models/lesson.dart';
import 'package:studying_app/data/models/user.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../constants/enums.dart';

class LessonsProvider {
  final _userDataApi = FirebaseUserDataApi();
  final _firestore = FirebaseFirestore.instance;

  Future<List<Lesson>> getMaterialLessons({
    required String materialName,
  }) async {
    List<Lesson> lessonsList = [];
    MyUser user = await _userDataApi.getData();

    QuerySnapshot<Map<String, dynamic>> lessonCollection = await _firestore
        .collection('studying year')
        .doc(user.studyingYear)
        .collection('common material')
        .doc(materialName)
        .collection('lessons')
        .orderBy('order')
        .get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> firebaseLessonsList =
        lessonCollection.docs;
    for (var lesson in firebaseLessonsList) {
      lessonsList.add(Lesson.fromFirebase(firebaseObj: lesson.data()));
    }
    return lessonsList;
  }

 

  Future<String> getLessonVideoId({
    required String materialName,
    required String lessonName,
  }) async {
    MyUser user = await _userDataApi.getData();
    QuerySnapshot<Map<String, dynamic>> lesson = await _firestore
        .collection('studying year')
        .doc(user.studyingYear)
        .collection('common material')
        .doc(materialName)
        .collection('lessons')
        .where('name', isEqualTo: lessonName)
        .limit(1)
        .get();
    return lesson.docs.first.data()['videoId'];
  }

  Future<List<String>> getLessonMaterials({
    required String materialName,
    required String lessonName,
    required LessonProperty lessonProperty,
  }) async {
    //!pdfUrl is the location of the file in the storage.
    //: studyingYear/materialName/
    List<String> itemsName = [];
    String lessonPropertyString = lessonProperties[lessonProperty]!;
    final MyUser userData = await _userDataApi.getData();
    //?this will return the folders in a specific folder or location
    //!for now we reach exercises folders ex1,ex2,ex3,....
    String url =
        '/${userData.studyingYear}/$materialName/lessons/$lessonName/$lessonPropertyString';
    print('url : $url');
    final storageRef = FirebaseStorage.instance.ref(url);
    final ListResult result = await storageRef.listAll();
    if (lessonProperty == LessonProperty.exercises) {
      List<Reference> names = result.prefixes;
      print(names.length);

      for (var index = 0; index < names.length; index++) {
        itemsName.add(names[index].name);
      }
    } else {
      List<Reference> names = result.items;
      print(names.length);

      for (var index = 0; index < names.length; index++) {
        itemsName.add(names[index].name);
      }
    }
    return itemsName;
  }
}
