import 'package:go_router/go_router.dart';
import 'package:notifytask/screens/Task_screen.dart';
import 'package:notifytask/screens/login_screen.dart';
import 'package:notifytask/screens/registeration_screen.dart';

class Routes {
  final GoRouter _router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: '/tasks',
        builder: (context, state) => Taskly(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => RegistrationScreen(),
      ),
    ],
  );
  GoRouter get router => _router;
}
