import 'package:dummy_app/widgets/todo_list_app_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// This is the main function...
// The function that will start our application
Future<void> main() async {

  // RIGHT HERE, flutter is actually not completely initialized.
  // It's only after the runApp() function is called that flutter will be completely initialized

  // The problem is that we need to read the last stored values from the device (shared preferences)
  // And this Shared Preferences library requires that flutter is completely initialized
  // This also happens with a bunch of other libraries that require flutter to be completely initialized before they can be used

  // This line ensures that flutter is completely initialized before we continue
  WidgetsFlutterBinding.ensureInitialized();
  // ^^This is an extremely common line of code in flutter apps
  // When should we add that line of code in our apps:
  // - When, before calling runApp(), you need to do some async stuff (like reading from shared preferences)
  // - When calling native code before calling runApp()

  final preferences = await SharedPreferences.getInstance();

  final initialUserName= preferences.getString('userName') ?? 'Buddy';
  final initialDarkModeEnabled = preferences.getBool('darkModeEnabled') ?? false;

  runApp(TodoListApp(initialUserName: initialUserName, initialDarkModeEnabled: initialDarkModeEnabled)); // We create an instance of that class / widget
}


