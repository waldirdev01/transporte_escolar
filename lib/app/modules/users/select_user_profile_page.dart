// ignore_for_file: constant_pattern_never_matches_value_type

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transporte_escolar/app/core/firebase_database/user_database/user_database.dart';
import 'package:transporte_escolar/app/models/app_user.dart';
import 'package:transporte_escolar/app/providers/user/app_user_provider.dart';

class SelectUserProfilePage extends StatefulWidget {
  const SelectUserProfilePage({Key? key}) : super(key: key);

  @override
  createState() => _SelectUserProfilePageState();
}

class _SelectUserProfilePageState extends State<SelectUserProfilePage> {
  late int timeLoading;
  Duration splashDuration = const Duration(seconds: 5);
  late Timer _timer;
  bool loading = true;
  @override
  void initState() {
    super.initState();

    _timer = Timer(splashDuration, _navigate);
  }

  void _navigate() {
    final appUser = context.read<UserDatabase>().user;

    if (appUser != null) {
      switch (appUser.userType) {
        case UserType.newUser:
          setState(() {
            loading = false;
          });
          break;
        case UserType.monitor:
          break;
        case UserType.admin:
          break;

        case UserType.coordinator:
          break;
      }
    } else {
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20),
            height: 200,
            child: Image.asset('assets/images/bus.jpg'),
          ),
          Positioned(
              top: 100,
              left: MediaQuery.of(context).size.width / 12,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'TRANSPORTE ESCOLAR POLLO',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Divider(),
                  Text(
                    'CRE-PARANOÁ',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ],
              )),
          Positioned(
            right: MediaQuery.of(context).size.width / 5,
            bottom: 60,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Seja bem-vindo(a)!',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  loading
                      ? const Text(
                          'Aguarde a aprovação do seu cadastro.',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        ),
                  const Divider(),
                  TextButton(
                      onPressed: () {
                        context.read<AppUserProvider>().logout();
                        Navigator.of(context).pushReplacementNamed('/login');
                      },
                      child: const Text(
                        'SAIR',
                        style: TextStyle(fontSize: 24),
                      ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
