import 'package:dummy_app/events/todo/todo_event.dart';

import '../../models/todo.dart';

class RemoveTodoEvent extends TodoEvent {
  final Todo todo;

  const RemoveTodoEvent(this.todo);

  @override
  List<Object> get props => [todo];
}