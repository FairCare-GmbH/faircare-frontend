import 'package:faircare/blocs/bloc_providers.dart';
import 'package:faircare/global/theme.dart';
import 'package:faircare/views/master/master.dart';
import 'package:faircare/views/register/register.dart';
import 'package:faircare/views/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
        home: const MasterPage(),
      ),
    );
  }
}
