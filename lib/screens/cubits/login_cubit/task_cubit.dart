import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:notifytask/DataBase/firebase.dart';
import 'package:notifytask/DataBase/notification_service.dart';
import 'package:notifytask/DataBase/sqlflite.dart';
import 'package:notifytask/models/todo.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  final NotificationService _notificationService = NotificationService();

  TaskCubit() : super(TaskLoading()) {
    _notificationService.init();
  }

  Future<void> loadTasks() async {
    try {
      final List<Todo> tasks = await FirebaseApi.readTodos().first;
      emit(TaskLoaded(tasks));
    } catch (e) {
      emit(TaskError('Failed to load tasks'));
    }
  }

  Future<void> updateTask(Todo task) async {
    try {
      await FirebaseApi.updateTodo(task);
      loadTasks();
    } catch (e) {
      emit(TaskError('Failed to update task'));
    }
  }

  Future<void> deleteTask(Todo task) async {
    try {
      await FirebaseApi.deleteTodo(task);
      await _databaseHelper.deleteTask(task.localId!);
      loadTasks();
    } catch (e) {
      emit(TaskError('Failed to delete task'));
    }
  }

  Future<void> addTask(Todo task) async {
    try {
      await FirebaseApi.createTodo(task);
      if (task.localId != null) {
        await _notificationService.scheduleNotification(
          task.localId!,
          task.title,
          'You have a task scheduled',
          task.date!,
          task.time!,
        );
      }
      loadTasks();
    } catch (e) {
      emit(TaskError('Failed to add task: $e'));
    }
  }

  Future<int> saveTaskDetails(String title, DateTime date, TimeOfDay time) async {
    return await _databaseHelper.insertTask(title, date, time);
  }

  Future<Map<String, dynamic>?> getTaskDetails(int localId) async {
    return await _databaseHelper.getTask(localId);
  }
  void clearTasks() {
    emit(TaskLoaded([]));
  }
    List<Todo> getCompletedTasks(List<Todo> tasks) {
    return tasks.where((task) => task.completed).toList();
  }

  List<Todo> getUncompletedTasks(List<Todo> tasks) {
    return tasks.where((task) => !task.completed).toList();
  }
}
