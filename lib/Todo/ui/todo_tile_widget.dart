import 'package:flutter/material.dart';
import 'package:todoapp/Todo/todo_bloc.dart';

import '../model/Todol.dart';

class TodoTile extends StatelessWidget {
  final ToDo todo;
  const TodoTile({super.key, required this.todo, required this.todoBloc});
  final TodoBloc todoBloc;

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.all(10),
        child: ListTile(
          onTap: () {
            todoBloc.add(UpdateTodoEvent(todo));
            todoBloc.add(InitialEvent());
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
                todoBloc.add(DeleteTodoEvent(todo));
                todoBloc.add(InitialEvent());
              },
            ),
          ),
        ));
  }
}
