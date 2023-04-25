import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studying_app/data/firebase_apis/fire_base_auth_api.dart';
import 'package:studying_app/data/models/exam.dart';
import 'package:studying_app/data/models/subscription_request.dart';
import 'package:studying_app/data/models/user.dart';
import 'package:studying_app/view/resources/strings/strings_manger.dart';

class FirebaseUserDataApi {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuthApi _firebaseAuthApi = FirebaseAuthApi();

  Future<MyUser> getData() async {
    //!another way to get the user data
    //here we get the user data directly with the user document to save time
    //we get the user document from the shared prefs field userID which
    //its value saved in the log in phase once user log in the id will saved
    //also and we will get it again and again.
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('userID')!;
    DocumentSnapshot<Map<String, dynamic>> idData =
        await _firestore.collection('users').doc(userId).get();
    Map<String, dynamic>? userWithID = idData.data();

    MyUser myUser = MyUser.fromFirebase(
      userWithID!,
    );
    return myUser;
  }

  Future<bool> sendSubscriptionRequest(
    SubscriptionRequest subscriptionRequest,
  ) async {
    try {
      String userEmail = _firebaseAuthApi.currentUser!.email!;
      //todo in the subscription request collection check if the email request already exist
      //or not
      //todo : store the collection instance in a variable
      DocumentSnapshot<Map<String, dynamic>> subscriptionDocument =
          await _firestore
              .collection('subscription requests')
              .doc(userEmail)
              .get();
      //todo : if the collection has a request with the user email don't add new one
      //! if not add new one

      if (!subscriptionDocument.exists) {
        await _firestore.collection('subscription requests').doc(userEmail).set(
              subscriptionRequest.toFirebaseObject(),
            );
      }
      return true;
    } on FirebaseException catch (e) {
      print(e.code);
      return false;
    } on Exception {
      return false;
    }
  }

  Future<bool> getAllowAccess() async {
    try {
      String userEmail = _firebaseAuthApi.currentUser!.email!;
      print(userEmail);

      bool isRequestExist = await isRequestExists();

      if (isRequestExist) {
        DocumentSnapshot<Map<String, dynamic>> firebaseRequest =
            await _firestore
                .collection('subscription requests')
                .doc(userEmail)
                .get();
        SubscriptionRequest subscriptionRequest =
            SubscriptionRequest.fromFirebase(firebaseRequest.data());
        return subscriptionRequest.allowAccess;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> isRequestExists() async {
    String userEmail = _firebaseAuthApi.currentUser!.email!;
    DocumentSnapshot<Map<String, dynamic>> firebaseRequest = await _firestore
        .collection('subscription requests')
        .doc(userEmail)
        .get();
    if (firebaseRequest.exists) {
      return true;
    }
    return false;
  }

  Future<List<Exam>> getUserExams({required String userEmail}) async {
    List<Exam> userExams = [];
    print(userEmail);
    QuerySnapshot<Map<String, dynamic>> firebaseExams = await _firestore
        .collection(FirebaseCollectionsStrings.users)
        .doc(userEmail)
        .collection(FirebaseCollectionsStrings.exams)
        .get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> exams =
        firebaseExams.docs;
    print('n of exams : ${exams.length}');
    for (var exam in exams) {
      userExams.add(Exam.formFirebase(firebaseExam: exam.data()));
    }
    print('first exam : ${userExams.first.toString()}');
    return userExams;
  }

  Future deleteExam({
    required examName,
    required String userEmail,
  }) async {
    QuerySnapshot<Map<String, dynamic>> exam = await _firestore
        .collection(FirebaseCollectionsStrings.users)
        .doc(userEmail)
        .collection(FirebaseCollectionsStrings.exams)
        .where('name', isEqualTo: examName)
        .limit(1)
        .get();

    String examId = exam.docs.first.id;
    await _firestore
        .collection(FirebaseCollectionsStrings.users)
        .doc(userEmail)
        .collection(FirebaseCollectionsStrings.exams)
        .doc(examId)
        .delete();
  }

  Future<List<Exam>> addExam({
    required String userEmail,
    required Exam exam,
  }) async {
    await _firestore.collection('users').doc(userEmail).collection('exams').add(
          exam.toFirestoreObj(),
        );

    return getUserExams(userEmail: userEmail);
  }
}
