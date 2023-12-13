import 'package:dummy_app/events/todo/todo_event.dart';

import '../../models/todo.dart';

class AddTodoEvent extends TodoEvent {
  final Todo todo;

  const AddTodoEvent(this.todo);

  @override
  List<Object> get props => [todo];
}