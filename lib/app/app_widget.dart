import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:transporte_escolar/app/core/constants.dart';
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
import 'modules/users/admin/manager_user_type.dart';
import 'modules/users/school_member/school_member_list.dart';
import 'modules/users/school_member/schools_by_school_member.dart';

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
          Constants.splashRoute: (context) => const SplashPage(),
          Constants.homeRoute: (context) => const HomePage(),
          Constants.loginRoute: (context) => const LoginPage(),
          Constants.registerRoute: (context) => const RegisterPage(),
          Constants.userRouteProfile: (context) =>
              const SelectUserProfilePage(),
          Constants.newUserRoute: (context) => const NewUserPage(),
          Constants.schoolCreateRoute: (context) => const SchoolCreateForm(),
          Constants.schoolListRoute: (context) => const SchoolList(),
          Constants.schoolEditRoute: (context) => SchoolEditForm(),
          Constants.schoolDetailsRoute: (context) => const SchoolDetailsPage(),
          Constants.itineraryCreateRoute: (context) =>
              const ItineraryCreateForm(),
          Constants.itinerariesListRoute: (context) => const ItineriesList(),
          Constants.itineraryEditRoute: (context) => const ItineraryEditForm(),
          Constants.itinerariesBySchoolRoute: (context) =>
              const ItinerariesBySchool(),
          Constants.schoolsBySchoolMemberRoute: (context) =>
              const SchoolsBySchoolMember(),
          Constants.managerUsersTypeRoute: (context) =>
              const ManagerUsersType(),
          Constants.schoolMembersList: (context) => const SchoolMembersList(),
        },
        home: const SplashPage());
  }
}
