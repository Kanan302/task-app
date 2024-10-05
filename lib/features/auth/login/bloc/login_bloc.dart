import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
          emit(const LoginFailure('İstifadəçi tapılmadı'));
        } else if (e.code == 'wrong-password') {
          emit(const LoginFailure('Yanlış şifrə'));
        } else {
          emit(LoginFailure('Giriş Uğursuz: ${e.message}'));
        }
      } catch (e) {
        emit(const LoginFailure('Gözlənilməz bir xəta baş verdi'));
      }
    });
  }
}
