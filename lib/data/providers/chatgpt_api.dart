// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatService {
  final String _baseUrl = 'https://api.openai.com/v1/';
  static const String _apiKey =
      "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";

  Future<String> sendMessage(String message) async {
    final response = await http.post(
      Uri.parse('${_baseUrl}engines/davinci-codex/completions'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_apiKey',
      },
      body: jsonEncode({
        'prompt': '$message\n',
        'temperature': 0.7,
        'max_tokens': 60,
      }),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data['choices'][0]['text']);
      return data['choices'][0]['text'];
    } else {
      print(response.statusCode);
      return 'some error';
    }
  }
}
