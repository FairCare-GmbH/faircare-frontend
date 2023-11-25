import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:faircare/features/notifications/notification.model.dart';

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

abstract class NotificationsEvent extends Equatable {
  const NotificationsEvent();

  @override
  List<Object> get props => [];
}

class GetNotifications extends NotificationsEvent {}

abstract class NotificationsState extends Equatable {
  const NotificationsState();

  @override
  List<Object> get props => [];
}

class NotificationsInitial extends NotificationsState {}

class NotificationsLoading extends NotificationsState {}

class NotificationsLoaded extends NotificationsState {
  final List<NotificationModel> notifications;

  const NotificationsLoaded(this.notifications);
}

class NotificationsError extends NotificationsState {
  final String error;

  const NotificationsError(this.error);
}
