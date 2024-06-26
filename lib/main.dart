import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notifytask/firebase_options.dart';
import 'package:notifytask/routes.dart';
import 'package:notifytask/screens/cubits/login_cubit/login_cubit.dart';
import 'package:notifytask/screens/cubits/login_cubit/registeration_cubit.dart';
import 'package:notifytask/screens/cubits/login_cubit/task_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(TaskApp());
}

class TaskApp extends StatelessWidget {
  final Routes _routes = Routes();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<TaskCubit>(
            create: (context) => TaskCubit()..loadTasks(),
          ),
          BlocProvider<RegisterationCubit>(
            create: (context) => RegisterationCubit(),
          ),
          BlocProvider<LoginCubit>(
            create: (context) => LoginCubit(),
          ),
        ],
        child: MaterialApp.router(
          routeInformationParser: _routes.router.routeInformationParser,
          routerDelegate: _routes.router.routerDelegate,
          routeInformationProvider: _routes.router.routeInformationProvider,
          debugShowCheckedModeBanner: false,
        ));
  }
}
