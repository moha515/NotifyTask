import 'package:flutter/material.dart';

void showTaskDetailsDialog(
    BuildContext context, Map<String, dynamic> taskDetails) {
   showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(taskDetails['title']),
        content: Text(
            'Date: ${taskDetails['date']}\nTime: ${taskDetails['time']}'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Close'),
          ),
        ],
      );
    });
}
