import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:whatsapp_chat_analysis/helper/parse_messages.dart';
import 'package:whatsapp_chat_analysis/model/response_model.dart';

class API{
  final String baseUrl = 'https://whatsapp-chat-analysis-api.vercel.app/api/analyse';

  Future<ResponseModel> getChatAnalysis(File chatFile) async {
    List<Messages> messages = parseMessages(chatFile);
    List<Map<String, String>> messagesMap = messages.map((e) => e.toJson()).toList();
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
      },
      body: jsonEncode({"messages": messagesMap}),
    );
    final responseDecoded = jsonDecode(response.body);
    if (response.statusCode == 200) {
      ResponseModel responseModel = ResponseModel.fromJson(jsonDecode(response.body));
      return responseModel;
    } else {
      throw Exception(responseDecoded['error']);
    }
  }
}