import 'package:flutter/material.dart';

class TodoField {
  static const createdTime = 'createdTime';
}

class Todo {
  String id;
  String title;
  bool completed;
  DateTime createdTime;
  int? localId;
  final DateTime? date;
  final TimeOfDay? time; // Add localId
  String? priority;
  Todo({
    required this.id,
    required this.title,
    required this.completed,
    required this.createdTime,
    required this.priority,
    this.localId,
    this.date,
    this.time,
  });

  // Factory method to create a Todo from JSON
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      localId: json['localId'],
      createdTime: DateTime.parse(json['createdTime']),
      title: json['title'],
      id: json['id'],
      completed: json['isDone'],
      priority: json['priority'],
    );
  }

  // Convert Todo to JSON
  Map<String, dynamic> toJson() {
    return {
      'createdTime': createdTime.toIso8601String(),
      'title': title,
      'id': id,
      'isDone': completed,
      'localId': localId,
      'priority': priority,
    };
  }
}
