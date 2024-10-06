import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  final FirebaseAuth? _firebaseAuth;

  ResetPasswordBloc({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth,
        super(ResetPasswordInitial()) {
    on<ResetPasswordRequested>(_onResetPasswordRequested);
  }

  // Şifrənin sıfırlanması üçün tələb olunan hadisəni emal edən metod
  Future<void> _onResetPasswordRequested(
      ResetPasswordRequested event, Emitter<ResetPasswordState> emit) async {
    emit(ResetPasswordLoading()); // Yüklənmə vəziyyətini təqdim et
    try {
      await _firebaseAuth!.sendPasswordResetEmail(email: event.email);
      emit(ResetPasswordSuccess()); // Müvəffəqiyyətli vəziyyəti təqdim et
    } catch (error) {
      emit(ResetPasswordFailure(
          error.toString())); // Uğursuz vəziyyəti təqdim et
    }
  }
}
