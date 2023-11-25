import 'package:bloc/bloc.dart';
import 'package:faircare/global/enums.dart';

class MyToursSearchCubit extends Cubit<SearchState> {
  MyToursSearchCubit() : super(SearchState.none);

  void showSearch() {
    emit(SearchState.search);
  }

  void hideSearch() {
    emit(SearchState.none);
  }
}
