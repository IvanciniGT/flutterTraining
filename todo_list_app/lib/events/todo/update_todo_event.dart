import 'package:dummy_app/events/todo/todo_event.dart';

import '../../models/todo.dart';

class UpdateTodoEvent extends TodoEvent {
  final Todo todo;
  final String? title ;
  final String? description ;
  final bool? completed ;

  const UpdateTodoEvent(this.todo, {this.title, this.description , this. completed});

  @override
  List<Object?> get props => [todo, title, description, completed];
}