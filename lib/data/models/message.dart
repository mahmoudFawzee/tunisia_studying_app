// ignore_for_file: file_names

import 'package:studying_app/data/constants/firebase_keys.dart';

class Message {
  final String messageText;
  final String senderEmail;
  const Message({
    required this.messageText,
    required this.senderEmail,
  });

  factory Message.fromFirebase({required Map<String, dynamic> firebaseObj}) {
    final messageText = firebaseObj[FirebaseKeys.messageText];
    final senderEmail = firebaseObj[FirebaseKeys.senderEmail];
    return Message(
      messageText: messageText!,
      senderEmail: senderEmail!,
    );
  }

  Map<String, String> toFirebase({required Message message}) {
    return {
      FirebaseKeys.messageText:message.messageText,
      FirebaseKeys.senderEmail : message.senderEmail,
    };
  }
}
