import 'package:cloud_firestore/cloud_firestore.dart';

final _db = FirebaseFirestore.instance;

class ToDo {
  String? id;
  String todoText;
  bool isDone;

  ToDo({this.id, required this.todoText, this.isDone = false});
  toJson() {
    return {'todoText': todoText, 'isDone': isDone};
  }

  // static List<ToDo> todoList() {
  //   return [
  //     ToDo(id: "1", todoText: "Good morning boss", isDone: true),
  //     ToDo(id: "2", todoText: "Good afternoon boss", isDone: true),
  //     ToDo(id: "3", todoText: "Reading time boss"),
  //     ToDo(id: "4", todoText: "Coding Time boss", isDone: true),
  //     ToDo(id: "5", todoText: "School time boss"),
  //     ToDo(id: "6", todoText: "Study time boss"),
  //   ];
  // }

  // factory ToDo.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
  //   final data = document.data()!;
  //   return ToDo(
  //     id: document.id,
  //     isDone: data["isDone"],
  //     todoText: data["todoText"],
  //   );
  // }
}
