import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:transporte_escolar/app/models/app_user.dart';

class AppUserProvider extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;

  AppUserProvider({
    required FirebaseAuth firebaseAuth,
    required FirebaseFirestore firebaseFirestore,
  })  : _firebaseAuth = firebaseAuth,
        _firebaseFirestore = firebaseFirestore;

  AppUser? _appUser;
  AppUser? get appUser => _appUser;
  bool _isLoginButtonEnabled = true;

  bool get isLoginButtonEnabled => _isLoginButtonEnabled;

  set isLoginButtonEnabled(bool value) {
    _isLoginButtonEnabled = value;
    notifyListeners();
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String userType,
  }) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final currentUser = _firebaseAuth.currentUser;
    if (currentUser != null) {
      _appUser = AppUser(
        id: currentUser.uid,
        name: name,
        email: email,
        phone: phone,
        userType: userType,
      );
      await _firebaseFirestore
          .collection('users')
          .doc(currentUser.uid)
          .set(_appUser!.toJson());
      notifyListeners();
    }
  }

  Future<AppUser?> login(String email, String password) async {
    isLoginButtonEnabled = false;
    final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    try {
      final appUserData = await _firebaseFirestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();
      if (appUserData.exists) {
        _appUser = AppUser.fromJson(appUserData.data()!);
        notifyListeners();
      } else {
        _appUser = null;
      }

      return _appUser;
    } catch (e) {
      return null;
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on PlatformException catch (e) {
      throw e.message ?? 'Erro ao enviar e-mail de recuperação de senha';
    }
  }

  Future<void> updateDisplayName(String name) async {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      await user.updateDisplayName(name);
      await user.reload();
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
    _appUser = null;
    notifyListeners();
  }
}
