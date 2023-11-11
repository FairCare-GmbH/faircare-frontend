import 'package:faircare/blocs/bloc_providers.dart';
import 'package:faircare/global/theme.dart';
import 'package:faircare/views/login/login.dart';
import 'package:faircare/views/master/master.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'api/api.dart';

class FaircareApp extends StatelessWidget {
  const FaircareApp({Key? key}) : super(key: key);

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
                children: [
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text('Lädt...'),
                  )
                ],
              ));
            } else if (snapshot.data!) {
              return const MasterPage();
            } else {
              return const LoginPage();
            }
          },
        ),
        // home: const RequestVacationPage(),
      ),
    );
  }
}
