import 'package:bloc/bloc.dart';

class RegisterProgressCubit extends Cubit<int> {
  RegisterProgressCubit() : super(0);

  void setPage(int page) {
    emit(page);
  }
}
