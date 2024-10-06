part of 'reset_password_bloc.dart';

sealed class ResetPasswordEvent extends Equatable {
  const ResetPasswordEvent();

  @override
  List<Object> get props => [];
}

// Şifrənin sıfırlanması üçün tələb olunan hadisə
class ResetPasswordRequested extends ResetPasswordEvent {
  final String email; // İstifadəçinin daxil etdiyi email ünvanı

  const ResetPasswordRequested(this.email);

  @override
  List<Object> get props => [email];
}
