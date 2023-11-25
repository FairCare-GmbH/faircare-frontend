import 'package:bloc/bloc.dart';

class GettingStartedProgressCubit extends Cubit<int> {
  GettingStartedProgressCubit() : super(0);

  void setPage(int page) {
    emit(page);
  }
}
