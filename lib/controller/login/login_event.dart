part of 'login_bloc.dart';

sealed class LoginEvent {}

final class LoginUser extends LoginEvent {
  final Map<String, String> loginData;

  LoginUser({required this.loginData});
}
