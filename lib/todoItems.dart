import 'package:flutter/material.dart';
import 'package:todoapp/model/Todol.dart';

class TodoItem extends StatelessWidget {
  final ToDo todo;
  final onDeleteTodo;
  final onTodoChange;
  const TodoItem(
      {super.key,
      required this.todo,
      required this.onDeleteTodo,
      required this.onTodoChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      // width: MediaQuery.of(context).size.width - 30,
      // decoration: BoxDecoration(
      //   boxShadow: [
      //     BoxShadow(
      //       color: Colors.grey.shade300,
      //       // spreadRadius: 1,
      //       blurRadius: 30,
      //     )
      //   ],
      //   // gradient: LinearGradient(
      //   //     begin: Alignment.topLeft,
      //   //     end: Alignment.bottomRight,
      //   //     colors: [
      //   //       Colors.grey.shade300,
      //   //       Colors.grey.shade200,
      //   //       Colors.grey.shade100
      //   //     ]),
      // ),

      child: ListTile(
          onTap: () {
            onTodoChange(todo);
          },
          tileColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          leading: Icon(
            todo.isDone ? Icons.check_box_outline_blank : Icons.check_box,
            color: Colors.teal,
          ),
          title: Text(
            todo.todoText,
            style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                decoration: todo.isDone
                    ? TextDecoration.none
                    : TextDecoration.lineThrough,
                fontSize: 16),
          ),
          trailing: Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(
                color: Colors.red, borderRadius: BorderRadius.circular(8)),
            child: IconButton(
              iconSize: 18,
              color: Colors.white,
              icon: Icon(Icons.delete),
              onPressed: () {
                onDeleteTodo(todo.id);
              },
            ),
          )),
    );
  }
}
