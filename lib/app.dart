import 'package:faircare/blocs/bloc_providers.dart';
import 'package:faircare/global/theme.dart';
import 'package:faircare/views/login/login.dart';
import 'package:faircare/views/master/master.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'api/api.dart';
import 'blocs/auth/login/login_bloc.dart';
import 'blocs/user/user/user_bloc.dart';

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
          future: Api.isLoggedIn(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
            }else if(snapshot.data!){
              return const MasterPage();
            }else{
              return const LoginPage();
            }
          },
        ),
        // home: const RequestVacationPage(),
      ),
    );
  }
}
