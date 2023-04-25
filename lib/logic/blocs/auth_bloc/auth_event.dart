part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
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

class SignOutEvent extends AuthEvent {
  @override
  List<Object> get props => [];
}

class RegistrationEvent extends AuthEvent {  
  final MyUser newUser;
  const RegistrationEvent({
    required this.newUser
  });
  @override
  List<Object> get props => [
       newUser
      ];
}
