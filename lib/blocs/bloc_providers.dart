import 'package:faircare/blocs/auth/progress/register_progress_cubit.dart';
import 'package:faircare/blocs/auth/register_cubit/register_cubit.dart';
import 'package:faircare/blocs/intro/progress/intro_progress_cubit.dart';
import 'package:faircare/blocs/master/navbar/nav_bar_cubit.dart';
import 'package:faircare/blocs/sales/completed_tours/completed_tours_bloc.dart';
import 'package:faircare/blocs/search/available_tours_search_cubit.dart';
import 'package:faircare/blocs/search/my_tours_search_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocProviders {
  static final List<BlocProvider> providers = [
    BlocProvider<NavBarCubit>(
      create: (_) => NavBarCubit(),
    ),
    BlocProvider<RegisterProgressCubit>(
      create: (_) => RegisterProgressCubit(),
    ),
    BlocProvider<IntroProgressCubit>(
      create: (_) => IntroProgressCubit(),
    ),
    BlocProvider<AvailableToursSearchCubit>(
      create: (_) => AvailableToursSearchCubit(),
    ),
    BlocProvider<MyToursSearchCubit>(
      create: (_) => MyToursSearchCubit(),
    ),
    BlocProvider<RegisterCubit>(
      create: (_) => RegisterCubit(),
    ),
    BlocProvider<CompletedToursBloc>(
      create: (_) => CompletedToursBloc()..add(GetCompletedTours()),
    ),
  ];
}
