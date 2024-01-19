import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:transporte_escolar/app/models/app_user.dart';

class UserProvider extends ChangeNotifier {
  final FirebaseAuth _auth;
  final FirebaseFirestore _db;
  AppUser? _appUser;
  String? _lastError;

  AppUser? get user => _appUser;
  String? get lastError => _lastError;

  UserProvider(
      {FirebaseAuth? firebaseAuth, FirebaseFirestore? firebaseFirestore})
      : _auth = firebaseAuth ?? FirebaseAuth.instance,
        _db = firebaseFirestore ?? FirebaseFirestore.instance;

  Future<void> getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        final doc = await _db.collection('users').doc(user.uid).get();
        if (doc.exists) {
          _appUser = AppUser.fromJson(doc.data()!);
          notifyListeners();
        }
      }
    } catch (e) {
      _lastError = e.toString();
      notifyListeners();
    }
  }

  void clearLastError() {
    _lastError = null;
    notifyListeners();
  }
}
