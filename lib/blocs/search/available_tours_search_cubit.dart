import 'package:bloc/bloc.dart';
import 'package:faircare/global/enums.dart';

class AvailableToursSearchCubit extends Cubit<SearchState> {
  AvailableToursSearchCubit() : super(SearchState.none);

  void showSearch() {
    emit(SearchState.search);
  }

  void hideSearch() {
    emit(SearchState.none);
  }
}
