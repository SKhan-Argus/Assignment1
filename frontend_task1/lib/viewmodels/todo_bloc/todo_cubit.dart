import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_task1/viewmodels/auth_bloc/auth_cubit.dart';
import 'package:frontend_task1/viewmodels/todo_bloc/todo_state.dart';
import 'package:frontend_task1/repository/todo_repository.dart';
import 'package:get_it/get_it.dart';

class TodoCubit extends Cubit<TodoState> {
  final TodoRepository todoRepository = GetIt.instance<TodoRepository>();
  int userId = 0;
  TodoCubit(super.initialState,);

  void setUserId(int userId){
    this.userId = userId;
  }


  Future<void> fetchTodo() async {
    emit(LoadingTodoState());
    try {
      final response = await todoRepository.fetchTodo(userId);
      emit(ResponseTodoState(response));
    } catch (e) {
      emit(ErrorTodoState(e.toString()));
    }
  }

  Future<void> addTodo(String titleAdd, String descriptionAdd) async {
    try {
      await todoRepository.addTodo(titleAdd, descriptionAdd, userId);
      fetchTodo();
    } catch (e) {
      emit(ErrorTodoState("Failed to add todo."));
    }
  }

  Future<void> updateTodo(int id) async {
    try {
      await todoRepository.updateTodo(id);
      fetchTodo();
    } catch (e) {
      emit(ErrorTodoState("Failed to update todo."));
    }
  }

  Future<void> deleteTodo(int id) async {
    try {
      await todoRepository.deleteTodo(id);
      fetchTodo();
    } catch (e) {
      emit(ErrorTodoState("Failed to delete todo."));
    }
  }

  void logout(){
    emit(LogoutTodoState());
  }
}
