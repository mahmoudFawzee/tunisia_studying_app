part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatState {
  const ChatInitial();
}

class GotMessagesState extends ChatState {
  final List<Message> messages;
  final String currentUser;
  const GotMessagesState({required this.messages, required this.currentUser});
  @override
  List<Object> get props => [messages, currentUser];
}

class GotNoMessagesState extends ChatState {
  final noMessages = StringsManger.noMessages;
  const GotNoMessagesState();
}

class ChatLoadingState extends ChatState {
  const ChatLoadingState();
}

class ChatErrorState extends ChatState {
  final String error;
  const ChatErrorState({required this.error});
  @override
  List<Object> get props => [error];
}

class MessageSentState extends ChatState {
  const MessageSentState();
}

class GotNewMessageState extends ChatState {
  final List<Message> messages;
  final String currentUser;

  const GotNewMessageState({required this.messages,required this.currentUser});
  @override
  List<Object> get props => [messages,currentUser];
}
