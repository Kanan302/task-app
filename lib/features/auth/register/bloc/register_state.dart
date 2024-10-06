part of 'register_bloc.dart';

sealed class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

final class RegisterInitial extends RegisterState {}

// Yüklənmə vəziyyəti
class RegisterLoading extends RegisterState {}

// Qeydiyyat uğurlu olduqda vəziyyət
class RegisterSuccess extends RegisterState {
  final UserCredential userCredential; // İstifadəçi məlumatlarını saxlayan sahə

  const RegisterSuccess(this.userCredential);

  @override
  List<Object> get props => [
        userCredential
      ]; // İstifadəçi məlumatları ilə müqayisə üçün siyahı qaytarır.
}

// Qeydiyyat zamanı xəta baş verərsə vəziyyət
class RegisterFailure extends RegisterState {
  final String error; // Səhv mesajı saxlayan sahə

  const RegisterFailure(this.error);

  @override
  List<Object> get props =>
      [error]; // Səhv mesajı ilə müqayisə üçün siyahı qaytarır.
}
