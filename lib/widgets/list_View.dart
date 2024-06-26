import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:notifytask/DataBase/sqlflite.dart';
import 'package:notifytask/models/todo.dart';
import 'package:notifytask/screens/cubits/login_cubit/task_cubit.dart';

class TasksLists extends StatelessWidget {
  final Todo todo;
  final DateFormat dateFormatter = DateFormat('yyyy-MM-dd');
  final DateFormat timeFormatter = DateFormat('hh:mm a');
  TasksLists({required this.todo});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
              checkColor: Color(0xff00FF00),
              activeColor: Color(0xff00FF00),
              shape: CircleBorder(),
              value: todo.completed,
              onChanged: (newValue) {
                todo.completed = newValue!;
                context.read<TaskCubit>().updateTask(todo);
              },
            ),
            Container(
              width: 5,
              height: double.infinity,
              color: todo.completed ? Color(0xff00FF00) : Colors.red,
            ),
          ],
        ),
        title: Text(
          todo.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            decoration: todo.completed ? TextDecoration.lineThrough : null,
            fontSize: 22,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              todo.priority.toString() + ' Priority',
              style: TextStyle(fontSize: 20, color: Colors.grey),
            ),
            Text(
              dateFormatter.format(todo.createdTime) +
                  ' ' +
                  timeFormatter.format(todo.createdTime),
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                context.read<TaskCubit>().deleteTask(todo);
              },
            ),
          ],
        ),
        onTap: () async {
          DatabaseHelper().printAllTasks();
          if (todo.localId != null) {
            final taskDetails =
                await context.read<TaskCubit>().getTaskDetails(todo.localId!);
            if (taskDetails != null) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: Color(0xff9500FF),
                    title: Center(
                        child: Text(
                     'Alarm Time',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    )),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Text(
                          'Date: ' + dateFormatter.format(DateTime.parse(taskDetails['date']) ),
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        Text(
                          'Time: ' + taskDetails['time'],
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Close'),
                      ),
                    ],
                  );
                },
              );
            }
          }
        },
      ),
    );
  }
}
