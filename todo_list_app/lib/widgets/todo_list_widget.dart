//-----
// This is the home page of our application
// In this case we are using a stateful widget
import 'package:dummy_app/widgets/todo_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/todo_bloc.dart';
import '../events/todo/remove_todo_event.dart';
import '../events/todo/update_todo_event.dart';
import '../models/todo.dart';
import '../state/todo_list.dart';

class TodoListScreen extends StatelessWidget {
  const TodoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TodoBloc todoBloc =
        BlocProvider.of<TodoBloc>(context); // Dependency Injection
    // This methos is the one which is gonna be called
    // when the component/Screen/Widget is created and when its state changes
    // It will re-render the UI. For those of you working with React: this is the render method
    return Scaffold(
      // Basic layout of the screen in Material Design
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Todo list'),
      ),
      body: BlocBuilder<TodoBloc, TodoList>(
          // This will be reexecuted each time the state changes
          builder: (context, state) {
        // Dependency Injection
        return ListView(
          children: state.todos.map((Todo todo) {
            return Dismissible(
                key: Key(todo.title),
                background: Container(
                  color: Colors.red,
                  child: const Icon(Icons.delete),
                ),
                onDismissed: (direction) {
                  todoBloc.add(RemoveTodoEvent(
                      todo)); // Send a new To-do Removed event to the bloc
                },
                child: ListTile(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (dialogContext) {
                        return BlocProvider.value(
                          value: BlocProvider.of<TodoBloc>(context),
                          child: TodoFormWidget(existingTodo: todo),
                        );
                      },
                    );
                  },
                  title: Text(todo.title),
                  subtitle: Text(todo.description),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          todoBloc.add(UpdateTodoEvent(todo,
                              completed: !todo.completed));
                        },
                        icon: Icon(todo.completed
                            ? Icons.check_box
                            : Icons.check_box_outline_blank),
                      ),
                    ],
                  ),
                ));
          }).toList(),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (dialogContext) {
              return BlocProvider.value(
                value: BlocProvider.of<TodoBloc>(context),
                child: const TodoFormWidget(),
              );
            },
          );
        },
        tooltip: 'Add a new Todo',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
