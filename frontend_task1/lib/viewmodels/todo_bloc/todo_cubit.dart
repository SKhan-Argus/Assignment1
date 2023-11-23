import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_task1/viewmodels/todo_bloc/todo_state.dart';
import 'package:frontend_task1/repository/api_service.dart';
import 'package:frontend_task1/models/todo_add.dart';

class TodoCubit extends Cubit<TodoState> {


  TodoCubit(super.initialState, this.userId);
  int userId;

  Future<void> fetchTodo(int userId) async {
    emit(LoadingTodoState());
    this.userId = userId;
    final client = ApiClient(
      Dio(
        BaseOptions(contentType: "application/json"),
      ),
    );

    try {
      final response = await client.getTodo(this.userId);
      emit(ResponseTodoState(response));
    } catch (e) {
      emit(ErrorTodoState(e.toString()));
    }
  }

  Future<void> addTodo(String title_add, String description_add) async {
    final apiClient = ApiClient(Dio());
    try {
      final response = await apiClient.addTodo(
          3,
          TodoAdd(
            title: title_add,
            description: description_add,
          ));
      print('Todo added: ${response.id}');
      fetchTodo(this.userId);
    } catch (e) {
      print('Failed to add todo: $e');
    }
  }

  Future<void> updateTodo(int id) async {
    final apiClient = ApiClient(Dio());
    try {
      final response = await apiClient.updateTodo(id);
      print("Todo updated $id");
      fetchTodo(this.userId);
    } catch (e) {
      print('Failed to update todo : $e');
    }
  }

  Future<void> deleteTodo(int id) async {
    final apiClient = ApiClient(Dio());
    try {
      final response = await apiClient.deleteTodo(id);
      print("Todo deleted $id");
      fetchTodo(this.userId);
    } catch (e) {
      print('Failed to delete todo : $e');
    }
  }
}
