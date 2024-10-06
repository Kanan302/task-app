part of 'register_bloc.dart'; 

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => []; 
}

// Qeydiyyat düyməsinə basıldığında baş verən hadisə
class RegisterButtonPressed extends RegisterEvent {
  final String email; // İstifadəçinin email adresi
  final String password; // İstifadəçinin şifrəsi

  const RegisterButtonPressed(this.email, this.password); 

  @override
  List<Object> get props => [email, password]; 
}
