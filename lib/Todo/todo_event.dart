part of 'todo_bloc.dart';

@immutable
abstract class TodoEvent {}

class InitialEvent extends TodoEvent {}

class AddTodoEvent extends TodoEvent {
  final String text;

  AddTodoEvent(this.text);
}

class DeleteTodoEvent extends TodoEvent {
  final ToDo id;

  DeleteTodoEvent(this.id);
}

class UpdateTodoEvent extends TodoEvent {
  final ToDo todo;

  UpdateTodoEvent(this.todo);
}
