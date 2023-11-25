import 'package:faircare/blocs/bloc_providers.dart';
import 'package:faircare/global/theme.dart';
import 'package:faircare/features/users/login/login.view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'api/api.dart';
import 'features/navigation/navigation.view.dart';
import 'global/colors.dart';

class FairCareApp extends StatelessWidget {
  const FairCareApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: BlocProviders.providers,
      child: MaterialApp(
        title: 'Faircare',
        debugShowCheckedModeBanner: false,
        theme: themeData,
        locale: const Locale('de'),
        supportedLocales: const [Locale('de')],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home: FutureBuilder<bool>(
          future: Api.isLoggedIn()
              .onError((error, stackTrace) =>
                  false) //TODO log error to figure out why this doesnt' work sometimes. also establish why login request sent twice on startup
              .timeout(const Duration(milliseconds: 3500),
                  onTimeout: () => false),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                  child: Column(
                //mainAxisAlsignment: MainAxisAlignment.center,//TODO was this necessary? not sure why this suddenly wasn't available. perhaps because of the upgrade to the dart SDK (3.0)
                children: [SafeArea(
                  child: Scaffold(
                    backgroundColor: MyColors.white,
                    //TODO rest of splash screen
                  ),
                )],
              ));
            } else if (snapshot.data!) {
              return const NavigationView();
            } else {
              return const LoginView();
            }
          },
        ),
        // home: const RequestVacationPage(),
      ),
    );
  }
}
