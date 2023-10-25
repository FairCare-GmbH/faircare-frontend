import 'package:faircare/blocs/auth/progress/register_progress_cubit.dart';
import 'package:faircare/blocs/auth/register_cubit/register_cubit.dart';
import 'package:faircare/blocs/available_tours/available_tours/available_tours_bloc.dart';
import 'package:faircare/blocs/intro/progress/intro_progress_cubit.dart';
import 'package:faircare/blocs/master/navbar/nav_bar_cubit.dart';
import 'package:faircare/blocs/my_tours/assigned_tours/assigned_tours_bloc.dart';
import 'package:faircare/blocs/my_tours/requested_tours/requested_tours_bloc.dart';
import 'package:faircare/blocs/notifications/notifications/notifications_bloc.dart';
import 'package:faircare/blocs/preferences/calendar_cubit/calendar_cubit.dart';
import 'package:faircare/blocs/preferences/preferences_cubit/preferences_cubit.dart';
import 'package:faircare/blocs/preferences/vacation_requests/vacation_requests_bloc.dart';
import 'package:faircare/blocs/sales/completed_tours/completed_tours_bloc.dart';
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
    BlocProvider<AvailableToursBloc>(
      create: (_) => AvailableToursBloc()..add(GetAvailableTours()),
    ),
    BlocProvider<AssignedToursBloc>(
      create: (_) => AssignedToursBloc()..add(GetAssignedTours()),
    ),
    BlocProvider<RequestedToursBloc>(
      create: (_) => RequestedToursBloc()..add(GetRequestedTours()),
    ),
    BlocProvider<CompletedToursBloc>(
      create: (_) => CompletedToursBloc()..add(GetCompletedTours()),
    ),

    // user
    BlocProvider<UserBloc>(
      create: (_) => UserBloc()..add(GetUserData()),
    ),

    // preferences
    BlocProvider<PreferencesCalendarCubit>(
      create: (_) => PreferencesCalendarCubit(),
    ),
    BlocProvider<PreferencesCubit>(
      create: (_) => PreferencesCubit(),
    ),
    BlocProvider<VacationRequestsBloc>(
      create: (_) => VacationRequestsBloc()..add(GetVacationRequests()),
    ),

    // notifications
    BlocProvider<NotificationsBloc>(
      create: (_) => NotificationsBloc()..add(GetNotifications()),
    ),
  ];
}
