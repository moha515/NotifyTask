import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notifytask/screens/cubits/login_cubit/task_cubit.dart';
import 'package:notifytask/widgets/list_View.dart';
import '../models/todo.dart';
import '../DataBase/sqlflite.dart';

enum TaskType { all, completed, uncompleted }

class TaskView extends StatefulWidget {
  final TaskType taskType;
  TaskView({required this.taskType});
  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  bool selectAll = false;
  List<Todo> selectedTasks = [];
 Future<void> _refreshTasks() async {
    context.read<TaskCubit>().loadTasks();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          if (state is TaskLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is TaskError) {
            return Center(child: Text(state.errorMessage));
          } else if (state is TaskLoaded) {
            List<Todo> tasks = state.tasks;
            if (tasks.isEmpty) {
              return Center(child: Text('No todos found.'));
            }
            if (widget.taskType == TaskType.completed) {
              tasks = context.read<TaskCubit>().getCompletedTasks(tasks);
            } else if (widget.taskType == TaskType.uncompleted) {
              tasks = context.read<TaskCubit>().getUncompletedTasks(tasks);
            }
            return Column(
              children: [
            
                Expanded(
                  child: RefreshIndicator(onRefresh:     _refreshTasks
,
                    child: ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        Todo todo = tasks[index];
                        bool isSelected = selectedTasks.contains(todo);
                    
                        return TasksLists(todo: todo);
                      },
                    ),
                  ),
                ),
              ],
            );
          }
          return Center();
        },
      ),
    );
  }
}
