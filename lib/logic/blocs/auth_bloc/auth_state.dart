part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial({isLoggedIn = false});
  @override
  List<Object> get props => [];
}

class SignInLoadingState extends AuthState {
  final bool loading;
  const SignInLoadingState({
    required this.loading,
  });
  @override
  List<Object> get props => [loading];
}

class SignInErrorState extends AuthState {
  final String? error;
  const SignInErrorState({
    required this.error,
  });
  @override
  List<Object> get props => [error!];
}

class SignInSuccessfullyState extends AuthState {
  final bool signedIn;
  const SignInSuccessfullyState({
    required this.signedIn,
  });

  @override
  List<Object> get props => [signedIn];
}

class RegisterLoadingState extends AuthState {
  final bool loading;
  const RegisterLoadingState({
    required this.loading,
  });
  @override
  List<Object> get props => [loading];
}

class RegisterErrorState extends AuthState {
  final String? error;
  const RegisterErrorState({
    required this.error,
  });
  @override
  List<Object> get props => [error!];
}

class RegisterSuccessfullyState extends AuthState {
  final bool registered;
  const RegisterSuccessfullyState({
    required this.registered,
  });
  @override
  List<Object> get props => [registered];
}

class SignOutState extends AuthState {
  final String? youSignOut;
  const SignOutState({required this.youSignOut});
}
class SignOutErrorState extends AuthState {
  final String? youSignOut;
  const SignOutErrorState({required this.youSignOut});
}
