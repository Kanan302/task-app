import 'package:bloc/bloc.dart';

class SortCubit extends Cubit<Map<String, dynamic>> {
  SortCubit() : super({'sortColumn': 'name', 'ascending': true});

  void sort(String column) {
    final currentState = state;
    if (currentState['sortColumn'] == column) {
      emit({
        'sortColumn': column,
        'ascending': !currentState['ascending'],
      });
    } else {
      emit({
        'sortColumn': column,
        'ascending': true,
      });
    }
  }
}
