import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studying_app/data/constants/firebase_keys.dart';
import 'package:studying_app/data/models/Message.dart';
import 'package:studying_app/view/resources/strings/strings_manger.dart';

class FirebaseChatApi {
  final _firestore = FirebaseFirestore.instance;
  Future<List<Message>> loadChat({required String studyingYear}) async {
    List<Message> allMessages = [];
    QuerySnapshot<Map<String, dynamic>> firebaseMessages = await _firestore
        .collection(FirebaseCollectionsStrings.chats)
        .doc(studyingYear)
        .collection(FirebaseCollectionsStrings.chat)
        .orderBy(FirebaseKeys.time)
        //todo : here we need to sort the messages based on the time of sending.
        .get();
    Iterable<QueryDocumentSnapshot<Map<String, dynamic>>> messagesList =
        firebaseMessages.docs.reversed;
    for (var message in messagesList) {
      allMessages.add(
        Message.fromFirebase(
          firebaseObj: message.data(),
        ),
      );
    }
    return allMessages;
  }

  Future<bool> sendMessage(
      {required Message message, required String studyingYear}) async {
    Map<String, FieldValue> messageTime = {
      'time': FieldValue.serverTimestamp()
    };
    DocumentReference<Map<String, dynamic>> result = await _firestore
        .collection(FirebaseCollectionsStrings.chats)
        .doc(studyingYear)
        .collection(FirebaseCollectionsStrings.chat)
        .add({...message.toFirebase(message: message), ...messageTime});
    await result.get().then((value) => print(value.data()));
    if (result.id.isNotEmpty) return true;
    return false;
  }

//?stream of messages we will listen to.
  Stream<QuerySnapshot<Map<String, dynamic>>> getNewMessagesStream({
    required String studyingYear,
  }) {
    return _firestore
        .collection(FirebaseCollectionsStrings.chats)
        .doc(studyingYear)
        .collection(FirebaseCollectionsStrings.chat)
        .orderBy(FirebaseKeys.time,)
        .snapshots();
  }
}
