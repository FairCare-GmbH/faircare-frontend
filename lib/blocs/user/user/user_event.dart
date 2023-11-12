part of 'user_bloc.dart';

abstract class UserEvent {
  UserEvent();
}

class GetUserData extends UserEvent {}
