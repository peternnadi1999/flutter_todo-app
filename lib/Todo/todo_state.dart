part of 'todo_bloc.dart';

@immutable
abstract class TodoState {}

abstract class TodoActionState extends TodoState {}

class TodoInitial extends TodoState {}

class TodoLoadingState extends TodoState {}

class TodoSuccessState extends TodoState {
  final List<ToDo> todo;

  TodoSuccessState(this.todo);
}

class AddTodoSuccessState extends TodoState {}

class TodoErrorState extends TodoState {}

class TodoUpdateState extends TodoState {
  final ToDo id;

  TodoUpdateState(this.id);
}

class TodoDeleteState extends TodoState {
  final ToDo id;

  TodoDeleteState(this.id);
}

class TodoAddState extends TodoState {
  final ToDo text;

  TodoAddState(this.text);
}
