import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:faircare/models/user_model.dart';
import 'package:faircare/repos/user/user_repo.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserDataInitial()) {
    on<GetUserData>(
      (event, emit) async {
        try {
          emit(UserDataLoading());
          final user = await UserRepo().getUserDetails();
          emit(UserDataLoaded(user));
        } catch (e) {
          emit(UserDataError(e.toString()));
        }
      },
    );
  }
}
