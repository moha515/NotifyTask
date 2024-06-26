part of 'task_cubit.dart';

@immutable
sealed class TaskState {}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final List<Todo> tasks;

  TaskLoaded(this.tasks);
}

class TaskError extends TaskState {
  final String errorMessage;

  TaskError(this.errorMessage);
}

// Define events
abstract class TaskEvent {}

class LoadTasks extends TaskEvent {}

class AddTask extends TaskEvent {
  final Todo task;

  AddTask(this.task);
}

class UpdateTask extends TaskEvent {
  final Todo task;

  UpdateTask(this.task);
}

class DeleteTask extends TaskEvent {
  final Todo task;

  DeleteTask(this.task);
}
