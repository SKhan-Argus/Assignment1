import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_task1/repository/api_service.dart';
import 'package:frontend_task1/repository/auth_repository.dart';
import 'package:frontend_task1/repository/todo_repository.dart';
import 'package:frontend_task1/viewmodels/auth_bloc/auth_cubit.dart';
import 'package:frontend_task1/viewmodels/auth_bloc/auth_state.dart';
import 'package:frontend_task1/viewmodels/todo_bloc/todo_cubit.dart';
import 'package:frontend_task1/viewmodels/todo_bloc/todo_state.dart';
import 'package:frontend_task1/views/add_todo_screen.dart';
import 'package:frontend_task1/views/login_screen.dart';
import 'package:frontend_task1/views/register_screen.dart';
import 'package:frontend_task1/views/todo_screen.dart';
import 'package:get_it/get_it.dart';

void main() {
  final getIt = GetIt.instance;
  getIt.registerSingleton<TodoRepository>(TodoRepository(ApiClient(Dio())));
  getIt.registerSingleton<AuthRepository>(AuthRepository(ApiClient(Dio())));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TodoCubit>(
          create: (context) => TodoCubit(
            InitTodoState(),
          ),
        ),
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(
            InitAuthState(),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/login',
        routes: {
          '/login': (context) => LoginScreen(),
          '/register': (context) => RegisterScreen(),
          '/todo': (context) => const TodoScreen(),
          '/add': (context) => const AddTodoScreen(),
        },
      ),
    );
  }
}
