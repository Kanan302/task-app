import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task/core/constants/app_texts.dart';

part 'login_event.dart';
part 'login_state.dart';

// Login üçün BLoC (Business Logic Component) sinfi
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final FirebaseAuth _auth = FirebaseAuth.instance; // Firebase Auth instansı

  LoginBloc() : super(LoginInitial()) {
    // Login düyməsinə basıldığında baş verəcək hadisələri dinlə
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading()); // Yüklenme durumunu göstər

      try {
        // İstifadəçinin girişini həyata keçir
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        emit(LoginSuccess(userCredential)); // Giriş uğurlu oldu
      } on FirebaseAuthException catch (e) {
        // Giriş zamanı Firebase xətası baş verərsə
        if (e.code == 'user-not-found') {
          emit(const LoginFailure(AppTexts.notFoundUser)); // İstifadəçi tapılmadı
        } else if (e.code == 'wrong-password') {
          emit(const LoginFailure(AppTexts.wrongPassword)); // Yanlış şifrə
        } else {
          emit(LoginFailure('Giriş Uğursuz: ${e.message}')); // Başqa xətalar
        }
      } catch (e) {
        emit(const LoginFailure(AppTexts.unexpectedError)); // Gözlənilməz xətalar
      }
    });
  }
}
