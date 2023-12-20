
import 'dart:convert';

import 'package:hive/hive.dart';

import '../../bloc/todo_bloc.dart';
import '../../events/todo/add_todo_event.dart';
import '../../models/todo.dart';
import 'package:http/http.dart' as http;

class TodosService {
  static Future<List<Todo>> _fetchAllTodos() async {
    final response = await http.get(Uri.parse('http://34.254.151.224:8080/todos'));
    if(response.statusCode == 200 ){ // that means we get a success response
      List<dynamic> todosAsJson = json.decode(response.body);
      List<Todo> todos = todosAsJson.map((todoAsJson) => Todo.fromJson(todoAsJson)).toList();
      return todos;
    }else{
      throw Exception('Failed to load todos from the server');
    }
  }

  static Future<void> removeTodoInRemote( Todo todo) async {
    var response = await http.delete(
        Uri.parse('http://34.254.151.224:8080/todos/${todo.id.substring(8)}'));
    if (response.statusCode !=
        200) { // that means we get an error that we should notify somehow
      print('Error while deleting todo from the server: ${response.body}');
    }else{
      print('Todo deleted from the server');
    }
  }

  static Future<void> syncTodos(TodoBloc bloc) async {
    List<Todo> localTodos = Hive.box<Todo>('todos').values.toList();
    List<Todo> remoteTodos = await _fetchAllTodos();
    // So let's compare them
    // Case we have a remote to do that is not stored locally, just add it to hive
    for (var remoteTodo in remoteTodos) {
      if(!localTodos.contains(remoteTodo)){
        //Hive.box<To do>('todos').put(remoteTodo.id, remoteTodo);
        // Instead of creating the to do thru Hive, let's create it thru the bloc
        // So that we can notify the UI that a new to do was added
        bloc.add(AddTodoEvent(remoteTodo));
          // This is gonna make sure that the new t odo is added to the list of todos and the ui is notified
        // TODO, In case the todo was deleted locally, we should delete it remotely
        //http.delete(Uri.parse('http://34.254.151.224:8080/todos/${remoteTodo.id}'));
      } else{
        Todo localTodo = localTodos.firstWhere((localTodo) => localTodo.id == remoteTodo.id);
        // TODO, check which one is the most recent one... and act accordingly
        // In case the local to do is the most recent one, we should update the remote to do
        //http.put(Uri.parse('http://34.254.151.224:8080/todos/${remoteTodo.id}'), body: json.encode(localTodo));
        // Otherwise we should update the local to do
        //Hive.box<To do>('todos').put(remoteTodo.id, remoteTodo);
      }
    }
    // Case we have a local to do that is not stored remotely, just add it to the server
    for (var localTodo in localTodos) {
      if(!remoteTodos.contains(localTodo)){
        // http.post(Uri.parse('http://34.254.151.224:8080/todos'), body: json.encode(localTodo));
        // I'm not sure if this is going to work for us... as out ID is a String
        // Json server expects an integer as an ID
      }
    }
  }
}