import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transporte_escolar/app/app_widget.dart';
import 'package:transporte_escolar/app/core/firebase_database/user_database/user_database.dart';
import 'package:transporte_escolar/app/providers/school/school_provider.dart';
import 'providers/user/app_user_provider.dart';

class AppModule extends StatelessWidget {
  const AppModule({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => FirebaseAuth.instance),
        Provider(create: (_) => FirebaseFirestore.instance),
        ChangeNotifierProvider(
          create: (context) => AppUserProvider(
            firebaseAuth: context.read(),
            firebaseFirestore: context.read(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => UserDatabase(
            firebaseAuth: context.read(),
            firebaseFirestore: context.read(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => SchoolProvider(
            firebaseFirestore: context.read(),
          ),
        ),
      ],
      child: const AppWidget(),
    );
  }
}
