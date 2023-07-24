import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todoapp/Todo/repository/todo_repo_class.dart';
import 'package:todoapp/Todo/ui/Todo.dart';

import 'model/Todol.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoInitial()) {
    on<AddTodoEvent>(addTodoEvent);
    on<InitialEvent>(initialEvent);
    on<DeleteTodoEvent>(deleteTodoEvent);
    on<UpdateTodoEvent>(updateTodoEvent);
  }
}

FutureOr<void> initialEvent(InitialEvent event, Emitter<TodoState> emit) async {
  emit(TodoLoadingState());
  List<ToDo> todo = await TodoRepos.getTodo();
  print(todo.first.id);
  // Future.delayed(Duration(seconds: 2));
  emit(TodoSuccessState(todo));
  // emit(TodoSuccessState(ToDo.Todo.map((e) =>
  //         ToDo(id: e["id"], todoText: e["todoText"], isDone: e["isDone"]))
  //     .toList()));
}

FutureOr<void> addTodoEvent(AddTodoEvent event, Emitter<TodoState> emit) async {
  emit(AddTodoSuccessState());
  final todo = await TodoRepos.addTodo(ToDo(todoText: event.text));
  emit(TodoAddState(todo));
}

FutureOr<void> deleteTodoEvent(
    DeleteTodoEvent event, Emitter<TodoState> emit) async {
  final todo = await TodoRepos.deleteTodo(event.id);
  emit(TodoDeleteState(todo));
}

FutureOr<void> updateTodoEvent(
    UpdateTodoEvent event, Emitter<TodoState> emit) async {
  final todo = await TodoRepos.updateTodo(event.todo);
  print(todo);
  emit(TodoUpdateState(todo));
}
