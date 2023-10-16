import 'package:faircare/blocs/navbar/nav_bar_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocProviders {
  static final List<BlocProvider> providers = [
    BlocProvider<NavBarCubit>(create: (_) => NavBarCubit()),
  ];
}
