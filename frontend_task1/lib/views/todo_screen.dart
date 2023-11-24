import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_task1/viewmodels/auth_bloc/auth_cubit.dart';
import 'package:frontend_task1/viewmodels/auth_bloc/auth_state.dart';
import 'package:frontend_task1/viewmodels/todo_bloc/todo_cubit.dart';
import 'package:frontend_task1/viewmodels/todo_bloc/todo_state.dart';
import 'package:frontend_task1/views/my_appbar.dart';
import 'delete_dialog_box.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final authState = context.read<AuthCubit>().state;
      final userId = (authState is AuthenticatedState) ? authState.user.id : null;
      final cubit = context.read<TodoCubit>();
      cubit.setUserId(userId!=null?userId:0);
      cubit.fetchTodo();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppbar(),
      body: BlocBuilder<TodoCubit, TodoState>(
        builder: (context, state) {
          if (state is InitTodoState || state is LoadingTodoState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if(state is LogoutTodoState){
            Future.microtask(() {
              Navigator.pushReplacementNamed(context, '/login');
            });
          }
          else if (state is ResponseTodoState) {
            final todos = state.todos;
            return ListView.builder(
              padding: const EdgeInsets.only(bottom: 80),
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];
                return Card(
                  elevation: 4,
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    leading: Checkbox(
                      value: todo.completed,
                      onChanged: (value) {
                        final cubit = context.read<TodoCubit>();
                        cubit.updateTodo(todo.id);
                      },
                    ),
                    title: Text(
                      todo.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        decoration: todo.completed
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    subtitle: Text(
                      todo.description,
                      style: TextStyle(
                        fontSize: 14,
                        decoration: todo.completed
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        showDeleteTodoDialog(context, todo.id);
                      },
                    ),
                  ),
                );
              },
            );
          } else if (state is ErrorTodoState) {
            return const Center(
              child: Text("Sorry, Something went wrong!"),
            );
          }
          return Center(child: Text(state.toString()));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final cubit = context.read<TodoCubit>();
          Navigator.pushNamed(
            context,
            '/add',
            arguments:
                cubit.userId, // Replace myData with the data you want to pass
          );
          // showAddTodoDialog(context, cubit.userId);
        },
        child: const Icon(Icons.add),
      ),
    );
  }



  void showDeleteTodoDialog(BuildContext context, int id) {
    showDialog(
      context: context,
      builder: (context) => DeleteDialogBox(
        id: id,
      ),
    );
  }
}
