// In this file we will create a class that will be responsible for managing the state of our application
// Here we will capture all the events that will change the state of our application according to the business logic

import 'package:dummy_app/events/todo/todo_event.dart';
import 'package:dummy_app/events/todo/update_todo_event.dart';
import 'package:dummy_app/state/todo_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../events/todo/add_todo_event.dart';
import '../events/todo/remove_todo_event.dart';
import '../models/todo.dart';

class TodoBloc extends Bloc<TodoEvent, TodoList> {
  TodoBloc() : super(TodoList( todos: Hive.box<Todo>('todos').values.toList())) {

    // Here we implement the event listeners
    on<AddTodoEvent>((event, emit) {
      // Generate a new state (a new list of todos)
                                            // State is a variable that we have here (we inherit that from Bloc)
                                            // that was initialized in the constructor
                                            // with the value that we suplied on the super call
      final newTodoList = TodoList(todos: [...state.todos, event.todo]);
      // Store that in hive
      Hive.box<Todo>('todos').put(event.todo.id, event.todo).catchError((error) {
        print('Error while storing todo in hive: $error');
        // We should do almost the samething as we did in the user settings bloc
        // Tho have an extesion for the state that will handle the error
        // and will notify the UI that an error happened... for example with that same snackbar that we have in the MainScreen
      } );
      // Publish that new state
      emit(newTodoList); // This sets the new state... but also it will notify that we have a new state to the widgets
    });

    on<RemoveTodoEvent>((event, emit) {
      // Remove that to do from hive
      Hive.box<Todo>('todos').delete(event.todo.id).catchError((error) {
        print('Error while removing todo from hive: $error');
        // We should do almost the samething as we did in the user settings bloc
        // Tho have an extesion for the state that will handle the error
        // and will notify the UI that an error happened... for example with that same snackbar that we have in the MainScreen
      });
      // Generate a new state (a new list of todos, without the one that was removed)
      // Publish that new state
      emit(TodoList(
          todos: state.todos.where((todo) => todo != event.todo).toList()));
      }
    );

    on<UpdateTodoEvent>((event, emit) {
      // Generate a new state (a new list of todos, with the one that was updated)
      final updatedTodo = event.todo.copyWith(completed: event.completed, description: event.description, title: event.title);
      final newTodoList = TodoList(todos: state.todos.map((todo) => todo == event.todo ? updatedTodo : todo).toList());

      // Let's update that to do in hive
      Hive.box<Todo>('todos').put(updatedTodo.id, updatedTodo).catchError((error) {
        print('Error while updating todo in hive: $error');
        // We should do almost the samething as we did in the user settings bloc
        // Tho have an extesion for the state that will handle the error
        // and will notify the UI that an error happened... for example with that same snackbar that we have in the MainScreen
      });

      // Publish that new state
      emit(newTodoList);
      }
    );
  }

}
// Bloc bring REDUX model to Flutter