import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:transporte_escolar/app/modules/auth/login/login_page.dart';
import 'package:transporte_escolar/app/modules/auth/register/register_page.dart';
import 'package:transporte_escolar/app/modules/home/home_page.dart';
import 'package:transporte_escolar/app/modules/itineray/itineraies_list.dart';
import 'package:transporte_escolar/app/modules/itineray/itineraries_by_school.dart';
import 'package:transporte_escolar/app/modules/itineray/itinerary_create_form.dart';
import 'package:transporte_escolar/app/modules/itineray/itinerary_edit_form.dart';
import 'package:transporte_escolar/app/modules/school/school_create_form.dart';
import 'package:transporte_escolar/app/modules/school/school_details_page.dart';
import 'package:transporte_escolar/app/modules/school/school_edit_form.dart';
import 'package:transporte_escolar/app/modules/splash/splash_page.dart';
import 'package:transporte_escolar/app/modules/users/new_users/new_user_page.dart';
import 'package:transporte_escolar/app/modules/users/select_user_profile_page.dart';
import 'core/ui/app_ui_config.dart';
import 'modules/school/school_list.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
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
          '/schoolcreate': (context) => const SchoolCreateForm(),
          '/schoollist': (context) => const SchoolList(),
          '/schooledit': (context) => SchoolEditForm(),
          '/schooldetails': (context) => const SchoolDetailsPage(),
          '/itinerarycreate': (context) => const ItineraryCreateForm(),
          '/itinerarieslist': (context) => const ItineriesList(),
          '/itineraryedit': (context) => const ItineraryEditForm(),
          '/itinerariesBySchool': (context) => const ItinerariesBySchool(),
        },
        home: const SplashPage());
  }
}
