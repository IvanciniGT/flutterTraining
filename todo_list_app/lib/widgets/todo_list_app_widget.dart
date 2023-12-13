// This is the root of our application
// In flutter every component of the application is a widget
import 'package:dummy_app/widgets/todo_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/todo_bloc.dart';

class TodoListApp extends StatelessWidget {
  const TodoListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo app',    // A name for the app in the OS
      theme: ThemeData(     // The theme of the app
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigoAccent),
        useMaterial3: true,
      ),
      home: BlocProvider<TodoBloc>( // We initialize the bloc
        create: (context) => TodoBloc(),
        child: const TodoListScreen(), // The home page of the app
      ) // The home page of the app
      // I'm creating a new instance of a Stateful widget that I am defining myself
    );
  }
}
