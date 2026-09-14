import 'package:bloc/bloc.dart';


import '../../../core/utils/firebase_auth_service.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());


  Future<void> createAccount(
      String email,
      String password,
      ) async {
    emit(RegisterLoadingState());

    try {
      final success = await FirebaseAuthService.createAccount(
        email,
        password,
      );

      if (success) {
        emit(RegisterSuccessState());
      } else {
        emit(
          RegisterFailureState(
            'Email or password is incorrect.',
          ),
        );
      }
    } catch (e) {
      emit(
         RegisterFailureState(
          'Something went wrong.',
        ),
      );
    }
  }



}
