import 'package:faircare/blocs/auth/login/login_bloc.dart';
import 'package:faircare/blocs/auth/progress/register_progress_cubit.dart';
import 'package:faircare/blocs/auth/register_cubit/register_cubit.dart';
import 'package:faircare/blocs/intro/progress/intro_progress_cubit.dart';
import 'package:faircare/blocs/master/navbar/nav_bar_cubit.dart';
import 'package:faircare/blocs/notifications/notifications/notifications_bloc.dart';
import 'package:faircare/blocs/search/available_tours_search_cubit.dart';
import 'package:faircare/blocs/search/my_tours_search_cubit.dart';
import 'package:faircare/blocs/user/user/user_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocProviders {
  static final List<BlocProvider> providers = [
    // intro
    BlocProvider<IntroProgressCubit>(
      create: (_) => IntroProgressCubit(),
    ),

    // login
    BlocProvider<LoginBloc>(
      create: (_) => LoginBloc(),
    ),

    // register
    BlocProvider<RegisterProgressCubit>(
      create: (_) => RegisterProgressCubit(),
    ),
    BlocProvider<RegisterCubit>(
      create: (_) => RegisterCubit(),
    ),

    // master
    BlocProvider<NavBarCubit>(
      create: (_) => NavBarCubit(),
    ),

    // tours
    BlocProvider<AvailableToursSearchCubit>(
      create: (_) => AvailableToursSearchCubit(),
    ),
    BlocProvider<MyToursSearchCubit>(
      create: (_) => MyToursSearchCubit(),
    ),

    // notifications
    BlocProvider<UserBloc>(
      create: (_) => UserBloc()..add(GetUserData()),
    ),

    // notifications
    BlocProvider<NotificationsBloc>(
      create: (_) => NotificationsBloc()..add(GetNotifications()),
    ),
  ];
}
