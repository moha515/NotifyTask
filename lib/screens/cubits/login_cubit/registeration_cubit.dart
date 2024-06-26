import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'registeration_state.dart';

class RegisterationCubit extends Cubit<RegisterationState> {
  RegisterationCubit() : super(RegisterationInitial());
  Future<void> registerUser(
      {required String email, required String password}) async {
    emit(RegistrationLoading());

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(RegistrationSuccess());
    } on FirebaseAuthException catch (e) {
      print(e);

      if (e.code == 'email-already-in-use') {
        emit(RegistrationFailure(errorMssg: 'Email already in use'));
      } else if (e.code == 'invalid-email') {
        emit(RegistrationFailure(errorMssg: 'Please Enter valid Email'));
      } 
      else if (e.code == 'weak-password') {
        emit(RegistrationFailure(errorMssg: 'The password should be more than 6 charchter'));
      } else {
        emit(RegistrationFailure(errorMssg: 'Registration failed'));
      }
    } catch (e) {
      emit(RegistrationFailure(errorMssg: 'Something went wrong'));
    }
  }
}
