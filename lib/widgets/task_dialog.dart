import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notifytask/helper/show_snack_bar.dart';
import 'package:notifytask/models/todo.dart';
import 'package:notifytask/screens/cubits/login_cubit/task_cubit.dart';

class CreateTaskDialog extends StatefulWidget {
  @override
  _CreateTaskDialogState createState() => _CreateTaskDialogState();
}

class _CreateTaskDialogState extends State<CreateTaskDialog> {
  final TextEditingController _taskNameController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  String priority = 'High';

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xff9500FF),
        borderRadius: BorderRadius.all(
          Radius.elliptical(60, 60),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Text(
                'Create a new task',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xffF1E2FF),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          TextField(
            style: TextStyle(color: Colors.white),
            controller: _taskNameController,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2)),
              hintText: 'Task name',
              hintStyle: TextStyle(color: Color(0xffF1E2FF), fontSize: 16),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none),
            ),
          ),
          SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15,
              ),
              Text(
                'Priority',
                style: TextStyle(color: Color(0xffF1E2FF), fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: ['High', 'Medium', 'Low', 'Very Low'].map((priority) {
                  return ChoiceChip(
                    label: Text(priority),
                    selected: this.priority == priority,
                    onSelected: (selected) {
                      setState(() {
                        this.priority = priority;
                      });
                    },
                    selectedColor: Colors.white,
                    backgroundColor: Color(0xff9500FF),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    side: BorderSide(
                      color: Colors.white,
                      width: 2,
                    ),
                    labelStyle: TextStyle(
                      color: this.priority == priority
                          ? Color(0xff9500FF)
                          : Color(0xffF1E2FF),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () async {
                  final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null && pickedDate != selectedDate) {
                    setState(() {
                      selectedDate = pickedDate;
                    });
                  }
                },
                child: Text(
                  'Select Date',
                  style: TextStyle(color: Color(0xffF1E2FF), fontSize: 16),
                ),
              ),
              Text(
                selectedDate.toString().substring(0, 10),
                style: TextStyle(color: Color(0xffF1E2FF), fontSize: 16),
              ),
              TextButton(
                onPressed: () async {
                  final TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: selectedTime,
                  );
                  if (pickedTime != null && pickedTime != selectedTime) {
                    setState(() {
                      selectedTime = pickedTime;
                    });
                  }
                },
                child: Text(
                  'Select Time',
                  style: TextStyle(color: Color(0xffF1E2FF), fontSize: 16),
                ),
              ),
              Text(
                selectedTime.format(context),
                style: TextStyle(color: Color(0xffF1E2FF), fontSize: 16),
              ),
            ],
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async {
              final now = DateTime.now();
              final selectedDateTime = DateTime(
                selectedDate.year,
                selectedDate.month,
                selectedDate.day,
                selectedTime.hour,
                selectedTime.minute,
              );
              if (_taskNameController.text.trim().isEmpty) {
                showSnackBar(context, 'Please enter a task name');
              } else if (selectedDateTime.isBefore(now)) {
                showSnackBar(
                    context, 'The schedule date must be in the future.');
              } else {
                final localId = await context.read<TaskCubit>().saveTaskDetails(
                    _taskNameController.text, selectedDate, selectedTime);
                Todo todo = Todo(
                  id: "",
                  title: _taskNameController.text,
                  completed: false,
                  createdTime: DateTime.now(),
                  localId: localId,
                  date: selectedDate,
                  time: selectedTime,
                  priority: priority,
                );

                await context.read<TaskCubit>().addTask(todo);

                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 252, 240, 240),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
            ),
            child: Text(
              '+ Create Task',
              style: TextStyle(
                color: Color(0xff9500FF),
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
