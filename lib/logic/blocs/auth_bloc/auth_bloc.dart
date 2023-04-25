// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:studying_app/data/firebase_apis/fire_base_auth_api.dart';
import 'package:studying_app/data/models/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthInitial()) {
    on<SignInEvent>((event, emit) async {
      
      emit(const SignInLoadingState(loading: true));
      final firebaseApi = FirebaseAuthApi();
      await firebaseApi
          .signIn(email: event.email, password: event.password)
          .then((value) {
        emit(const SignInLoadingState(loading: false));
        if (value == 'user added') {
          emit(const SignInSuccessfullyState(signedIn: true));
        }
        //here we will work with the errors status
        //for each error we will push the error message
        else if (value == 'user-not-found') {
          //*value here will be the error message from the fire base exception.
          emit(
            const SignInErrorState(
                error: ' البريد الالكتروني للمستخدم غير صحيح'),
          );
        } else if (value == 'wrong-password') {
          emit(
            const SignInErrorState(error: 'كلمة المرور غير صالحه'),
          );
        } else if (value == 'invalid-email') {
          emit(
            const SignInErrorState(error: 'البريد الالكتروني غير صالح'),
          );
        }
        return null;
      });
    });

    on<RegistrationEvent>((event, emit) async {
      final firebaseApi = FirebaseAuthApi();
      emit(const RegisterLoadingState(loading: true));

      await firebaseApi.addNewUser(event.newUser).then((value) {
        emit(const RegisterLoadingState(loading: false));
        if (value == 'user created') {
          emit(const RegisterSuccessfullyState(registered: true));
        } else if (value == 'invalid-email') {
          //*value here will be the error message from the fire base exception.
          emit(
            const RegisterErrorState(
              error: 'البريد الالكتروني غير صالح',
            ),
          );
        } else if (value == 'email-already-in-use') {
          emit(
            const RegisterErrorState(
              error: 'المستخدم موجود بالفعل',
            ),
          );
        }
      });
    });

    on<SignOutEvent>((event, emit) async {
      final firebaseApi = FirebaseAuthApi();

      await firebaseApi.signOut().then((value) {
        if (value == 'You Sign Out') {
          emit(SignOutState(youSignOut: value));
        } else {
          emit(SignOutErrorState(youSignOut: value));
        }
      });
    });
  }
}
