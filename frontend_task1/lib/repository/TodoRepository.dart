import 'dart:convert';

import 'package:frontend_task1/models/todo.dart';
import 'package:http/http.dart' as http;


// was calling api using http
// not being used currently


class TodoRepository {
  Future<List<Todo>> getAll() async {
    const url = 'https://jsonplaceholder.typicode.com/todos';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if(response.statusCode == 200){
      final json = jsonDecode(response.body) as List;
      final result = json.map((e){
        return Todo(id: e['id'],  title: e['title'], completed: e['completed'], description: e['description'], createdAt: e['created_at']);
      }).toList();
      return result;
    }
    else{
      throw "Something went wrong code ${response.statusCode}";
    }
  }
}