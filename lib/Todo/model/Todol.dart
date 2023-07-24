import 'package:cloud_firestore/cloud_firestore.dart';

class ToDo {
  String? id;
  String todoText;
  bool isDone;

  ToDo({this.id, required this.todoText, this.isDone = false});

  factory ToDo.fromJson(DocumentSnapshot<Map<String, dynamic>> json) {
    return ToDo(
      id: json.id,
      todoText: json["todoText"],
      isDone: json["isDone"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "todoText": todoText,
      "isDone": isDone,
    };
  }
//
}
