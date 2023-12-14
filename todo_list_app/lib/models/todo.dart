
//---- DTO: Data Transfer Object / Model / Entity
// Let's define what a TO DO is
// Let's convert this model/entity in an inmutable class
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Todo extends Equatable{
  final String title;
  final String description;
  final bool completed;
  final DateTime? deadLine; // This is a nullable field // Contains both Date and Time information
  /*
    WORKING WITH DATES and TIMES
    final TimeOfDay? timeOfDay; // This just contains TIME information
    TimeOfDay.fromDateTime(deadLine);// Recover the time of a datetime object
    TimeOfDay.now(); // Recover the current time
    DateTime now = DateTime.now(); // Recover the current date and time
    TimeOfDay time = const TimeOfDay(hour: 13, minute: 30); // Recover the current time
    DateTime date = DateTime(now.year, now.month, now.day, time.hour, time.minute); // Recover the current date
   */


  const Todo({ // This is the constructor of the class
    required this.title,
    required this.description,
    this.completed = false,
    this.deadLine
  });

  // Let's create a method so that we can generate an updated copy of this object
  Todo copyWith({
    String? title,
    String? description,
    bool? completed,
    DateTime? deadLine
  }) {
    return Todo(
      title: title ?? this.title,
      description: description ?? this.description,
      completed: completed ?? this.completed,
      deadLine: deadLine ?? this.deadLine
    );
  }

  @override
  List<Object?> get props => [title, description, completed, deadLine];
}