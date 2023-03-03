part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class LoginInit extends AuthState {}

class LoginSuccessful extends AuthState {
  final User user;

  const LoginSuccessful(this.user);
}

class LoginFailed extends AuthState {
  final String message;

  const LoginFailed(this.message);
}
