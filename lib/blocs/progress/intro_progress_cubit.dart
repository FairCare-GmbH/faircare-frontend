import 'package:bloc/bloc.dart';

class IntroProgressCubit extends Cubit<int> {
  IntroProgressCubit() : super(0);

  void setPage(int page) {
    emit(page);
  }
}
