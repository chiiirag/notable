class NoteModel {
  final String? id;
  final String? title;
  final String? description;
  final int? createdAt;

  NoteModel({this.id, this.title, this.description, this.createdAt});

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "createdAt": createdAt,
    };
  }

  factory NoteModel.fromJson(Map<dynamic, dynamic> json) {
    return NoteModel(
      title: json["title"],
      id: json["id"],
      description: json["description"],
      createdAt: json["createdAt"],
    );
  }
}
