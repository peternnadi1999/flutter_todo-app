import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/Todol.dart';

class TodoRepos {
  static Future<List<ToDo>> getTodo() async {
    List<ToDo> todos = [];

    try {
      final snapshot =
          await FirebaseFirestore.instance.collection("Todo").get();

      snapshot.docs.map((e) {
        return todos.add(ToDo.fromJson(e));
      }).toList();
      return todos;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static addTodo(ToDo todo) async {
    try {
      await FirebaseFirestore.instance.collection("Todo").add(todo.toJson());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static updateTodo(ToDo todo) async {
    try {
      await FirebaseFirestore.instance
          .collection("Todo")
          .doc(todo.id)
          .update({"isDone": !todo.isDone});
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static deleteTodo(ToDo todo) async {
    try {
      await FirebaseFirestore.instance.collection("Todo").doc(todo.id).delete();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
