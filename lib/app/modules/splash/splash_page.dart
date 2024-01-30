import 'dart:async';

import 'package:flutter/material.dart';
import 'package:transporte_escolar/app/core/constants.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final splashDuration = const Duration(seconds: 3);
  late Timer _timer;
  bool loading = true;
  @override
  void initState() {
    super.initState();

    _timer = Timer(splashDuration, _navigate);
  }

  void _navigate() {
    splashDuration.inSeconds;
    setState(() {
      loading = false;
    });
    Navigator.of(context).pushReplacementNamed(Constants.loginRoute);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/bus.jpg'),
            const SizedBox(height: 20),
            const Text(
              'TRANSPORTE ESCOLAR',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(height: 20),
            const Text(
              'CRE-PARANOÁ',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const Divider(),
            loading
                ? Container(
                    margin: const EdgeInsets.only(top: 40),
                    child: const CircularProgressIndicator())
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
