import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studying_app/data/models/Message.dart';
import 'package:studying_app/logic/blocs/chat_bloc/chat_bloc.dart';
import 'package:studying_app/view/theme/app_colors.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});
  final textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return BlocProvider.value(
      value: BlocProvider.of<ChatBloc>(context),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: height * .83,
              child: BlocBuilder<ChatBloc, ChatState>(
                builder: (context, state) {
                  print(state);
                  if (state is GotMessagesState) {
                    return messagesListView(
                      messages: state.messages,
                      currentUser: state.currentUser,
                    );
                  } else if (state is GotNewMessageState) {
                    return messagesListView(
                      messages: state.messages,
                      currentUser: state.currentUser,
                    );
                  } else if (state is GotNoMessagesState) {
                    return Center(
                      child: Text(state.noMessages),
                    );
                  } else if (state is ChatLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.buttonsLightColor,
                      ),
                    );
                  } else if (state is ChatErrorState) {
                    return Center(
                      child: Text(state.error),
                    );
                  }
                  return Container();
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  flex: 4,
                  child: TextField(
                    controller: textFieldController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: IconButton(
                      onPressed: () {
                        if (textFieldController.value.text.isNotEmpty) {
                          context.read<ChatBloc>().add(
                                SendMessageEvent(
                                  messageText: textFieldController.value.text,
                                ),
                              );
                          textFieldController.clear();
                        }
                      },
                      icon: const Icon(
                        Icons.send,
                        color: AppColors.buttonsLightColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  ListView messagesListView(
      {required List<Message> messages, required String currentUser}) {
    return ListView.builder(
      reverse: true,
      itemCount: messages.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final message = messages[index];
        bool isAppUser = message.senderEmail == currentUser;
        return Align(
          alignment: isAppUser ? Alignment.centerRight : Alignment.centerLeft,
          child: Card(
            elevation: 0,
            color: Colors.white.withOpacity(0),
            margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: Column(
              crossAxisAlignment:
                  isAppUser ? CrossAxisAlignment.start : CrossAxisAlignment.end,
              children: [
                Text(messages[index].senderEmail),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(20),
                      topRight: const Radius.circular(20),
                      bottomLeft: isAppUser
                          ? const Radius.circular(20)
                          : const Radius.circular(0),
                      bottomRight: isAppUser
                          ? const Radius.circular(0)
                          : const Radius.circular(20),
                    ),
                    color: AppColors.buttonsLightColor,
                  ),
                  child: Text(
                    message.messageText,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
