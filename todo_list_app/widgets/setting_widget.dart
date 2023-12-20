
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/user_settings_bloc.dart';
import '../events/user_settings/user_settings_events.dart';
import '../state/user_settings_state.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
          TextField(
             onChanged: (value) {
               BlocProvider.of<UserSettingsBloc>(context).add(UserNameChanged(value));
               // Call the shared preferences to persist the new value... This probably is not the best place to do it
               // It would be a best option to do it in the bloc... as the bloc is the one which is in charge of the state
               // And we want the bloc to be the only one in charge of the state
               },
            // Field name:
            decoration: const InputDecoration(
              labelText: 'User Name',
            ),
            // Initial value:
            controller: TextEditingController(text: BlocProvider.of<UserSettingsBloc>(context).state.userName),
          ),
          Row(
          children: [
            const Text('Dark Mode'),
            // GEt current UserSettings State:
            BlocBuilder<UserSettingsBloc, UserSettingsState>(
              builder: (context, state) {
                return Switch(
                  value: state.darkModeEnabled,
                  onChanged: (value) => BlocProvider.of<UserSettingsBloc>(context).add(DarkThemeToggled(value)),
                );
              }
            )
          ],
        ),
        // Create that form right there: USerName and Toogle for DarkModeEnabled
        // Each time one of those props changes, send and event to the bloc
      ],
    );
  }
}


// Flutter Widgets tree:
// MaterialApp
//   title: 'Todo List'
//   theme: ThemeData(...)
//   home: MainScreen

// MainScreen (need to be of kind Widget)... in our case we did use Scaffold (the base layout for a screen in Material Design)
//   appBar: AppBar
//   body: TodoListScreen | SettingsScreen
//   bottomNavigationBar: BottomNavigationBar

// SettingsScreen (need to be of kind Widget)... in our case I'm using a Column
// I just want to stack more widgets on bottom of each other
//  Column:
//    children: [
//      TextField: (UserName)
//      Row:
//        children: [
//            Text: (Dark Mode),
//            Switch: (DarkModeEnabled)
//        ]
//    ]