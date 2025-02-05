import 'package:whatsapp_chat_analysis/model/character_model.dart';

class ResponseModel {
  String? tone;
  List<String>? emotions;
  List<String>? highlightQuotes;
  List<String>? topWords;
  String? chatSummary;
  String? mostTalkative;
  String? fastestResponder;
  List<CharacterModel>? characters;
  String? theme;

  ResponseModel(
      {this.tone,
        this.emotions,
        this.highlightQuotes,
        this.topWords,
        this.chatSummary,
        this.mostTalkative,
        this.fastestResponder,
        this.characters,
        this.theme});

  ResponseModel.fromJson(Map<String, dynamic> json) {
    tone = json['tone'];
    emotions = json['emotions'].cast<String>();
    highlightQuotes = json['highlight_quotes'].cast<String>();
    topWords = json['top_words'].cast<String>();
    chatSummary = json['chat_summary'];
    mostTalkative = json['most_talkative'];
    fastestResponder = json['fastest_responder'];
    if (json['characters'] != null) {
      characters = <CharacterModel>[];
      json['characters'].forEach((v) {
        characters!.add(CharacterModel.fromJson(v));
      });
    }
    theme = json['theme'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tone'] = tone;
    data['emotions'] = emotions;
    data['highlight_quotes'] = highlightQuotes;
    data['top_words'] = topWords;
    data['chat_summary'] = chatSummary;
    data['most_talkative'] = mostTalkative;
    data['fastest_responder'] = fastestResponder;
    if (characters != null) {
      data['characters'] = characters!.map((v) => v.toJson()).toList();
    }
    data['theme'] = theme;
    return data;
  }
}