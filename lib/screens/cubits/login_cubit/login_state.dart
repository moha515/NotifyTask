part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginSuccess extends LoginState {}

final class LoginLoading extends LoginState {}
final class LoggedOut extends LoginState {}

final class LoginFailure extends LoginState {
  String errorMssg;
  LoginFailure({required this.errorMssg});
}
