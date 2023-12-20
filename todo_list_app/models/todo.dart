
//---- DTO: Data Transfer Object / Model / Entity
// Let's define what a TO DO is
// Let's convert this model/entity in an inmutable class
import 'dart:ffi';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'todo.g.dart'; // This name is just a convention in flutter.
                    // g stands for generated
                    // this command is going to generate a file called todo.g.dart
                    // flutter pub run build_runner build
// this part statement tells dart that this file is part of the todo.g.dart file
// In other words, that both files: todo.dart and todo.g.dart are the same file
// And therefore, that the code in both files should be treated as if it was in the same file
// Private members of one file can be accessed from the other file

@HiveType(typeId: 0) // This is the type of the object To do in flutter. It should be a unique number in the app
class Todo extends Equatable{
  @HiveField(0) // This is the id of the object. It should be unique in the app
  final String id ; // This is the unique identifier of the object
  @HiveField(1) // This is the title of the object
  final String title;
  @HiveField(2) // This is the description of the object
  final String description;
  @HiveField(3) // This is the completed status of the object
  final bool completed;
  @HiveField(4) // This is the deadline of the object
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
    required this.id,
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
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      completed: completed ?? this.completed,
      deadLine: deadLine ?? this.deadLine
    );
  }

  @override
  List<Object?> get props => [id, title, description, completed, deadLine];

  // Factory method... it's kind a constructor...
  // but we have no guarantee that it will return a NEW object
  // It may return an already existing object... that flutter may have already
  // created... and is caching somewhere
  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
    id: "BACKEND_${json['id'] as int}",
    title: json['title'] as String,
    description: json['description'] as String,
    completed: json['completed'] as bool,
    deadLine: json['deadLine'] == null ? null : DateTime.parse(json['deadLine'] as String),
  );

}