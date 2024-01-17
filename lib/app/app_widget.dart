import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:transporte_escolar/app/modules/auth/login/login_page.dart';
import 'package:transporte_escolar/app/modules/auth/register/register_page.dart';
import 'package:transporte_escolar/app/modules/home/home_page.dart';
import 'package:transporte_escolar/app/modules/splash/splash_page.dart';
import 'package:transporte_escolar/app/modules/users/new_users/new_user_page.dart';
import 'package:transporte_escolar/app/modules/users/select_user_profile_page.dart';
import 'core/ui/app_ui_config.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Transporte Escolar',
        theme: AppUiConfig.themeCustom,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        routes: {
          '/splash': (context) => const SplashPage(),
          '/home': (context) => const HomePage(),
          '/login': (context) => const LoginPage(),
          '/register': (context) => const RegisterPage(),
          '/userrouteprofile': (context) => const SelectUserProfilePage(),
          '/newuser': (context) => const NewUserPage(),
        },
        home: const SplashPage());
  }
}
