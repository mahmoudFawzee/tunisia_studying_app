import 'package:flutter/material.dart';
import 'package:studying_app/data/providers/chatgpt_api.dart';
import 'package:studying_app/view/theme/app_colors.dart';
import 'package:studying_app/view/widgets/app_background_container.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _chatService = ChatService();
  final _controller = TextEditingController();
  String _response = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _sendMessage() async {
    final message = _controller.text.trim();
    if (message.isNotEmpty) {
      final response = await _chatService.sendMessage(message);
      setState(() {
        _response = response;
      });
    }
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chat with AI',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: AppColors.scaffoldGradientColors.first,
        elevation: 0,
      ),
      body: AppBackground(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(10),
                child: Text(
                  _response,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              margin: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Type your message...',
                ),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  AppColors.buttonsLightColor,
                ),
              ),
              onPressed: _sendMessage,
              child: const Text(
                'Send',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
