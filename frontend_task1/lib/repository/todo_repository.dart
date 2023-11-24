import 'package:frontend_task1/models/todo.dart';
import 'package:frontend_task1/models/todo_add.dart';
import 'package:frontend_task1/repository/api_service.dart';

class TodoRepository {
  final ApiClient apiClient;

  TodoRepository(this.apiClient);

  Future<List<Todo>> fetchTodo(int userId) async {
    try {
      final response = await apiClient.getTodo(userId);
      return response;
    } catch (e) {
      throw Exception("Failed to fetch todo.");
    }
  }

  Future<void> addTodo(
      String titleAdd, String descriptionAdd, int userId) async {
    try {
      await apiClient.addTodo(
          userId,
          TodoAdd(
            title: titleAdd,
            description: descriptionAdd,
          ));
    } catch (e) {
      throw Exception("Failed to add todo.");
    }
  }

  Future<void> updateTodo(int id) async {
    try {
      await apiClient.updateTodo(id);
    } catch (e) {
      throw Exception("Failed to update todo.");
    }
  }

  Future<void> deleteTodo(int id) async {
    try {
      await apiClient.deleteTodo(id);
    } catch (e) {
      throw Exception("Failed to delete todo.");
    }
  }
}
