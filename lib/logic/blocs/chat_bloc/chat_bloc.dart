// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:studying_app/data/firebase_apis/fire_base_auth_api.dart';
import 'package:studying_app/data/firebase_apis/firebase_chat_api.dart';
import 'package:studying_app/data/firebase_apis/firebase_user_data_api.dart';
import 'package:studying_app/data/models/Message.dart';
import 'package:studying_app/view/resources/strings/strings_manger.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final _firebaseChatApi = FirebaseChatApi();
  final _firebaseUserDataApi = FirebaseUserDataApi();
  final _authApi = FirebaseAuthApi();
  late StreamSubscription streamSubscription;
  List<Message> messages = [];

//?stream of messages we will listen to.
  void getNewMessagesStream() async {
    if (_authApi.isUser) {
      var user = await _firebaseUserDataApi.getData();
      streamSubscription = _firebaseChatApi
          .getNewMessagesStream(studyingYear: user.studyingYear)
          .listen((snapshot) {
        messages.clear();
        for (var message in snapshot.docs.reversed) {
          messages.add(Message.fromFirebase(firebaseObj: message.data()));
        }
        emit(const ChatInitial());
        emit(
          GotNewMessageState(
            messages: messages,
            currentUser: FirebaseAuthApi.getCurrentUserEmail,
          ),
        );
      });
    }
  }

  ChatBloc() : super(const ChatInitial()) {
    getNewMessagesStream();
    on<SendMessageEvent>((event, emit) async {
      try {
        final currentUser = FirebaseAuthApi.getCurrentUserEmail;
        final user = await _firebaseUserDataApi.getData();
        final message = Message(
          messageText: event.messageText,
          senderEmail: FirebaseAuthApi.getCurrentUserEmail,
        );
        bool sent = await _firebaseChatApi.sendMessage(
          message: message,
          studyingYear: user.studyingYear,
        );
        if (sent) {
          //emit(const MessageSentState());
        } else {
          emit(const ChatErrorState(error: StringsManger.someErrorOcurred));
        }
      } on FirebaseException catch (e) {
        print(e.code);
        emit(ChatErrorState(error: e.code));
      } catch (e) {
        print(e.toString());
        emit(ChatErrorState(error: e.toString()));
      }
    });
    on<LoadChatMessages>((event, emit) async {
      var user = await _firebaseUserDataApi.getData();
      List<Message> messages =
          await _firebaseChatApi.loadChat(studyingYear: user.studyingYear);
      this.messages = messages;
      if (this.messages.isEmpty) {
        emit(const GotNoMessagesState());
      } else {
        emit(GotNewMessageState(
          messages: this.messages,
          currentUser: FirebaseAuthApi.getCurrentUserEmail,
        ));
      }
    });
  }
  @override
  Future<void> close() {
    streamSubscription.cancel();
    return super.close();
  }
}
