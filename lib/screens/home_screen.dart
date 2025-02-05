import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_chat_analysis/api/api.dart';
import 'package:whatsapp_chat_analysis/model/response_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ResponseModel responseModel = ResponseModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: handleFilePicking, child: Text("Pick File")),
            Text(responseModel.tone ?? ""),
            Text(responseModel.emotions?.join(", ") ?? ""),
            Text(responseModel.highlightQuotes?.join(", ") ?? ""),
            Text(responseModel.topWords?.join(", ") ?? ""),
            Text(responseModel.chatSummary ?? ""),
            Text(responseModel.mostTalkative ?? ""),
            Text(responseModel.fastestResponder ?? ""),
            Text(responseModel.theme ?? ""),
            Text(responseModel.characters?.map((e) => e.name).join(", ") ?? ""),
          ],
        ),
      ),
    );
  }

  handleFilePicking() async {
    var file = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['txt']);
    if (file != null) {
      API api = API();
      await api.getChatAnalysis(File(file.files.single.path!)).then((value) {
        setState(() {
          responseModel = value;
        });
      }).catchError((error) {
        if (mounted) {
          log(error.toString());
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(error.toString())));
        }
      });
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("No file picked")));
      }
    }
  }
}
