part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

// Başlanğıc vəziyyəti
final class LoginInitial extends LoginState {}

// Yüklenme vəziyyəti
class LoginLoading extends LoginState {}

// Giriş uğurlu olduqda vəziyyət
class LoginSuccess extends LoginState {
  final UserCredential
      userCredential; // Uğurlu giriş üçün istifadəçi kredensialı

  const LoginSuccess(this.userCredential); // UserCredential-i props kimi qaytar

  @override
  List<Object> get props => [userCredential];
}

// Giriş zamanı xəta baş verərsə vəziyyət
class LoginFailure extends LoginState {
  final String error; // Xəta mesajı

  const LoginFailure(this.error);

  @override
  List<Object> get props => [error]; // Xəta mesajını props kimi qaytar
}
