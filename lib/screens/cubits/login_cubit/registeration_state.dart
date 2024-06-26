part of 'registeration_cubit.dart';

@immutable
sealed class RegisterationState {}

final class RegisterationInitial extends RegisterationState {}
class RegistrationInitial extends RegisterationState {}

class RegistrationLoading extends RegisterationState {}

class RegistrationSuccess extends RegisterationState {}

class RegistrationFailure extends RegisterationState {
  final String errorMssg;

  RegistrationFailure({required this.errorMssg});
}