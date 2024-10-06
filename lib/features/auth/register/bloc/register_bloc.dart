import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final FirebaseAuth _auth = FirebaseAuth.instance; // FirebaseAuth instansı

  RegisterBloc() : super(RegisterInitial()) {
    // İnsidentasiya
    on<RegisterButtonPressed>((event, emit) async {
      emit(RegisterLoading()); // Yüklənmə vəziyyətini işə sal

      try {
        // İstifadəçi qeydiyyatı üçün email və şifrə göndərilir
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        emit(RegisterSuccess(
            userCredential)); // Qeydiyyat uğurlu olduqda vəziyyəti yeniləyir
      } catch (e) {
        emit(RegisterFailure(
            e.toString())); // Qeydiyyat uğursuz olduqda xəta mesajını göndərir
      }
    });
  }
}
