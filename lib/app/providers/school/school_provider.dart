import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:transporte_escolar/app/models/school.dart';

class SchoolProvider extends ChangeNotifier {
  final FirebaseFirestore _firebaseFirestore;
  SchoolProvider({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  String? errorMessage;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  School? _school;
  School? get school => _school;
  set school(School? value) {
    _school = value;
    notifyListeners();
  }

  List<School> _schools = [];
  List<School> get schools => _schools;
  set schools(List<School> value) {
    _schools = value;
    notifyListeners();
  }

  Future<void> createSchool({required School school}) async {
    try {
      final doc =
          await _firebaseFirestore.collection('schools').add(school.toJson());
      school.id = doc.id;
      await _firebaseFirestore
          .collection('schools')
          .doc(doc.id)
          .set(school.toJson());
      _isLoading = true;
      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();
    }
  }

  Future<void> getSchool(String schoolId) async {
    try {
      final snapshot =
          await _firebaseFirestore.collection('schools').doc(schoolId).get();
      _school = School.fromJson(snapshot.data()!);
      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();
    }
  }

  Future<List<School>> getSchools() async {
    try {
      final snapshot = await _firebaseFirestore.collection('schools').get();
      _schools = snapshot.docs.map((e) => School.fromJson(e.data())).toList();
      return _schools;
    } catch (e) {
      errorMessage = e.toString();
      return [];
    }
  }

  Future<void> updateSchool({required School school}) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _firebaseFirestore
          .collection('schools')
          .doc(school.id)
          .update(school.toJson());
      _isLoading = false;

      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();
    }
  }

  Future<void> deleteSchool({required String schoolId}) async {
    try {
      await _firebaseFirestore.collection('schools').doc(schoolId).delete();
      _isLoading = true;
      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();
    }
  }

  Future<void> addItineraryToSchool(String itineraryId, String schoolId) async {
    await _firebaseFirestore.collection('schools').doc(schoolId).update({
      'itineraiesId': FieldValue.arrayUnion([itineraryId])
    });
    notifyListeners();
  }

  Future<void> removeItineraryFromSchool(
      String itineraryId, String schoolId) async {
    await _firebaseFirestore.collection('schools').doc(schoolId).update({
      'itineraiesId': FieldValue.arrayRemove([itineraryId])
    });
    notifyListeners();
  }

  Future<List<School>> getSchoolBySchoolMember(String schoolMemberId) async {
    try {
      final snapshot = await _firebaseFirestore
          .collection('schools')
          .where('appUserId', arrayContains: schoolMemberId)
          .get();
      _schools = snapshot.docs.map((e) => School.fromJson(e.data())).toList();
      return _schools;
    } catch (e) {
      errorMessage = e.toString();
      return [];
    }
  }

  Future<void> addUserToSchool(String userId, String schoolId) async {
    await _firebaseFirestore.collection('schools').doc(schoolId).update({
      'appUserId': FieldValue.arrayUnion([userId])
    });
  }

  Future<void> removeUserFromSchool(String userId, String schoolId) async {
    await _firebaseFirestore.collection('schools').doc(schoolId).update({
      'appUserId': FieldValue.arrayRemove([userId])
    });
  }
}
