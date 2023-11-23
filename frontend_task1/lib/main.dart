import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_task1/viewmodels/todo_bloc/todo_cubit.dart';
import 'package:frontend_task1/viewmodels/todo_bloc/todo_state.dart';
import 'package:frontend_task1/views/todo_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    int userId =3;
    return BlocProvider(
      create: (context) => TodoCubit(InitTodoState(), userId),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: TodoScreen(),
      ),
    );
  }
}
