//-----
// This is the home page of our application
// In this case we are using a stateful widget
import 'package:dummy_app/service/todos/TodosService.dart';
import 'package:dummy_app/widgets/todo_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

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
      body: BlocBuilder<TodoBloc, TodoList>(builder: (context, state) {
        // Calculate summary counts
        int pendingCount = state.todos
            .where((todo) =>
                !todo.completed &&
                (todo.deadLine == null ||
                    todo.deadLine!.isAfter(DateTime.now())))
            .length;
        int delayedCount = state.todos
            .where((todo) =>
                !todo.completed &&
                todo.deadLine != null &&
                todo.deadLine!.isBefore(DateTime.now()))
            .length;
        int completedCount = state.todos.where((todo) => todo.completed).length;

        return Column(
          children: [
            // Summary
            Container(
              padding: const EdgeInsets.all(10),
              color: Colors.blueGrey[100],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildSummaryItem('Pending', pendingCount, Colors.orange,
                      Icons.hourglass_empty),
                  _buildSummaryItem(
                      'Delayed', delayedCount, Colors.red, Icons.error_outline),
                  _buildSummaryItem('Completed', completedCount, Colors.green,
                      Icons.check_circle_outline),
                ],
              ),
            ),
            // List of Todos
            Expanded(
              child: ListView(
                children: state.todos.map((Todo todo) {
                  return Dismissible(
                    key: Key(todo.title),
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      child: const Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Icon(Icons.delete, color: Colors.white),
                      ),
                    ),
                    onDismissed: (direction) {
                      todoBloc.add(RemoveTodoEvent(todo));
                    },
                    child: Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
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
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(todo.description),
                              if (todo.deadLine != null)
                                Text(
                                  'Deadline: ${DateFormat('dd-MM-dddd - HH:mm').format(todo.deadLine!)}',
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  todoBloc.add(UpdateTodoEvent(todo,
                                      completed: !todo.completed));
                                },
                                icon: Icon(
                                  todo.completed
                                      ? Icons.check_box
                                      : Icons.check_box_outline_blank,
                                ),
                              ),
                            ],
                          ),
                          // Change the tile color based on completion status or deadline due
                          tileColor: todo.completed
                              ? Colors.grey.withOpacity(0.5)
                              : todo.deadLine != null &&
                                      todo.deadLine!.isBefore(DateTime.now())
                                  ? Colors.red.withOpacity(0.2)
                                  : null,
                        )),
                  );
                }).toList(),
              ),
            ),
          ],
        );
      }),
      floatingActionButton:
      Row(
    children: [
      FloatingActionButton(
        onPressed: (){
              TodosService.syncTodos(BlocProvider.of<TodoBloc>(context));
        },
        tooltip: 'Sync todos with backend',
        child: const Icon(Icons.sync),
      ), // This trailing comma makes auto-formatting nicer for build
      FloatingActionButton(
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
      ), // This trailing comma makes auto-formatting nicer for build

    ])

      // methods.
    );
  }

  Widget _buildSummaryItem(
      String label, int count, Color color, IconData icon) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          count.toString(),
          style: TextStyle(
            color: color,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
