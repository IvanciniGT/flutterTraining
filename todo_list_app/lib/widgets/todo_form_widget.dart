// This is the root of our application
// In flutter every component of the application is a widget
import 'package:dummy_app/bloc/todo_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../events/todo/add_todo_event.dart';
import '../events/todo/update_todo_event.dart';
import '../models/todo.dart';

class TodoFormWidget extends StatelessWidget {

  final Todo? existingTodo;
  const TodoFormWidget({super.key, this.existingTodo});

  @override
  Widget build(BuildContext context) {
    final TodoBloc todoBloc = BlocProvider.of<TodoBloc>(context); // Dependency Injection
    final TextEditingController myTodoTitleFormController = TextEditingController();
    final TextEditingController myTodoDescriptionFormController = TextEditingController();
    myTodoTitleFormController.text = existingTodo?.title ?? '';
    myTodoDescriptionFormController.text = existingTodo?.description ?? '';
    return AlertDialog(
      title: Text(existingTodo == null ? 'Add a new todo' : 'Edit todo'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: myTodoTitleFormController,
            decoration: const InputDecoration(
              labelText: 'Todo title',
            ),
            autofocus: true,
          ),
          TextField(
              controller: myTodoDescriptionFormController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Todo description',
              )),
        ],
      ),
      actions: [
        // The buttons at the bottom of the dialog
        OutlinedButton(
            onPressed: () {
              // Let's reset the form
              Navigator.of(context).pop(); // Close the dialog.
              // The navigator (kind the same as a browser history) is a stack of screens
              // we can push a new screen to the stack, and pop it to go back to the previous screen
            },
            child: const Text('Cancel')),
        ElevatedButton(
            onPressed: () {
              if (existingTodo != null) {
                todoBloc.add(UpdateTodoEvent(existingTodo!,
                    title: myTodoTitleFormController.text,
                    description: myTodoDescriptionFormController.text));
              } else {
                todoBloc.add(AddTodoEvent(Todo(
                    title: myTodoTitleFormController.text,
                    description: myTodoDescriptionFormController.text)));
              }
              // Let's reset the form
              Navigator.of(context).pop();
            },
            child: Text(existingTodo == null ? 'Add' : 'Edit'))
      ],
    );
  }
}
