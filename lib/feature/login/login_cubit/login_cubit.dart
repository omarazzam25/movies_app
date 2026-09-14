import 'package:bloc/bloc.dart';

import '../../../core/utils/firebase_auth_service.dart';


part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> login(
      String email,
      String password,
      ) async {
    emit(LoginLoadingState());

    try {
      final success = await FirebaseAuthService.loginAccount(
        email,
        password,
      );

      if (success) {
        emit(LoginSuccessState());
      } else {
        emit(
           LoginFailureState(
            'Email or password is incorrect.',
          ),
        );
      }
    } catch (e) {
      emit(
         LoginFailureState(
          'Something went wrong.',
        ),
      );
    }
  }

  Future<void> loginWithGoogle() async {
    emit(LoginLoadingState());

    try {
      final result = await FirebaseAuthService.signInWithGoogle();

      if (result != null) {
        emit(LoginSuccessState());
      } else {
        emit(
          LoginFailureState(
            'Google login failed.',
          ),
        );
      }
    } catch (e) {
      emit(
        LoginFailureState(
          'Something went wrong.',
        ),
      );
    }
  }


  Future<void> forgotPassword(String email) async {
    emit(LoginLoadingState());

    try {
      final success = await FirebaseAuthService.forgotPassword(email);

      if (success) {
        emit(ForgotPasswordSuccessState());
      } else {
        emit(
          LoginFailureState(
            'Failed to send reset email.',
          ),
        );
      }
    } catch (e) {
      emit(
        LoginFailureState(
          'Something went wrong.',
        ),
      );
    }
  }


  Future<void> signOut() async {
    emit(LoginLoadingState());

    try {
      final success = await FirebaseAuthService.signOut();

      if (success) {
        emit(SignOutSuccessState());
      } else {
        emit(
          LoginFailureState(
            'Failed to sign out.',
          ),
        );
      }
    } catch (e) {
      emit(
        LoginFailureState(
          'Something went wrong.',
        ),
      );
    }
  }



}
