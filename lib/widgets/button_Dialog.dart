import 'package:flutter/material.dart';

import 'package:notifytask/widgets/task_dialog.dart';

class ButtonDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      label: Text(
        '+  Create  Task',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
      backgroundColor: Color(0xff9500FF),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          barrierColor: Colors.transparent,
          enableDrag: true,
          builder: (BuildContext context) {
            return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: CreateTaskDialog(),
            );
          },
        );
      },
      elevation: 0,
    );
  }
}
