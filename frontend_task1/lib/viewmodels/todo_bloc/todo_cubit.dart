import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_task1/viewmodels/todo_bloc/todo_state.dart';
import 'package:frontend_task1/repository/api_service.dart';
import 'package:frontend_task1/models/todo_add.dart';

class TodoCubit extends Cubit<TodoState> {


  TodoCubit(super.initialState, this.userId);
  final int userId;

  Future<void> fetchTodo() async {
    emit(LoadingTodoState());
    final client = ApiClient(
      Dio(
        BaseOptions(contentType: "application/json"),
      ),
    );

    try {
      final response = await client.getTodo(userId);
      emit(ResponseTodoState(response));
    } catch (e) {
      emit(ErrorTodoState(e.toString()));
    }
  }

  Future<void> addTodo(String titleAdd, String descriptionAdd) async {
    final apiClient = ApiClient(Dio());
    try {
      await apiClient.addTodo(
          3,
          TodoAdd(
            title: titleAdd,
            description: descriptionAdd,
          ));
      fetchTodo();
    } catch (e) {
      emit(ErrorTodoState("Failed to add todo."));
    }
  }

  Future<void> updateTodo(int id) async {
    final apiClient = ApiClient(Dio());
    try {
      await apiClient.updateTodo(id);
      fetchTodo();
    } catch (e) {
      emit(ErrorTodoState("Failed to update todo."));
    }
  }

  Future<void> deleteTodo(int id) async {
    final apiClient = ApiClient(Dio());
    try {
      await apiClient.deleteTodo(id);
      fetchTodo();
    } catch (e) {
      emit(ErrorTodoState("Failed to delete todo."));
    }
  }
}
