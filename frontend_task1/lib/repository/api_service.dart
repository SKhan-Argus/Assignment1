import 'package:frontend_task1/models/todo_add.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:frontend_task1/models/todo.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: 'http://localhost:8080/api')
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET('/todos/{id}')
  Future<List<Todo>> getTodo(@Path('id') int userId);

  @POST('/todos/{id}')
  Future<Todo> addTodo(@Path('id') int userId, @Body() TodoAdd todo);

  @DELETE('/todos/{id}')
  Future<Todo> deleteTodo(@Path('id') int todoId);

  @PUT('/todos/{id}/toggle')
  Future<void> updateTodo(@Path('id') int todoId);
}
