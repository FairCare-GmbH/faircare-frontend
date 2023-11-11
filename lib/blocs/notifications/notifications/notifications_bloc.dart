import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:faircare/models/notification_model.dart';

part 'notifications_event.dart';

part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  NotificationsBloc() : super(NotificationsInitial()) {
    on<GetNotifications>(
      (event, emit) async {
        try {
          emit(NotificationsLoading());
          //final notifications = await NotificationsRepo().getNotifications();//TODO implement
          //emit(NotificationsLoaded(notifications));
        } catch (e) {
          emit(NotificationsError(e.toString()));
        }
      },
    );
  }
}
