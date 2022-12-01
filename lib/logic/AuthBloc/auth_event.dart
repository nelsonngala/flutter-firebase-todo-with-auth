part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class SignInEvent extends AuthEvent {
  final String email;
  final String password;
  const SignInEvent({
    required this.email,
    required this.password,
  });
  @override
  List<Object> get props => [email, password];
}

class SignUpEvent extends AuthEvent {
  final String email;
  final String password;
  const SignUpEvent({
    required this.email,
    required this.password,
  });
  @override
  List<Object> get props => [email, password];
}

class SignInWithGoogleEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class SignOutEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class ResetPasswordEvent extends AuthEvent {
  final String email;
  const ResetPasswordEvent({
    required this.email,
  });
  @override
  List<Object> get props => [email];
}
