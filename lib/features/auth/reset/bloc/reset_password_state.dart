part of 'reset_password_bloc.dart';

sealed class ResetPasswordState extends Equatable {
  const ResetPasswordState();
  
  @override
  List<Object> get props => [];
}

final class ResetPasswordInitial extends ResetPasswordState {}

// Sıfırlama prosesi yüklənir
class ResetPasswordLoading extends ResetPasswordState {
  @override
  List<Object> get props => [];
}

// Sıfırlama prosesi müvəffəqiyyətlə tamamlanmışdır
class ResetPasswordSuccess extends ResetPasswordState {
  @override
  List<Object> get props => [];
}

// Sıfırlama prosesi uğursuz olduqda bu vəziyyəti təqdim edir
class ResetPasswordFailure extends ResetPasswordState {
  final String error; // Xətanın mesajını saxlayır

  const ResetPasswordFailure(this.error);

  @override
  List<Object> get props => [error];
}