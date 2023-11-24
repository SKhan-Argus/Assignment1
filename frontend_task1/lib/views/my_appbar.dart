import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_task1/viewmodels/auth_bloc/auth_cubit.dart';
import 'package:frontend_task1/viewmodels/todo_bloc/todo_cubit.dart';

class MyAppbar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppbar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: const Text(
        "Todo List",
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.black26,
      actions: [
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
            // Access the AuthCubit and emit an UnauthenticatedState
            context.read<AuthCubit>().logout();
            context.read<TodoCubit>().logout();
          },
        ),
      ],
    );
  }
}
