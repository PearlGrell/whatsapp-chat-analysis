class CharacterModel {
  String? name;
  String? gender;

  CharacterModel({this.name, this.gender});

  CharacterModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['gender'] = gender;
    return data;
  }
}