part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

// Giriş düyməsinə basıldığında baş verən hadisə
class LoginButtonPressed extends LoginEvent {
  final String email; // İstifadəçi e-poçtu
  final String password; // İstifadəçi şifrəsi

  const LoginButtonPressed(this.email, this.password);

  @override
  List<Object> get props => [email, password]; // E-poçt və şifrəni props kimi qaytar
}
