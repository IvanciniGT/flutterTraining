// In this file we will create a class that will be responsible for managing the state of our application
// Here we will capture all the events that will change the state of our application according to the business logic

import 'package:dummy_app/events/todo/todo_event.dart';
import 'package:dummy_app/events/todo/update_todo_event.dart';
import 'package:dummy_app/state/todo_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../events/todo/add_todo_event.dart';
import '../events/todo/remove_todo_event.dart';

class TodoBloc extends Bloc<TodoEvent, TodoList> {
  TodoBloc() : super(const TodoList()){

    // Here we implement the event listeners
    on<AddTodoEvent>((event, emit) {
      // Generate a new state (a new list of todos)
                                            // State is a variable that we have here (we inherit that from Bloc)
                                            // that was initialized in the constructor
                                            // with the value that we suplied on the super call
      final newTodoList = TodoList(todos: [...state.todos, event.todo]);
      // Publish that new state
      emit(newTodoList); // This sets the new state... but also it will notify that we have a new state to the widgets
    });

    on<RemoveTodoEvent>((event, emit) =>
      // Generate a new state (a new list of todos, without the one that was removed)
      // Publish that new state
      emit( TodoList(todos: state.todos.where((todo) => todo != event.todo).toList()) )
    );

    on<UpdateTodoEvent>((event, emit) {
      // Generate a new state (a new list of todos, with the one that was updated)
      final updatedTodo = event.todo.copyWith(completed: event.completed, description: event.description, title: event.title);
      final newTodoList = TodoList(todos: state.todos.map((todo) => todo == event.todo ? updatedTodo : todo).toList());
      // Publish that new state
      emit(newTodoList);
      }
    );
  }

}
// Bloc bring REDUX model to Flutter