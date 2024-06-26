import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:notifytask/screens/cubits/login_cubit/login_cubit.dart';
import 'package:notifytask/screens/cubits/login_cubit/task_cubit.dart';
import '../widgets/button_Dialog.dart';
import '../widgets/task_view.dart';

class Taskly extends StatefulWidget {
  static String id = 'task screen';
  @override
  State<Taskly> createState() => _TasklyState();
}

class _TasklyState extends State<Taskly> {
  late double _devheigt, _devwid;
  DateTime titTime = DateTime.now();
  User? currentUser;
  final DateFormat dateFormatter = DateFormat('yyyy.MM.dd');
  final DateFormat timeFormatter = DateFormat('hh:mm a');
  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    _devheigt = MediaQuery.of(context).size.height;
    _devwid = MediaQuery.of(context).size.width;
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Color(0xffF5F7FA),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsetsDirectional.only(start: 4),
                  child: Text(
                    dateFormatter.format(titTime) ,
                       
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(
                  height: 9,
                ),
                Container(
                  margin: EdgeInsetsDirectional.only(start: 4),
                  child: Text(
                    'Today Tasks',
                    style: TextStyle(color: Colors.black, fontSize: 25,fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            bottom: TabBar(
              labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              unselectedLabelStyle:
                  TextStyle(fontWeight: FontWeight.normal, fontSize: 18),
              tabs: [
                Tab(text: 'All'),
                Tab(text: 'Completed'),
                Tab(text: 'Uncompleted'),
              ],
            ),
            actions: [
              Builder(
                builder: (context) => IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                ),
              ),
            ],
          ),
          endDrawer: Drawer(
            child: Container(
              color: Color(0xffF5F7FA),
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: Color(0xff9500FF),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.person,
                            color: Color(0xff9500FF),
                            size: 30,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          currentUser?.email ?? 'User',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.home, color: Color(0xff9500FF)),
                    title: Text('Home'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.settings, color: Color(0xff9500FF)),
                    title: Text('Settings'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.logout, color: Color(0xff9500FF)),
                    title: Text('Logout'),
                    onTap: () async {
                      await context.read<LoginCubit>().logout(context);
                      context.read<TaskCubit>().clearTasks();
                      context.go('/');
                    },
                  ),
                ],
              ),
            ),
          ),
          body: TabBarView(children: [
            TaskView(
              taskType: TaskType.all,
            ),
            TaskView(
              taskType: TaskType.completed,
            ),
            TaskView(
              taskType: TaskType.uncompleted,
            )
          ]),
          floatingActionButton: ButtonDialog(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        ));
  }
}
