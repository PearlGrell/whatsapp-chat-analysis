import 'dart:io';

class Messages{
  String text;
  String sender;
  String timestamp;

  Messages({required this.text, required this.sender, required this.timestamp});

  Map<String, String> toJson(){
    return {
      'text': text,
      'sender': sender,
      'timestamp': timestamp,
    };
  }
}

List<Messages> parseMessages(File chatFile){
  String messages = chatFile.readAsStringSync();
  List<String> messageList = messages.split('\n');
  List<Messages> parsedMessages = [];
  for (String message in messageList){
    List<String> messageParts = message.split(' - ');
    if (messageParts.length > 1){
      String timestamp = messageParts[0];
      String senderAndText = messageParts[1];
      List<String> senderAndTextParts = senderAndText.split(':');
      if (senderAndTextParts.length > 1){
        String sender = senderAndTextParts[0];
        String text = senderAndTextParts[1];
        parsedMessages.add(Messages(text: text, sender: sender, timestamp: timestamp));
      }
    }
  }
  return parsedMessages;
}