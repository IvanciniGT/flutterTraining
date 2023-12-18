// This is the root of our application
// In flutter every component of the application is a widget
import 'package:dummy_app/bloc/user_settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/todo_bloc.dart';
import '../state/user_settings_state.dart';
import 'main_screen_widget.dart';

class TodoListApp extends StatelessWidget {
  const TodoListApp({super.key});

  @override
  Widget build(BuildContext context) {

    // We will need to read the last stored values from the device (shared preferences)
    // And set those as initial values right here!!!            vvvvvvvvvvvvvvvvvvvvvvvvvvvv
    return BlocProvider<UserSettingsBloc>( // We initialize the bloc
      create: (context) => UserSettingsBloc(initialUserName:'Ivan', initialDarkModeEnabled: false),
      child:
        BlocBuilder<UserSettingsBloc, UserSettingsState>(
          builder: (context, state) {
            return MaterialApp(
              title: 'Todo list', // The title of the app

              theme: AppThemes.themes[state.darkModeEnabled?1:0], // The theme of the app
              home: BlocProvider<TodoBloc>( // We initialize the bloc
                create: (context) => TodoBloc(),
                child: const MainScreen(), // The home page of the app
              )
            );
          }
        )

    );
  }
}


class AppThemes {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    colorScheme: const ColorScheme.light(
      primary: Colors.blue,
      secondary: Colors.blueAccent,
    ),
    // Additional customizations for light theme
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.blue,
    colorScheme: const ColorScheme.dark(
      primary: Colors.blue,
      secondary: Colors.blueAccent,
    ),
    // Additional customizations for dark theme
  );

  // Both in a List
  static final themes = [lightTheme, darkTheme];
}







