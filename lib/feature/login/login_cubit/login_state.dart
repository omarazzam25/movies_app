part of 'login_cubit.dart';


sealed class LoginState {}

final class LoginInitial extends LoginState {}
final class LoginSuccessState extends LoginState {}
final class LoginFailureState extends LoginState {
  final String message;
  LoginFailureState(this.message);

}
final class LoginLoadingState extends LoginState {}

final class ForgotPasswordSuccessState extends LoginState {}

final class SignOutSuccessState extends LoginState {}
