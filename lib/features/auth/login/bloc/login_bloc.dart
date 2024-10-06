import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task/core/constants/app_texts.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());

      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        emit(LoginSuccess(userCredential));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          emit(const LoginFailure(AppTexts.notFoundUser));
        } else if (e.code == 'wrong-password') {
          emit(const LoginFailure(AppTexts.wrongPassword));
        } else {
          emit(LoginFailure('Giriş Uğursuz: ${e.message}'));
        }
      } catch (e) {
        emit(const LoginFailure(AppTexts.unexpectedError));
      }
    });
  }
}
