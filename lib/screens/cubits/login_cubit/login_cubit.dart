import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:notifytask/screens/cubits/login_cubit/task_cubit.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  Future<void> loginUser(
      {required String email, required String password, required BuildContext context}) async {
    try {
      emit(LoginLoading()); // Emit LoginLoading state to show loading indicator

      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      // Check if signInWithEmailAndPassword was successful
      if (userCredential.user != null) {
        emit(LoginSuccess());
                BlocProvider.of<TaskCubit>(context).loadTasks();
// Emit LoginSuccess state
      } else {
        emit(LoginFailure(
            errorMssg: 'Failed to sign in')); // Emit LoginFailure state
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      // Handle FirebaseAuthException
      if (e.code =='invalid-credential') {
        emit(LoginFailure(errorMssg: 'Invalid email or password'));
      } else if (e.code == 'invalid-email') {
        emit(LoginFailure(errorMssg: 'Please Enter valid Email'));
      } else {
        emit(LoginFailure(errorMssg: 'Authentication failed'));
      }
    } catch (e) {
      // Handle other exceptions
      emit(LoginFailure(errorMssg: 'Something went wrong'));
    }
  }Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    emit(LoginInitial());
    // Clear tasks on logout
    BlocProvider.of<TaskCubit>(context).clearTasks();
  }
  
 }

