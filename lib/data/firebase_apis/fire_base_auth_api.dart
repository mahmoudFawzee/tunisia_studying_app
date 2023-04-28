import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studying_app/data/models/user.dart';

class FirebaseAuthApi {
  static final   FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  bool get isUser {
    User? user = _auth.currentUser;
    if (user != null) {
      return true;
    }
    return false;
  }

  User? get currentUser {
    User? user = _auth.currentUser;
    if (user != null) {
      return user;
    }
    return null;
  }

 static String get  getCurrentUserEmail =>_auth.currentUser!.email!;

  Future<String> addNewUser(MyUser user) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );
      //add the user information to the cloud firestore
      //inside registration phase .
      await fireStore
          .collection('users')
          .doc(user.email)
          .set(user.toFirestoreObj());

      return 'user created';
    } on FirebaseException catch (e) {
      print(e.code);
      return e.code;
    }
  }

  Future<String?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential signInUser = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final userEmail = signInUser.user!.email;

      //we search for the user doc id once and then saved it in the prefs
      //userID
      //to easy get it fast to save time when we have much users in our firebase
      //firestore.
      DocumentSnapshot<Map<String, dynamic>> userData =
          await fireStore.collection('users').doc(userEmail).get();

      String userId = userData['email'];
      String studyingYear = userData['studyingYear'];

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('userID', userId);
      prefs.setString('studyingYear', studyingYear);

      print('id is ${prefs.getString('userID')}');
      print('studying year is : ${prefs.getString('studyingYear')}');
      return 'user added';
    } on FirebaseException catch (e) {
      print(e.code);
      return e.code;
    }
  }

  Future<String?> signOut() async {
    try {
      await _auth.signOut();
      return 'You Sign Out';
    } on FirebaseException catch (e) {
      print(e.code);
      return e.code;
    }
  }
}
