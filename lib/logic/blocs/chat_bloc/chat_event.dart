part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class LoadChatMessages extends ChatEvent {
  const LoadChatMessages();
}

class GetNewMessageEvent extends ChatEvent {
  const GetNewMessageEvent();
}

class SendMessageEvent extends ChatEvent {
  final String messageText;
  const SendMessageEvent({
    required this.messageText,
  });
  @override
  List<Object> get props => [
        messageText,
      ];
}
