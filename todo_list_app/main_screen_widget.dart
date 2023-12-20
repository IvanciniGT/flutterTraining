//-----
// This is the home page of our application
// In this case we are using a stateful widget
import 'package:dummy_app/widgets/setting_widget.dart';
import 'package:dummy_app/widgets/todo_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/user_settings_bloc.dart';
import '../state/user_settings_state.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedTab = 0;

  final List<Widget> _tabs = [
    const TodoListScreen(), // Placeholder widget for the Home tab
    const SettingsScreen(), // Placeholder widget for the Settings tab
  ];

  void onTabTapped(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This methos is the one which is gonna be called
    // when the component/Screen/Widget is created and when its state changes
    // It will re-render the UI. For those of you working with React: this is the render method
    return BlocConsumer<UserSettingsBloc, UserSettingsState>(
        builder: (context, state) {
                              return Scaffold(
                                // Basic layout of the screen in Material Design
                                appBar: AppBar(
                                  backgroundColor: Theme
                                      .of(context)
                                      .colorScheme
                                      .inversePrimary,
                                  //title: Text('${BlocProvider.of<UserSettingsBloc>(context).state.userName}\'s Todo List'),
                                  title: BlocBuilder<UserSettingsBloc, UserSettingsState>(
                                      builder: (context, state) {
                                        return Text('${state.userName}\'s Todo List');
                                      }
                                  ),
                                ),
                                body: _tabs[_selectedTab],
                                bottomNavigationBar: BottomNavigationBar(
                                  onTap: onTabTapped, // Handle tab changes
                                  currentIndex: _selectedTab,
                                  items: const [
                                    BottomNavigationBarItem(
                                      icon: Icon(Icons.home),
                                      label: 'Home',
                                    ),
                                    BottomNavigationBarItem(
                                      icon: Icon(Icons.settings),
                                      label: 'Settings',
                                    ),
                                  ],
                                ),
                              );
    },
    listener: (context, state) {
      if (state is UserSettingsErrorState) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.errorMessage),
            backgroundColor: Colors.red,
          ),
        );
      }
    });
  }
}
