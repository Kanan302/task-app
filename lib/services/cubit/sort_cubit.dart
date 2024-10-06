import 'package:bloc/bloc.dart';

class SortCubit extends Cubit<Map<String, dynamic>> {
  // Konstruktor: İlk vəziyyəti təyin edir (sıralama sütunu 'name', artan sıralama)
  SortCubit() : super({'sortColumn': 'name', 'ascending': true});

  // Sıralama metodu: İstədiyiniz sütuna görə sıralama edir
  void sort(String column) {
    final currentState = state; // Mövcud vəziyyət
    // Əgər seçilmiş sütun indiki sıralama sütununa bərabərdirsə
    if (currentState['sortColumn'] == column) {
      // Sıralama yönünü dəyişdirin
      emit({
        'sortColumn': column,
        'ascending': !currentState['ascending'],
      });
    } else {
      // Əks halda, yeni sütuna keçin və artan sıralama istifadə edin
      emit({
        'sortColumn': column,
        'ascending': true,
      });
    }
  }
}
