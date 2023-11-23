import 'package:frontend_task1/models/todo.dart';

abstract class TodoState {}

class InitTodoState extends TodoState {}

class LoadingTodoState extends TodoState {}

class ErrorTodoState extends TodoState {
  final String message;
  ErrorTodoState(this.message);
}

class ResponseTodoState extends TodoState {
  final List<Todo> todos;
  ResponseTodoState(this.todos);
}
