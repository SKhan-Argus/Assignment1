import 'dart:math';

import 'package:frontend_task1/models/login_detail.dart';
import 'package:frontend_task1/models/todo.dart';
import 'package:frontend_task1/models/todo_add.dart';
import 'package:frontend_task1/models/user.dart';
import 'package:frontend_task1/repository/api_service.dart';

class AuthRepository {
  final ApiClient apiClient;

  AuthRepository(this.apiClient);


  Future<User> login(LoginDetail loginDetail) async {
    try {
      final response = await apiClient.login(loginDetail);
      return response;
    } catch (e) {
      throw Exception("Failed to login.");
    }
  }

  Future<User> register(User user) async {
    try {
      final response = await apiClient.register(user);
      return response;
    } catch (e) {
      throw Exception("Failed to register.");
    }
  }

}