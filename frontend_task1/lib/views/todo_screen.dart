import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_task1/viewmodels/todo_bloc/todo_cubit.dart';
import 'package:frontend_task1/viewmodels/todo_bloc/todo_state.dart';
import 'package:frontend_task1/views/add_dialog_box.dart';
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
      final cubit = context.read<TodoCubit>();
      cubit.fetchTodo();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Todo List",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black26,
      ),
      body: BlocBuilder<TodoCubit, TodoState>(
        builder: (context, state) {
          if (state is InitTodoState || state is LoadingTodoState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ResponseTodoState) {
            final todos = state.todos;
            return ListView.builder(
              padding: EdgeInsets.only(bottom: 80),
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];
                return Card(
                  elevation: 4,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
                      icon: Icon(Icons.delete),
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
        onPressed: () => showAddTodoDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }

  void showAddTodoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AddDialogBox(),
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
