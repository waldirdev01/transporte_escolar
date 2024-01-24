import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:transporte_escolar/app/models/itinerary.dart';

class ItineraryProvider extends ChangeNotifier {
  final FirebaseFirestore _firebaseFirestore;
  ItineraryProvider({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  String? errorMessage;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Itinerary? _itinerary;
  Itinerary? get itinerary => _itinerary;
  set itinerary(Itinerary? value) {
    _itinerary = value;
    notifyListeners();
  }

  List<Itinerary> _itineraries = [];
  List<Itinerary> get itineraries => _itineraries;
  set itinerarys(List<Itinerary> value) {
    _itineraries = value;
    notifyListeners();
  }

  Future<void> createItinerary({required Itinerary itinerary}) async {
    try {
      final doc = await _firebaseFirestore
          .collection('itineraries')
          .add(itinerary.toJson());
      itinerary.id = doc.id;
      await _firebaseFirestore
          .collection('itineraries')
          .doc(doc.id)
          .set(itinerary.toJson());
      _isLoading = true;
      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();
    }
  }

  Future<void> getitinerary(String itineraryId) async {
    try {
      final snapshot = await _firebaseFirestore
          .collection('itineraries')
          .doc(itineraryId)
          .get();
      _itinerary = Itinerary.fromJson(snapshot.data()!);
      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();
    }
  }

  Future<List<Itinerary>>? getitineraries() async {
    try {
      final snapshot = await _firebaseFirestore.collection('itineraries').get();

      _itineraries =
          snapshot.docs.map((e) => Itinerary.fromJson(e.data())).toList();
      return _itineraries;
    } catch (e) {
      errorMessage = e.toString();
      return [];
    }
  }

  Future<void> updateitinerary({required Itinerary itinerary}) async {
    try {
      await _firebaseFirestore
          .collection('itineraries')
          .doc(itinerary.id)
          .update(itinerary.toJson());
      _isLoading = true;
      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();
    }
  }

  Future<void> deleteitinerary({required String itineraryId}) async {
    try {
      await _firebaseFirestore
          .collection('itineraries')
          .doc(itineraryId)
          .delete();
      _isLoading = true;
      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();
    }
  }

  Future<List<Itinerary>> getItinerariesForSchool(String schoolId) async {
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance
            .collection('itineraries')
            .where('schoolIds', arrayContains: schoolId)
            .get();
    _itineraries = [];
    notifyListeners();

    for (final QueryDocumentSnapshot<Map<String, dynamic>> document
        in querySnapshot.docs) {
      _itineraries.add(Itinerary.fromJson(document.data()));
      notifyListeners();
    }

    return _itineraries;
  }

  Future<void> addSchoolToItinerary(String itineraryId, String schoolId) async {
    await _firebaseFirestore.collection('itineraries').doc(itineraryId).update({
      'schoolIds': FieldValue.arrayUnion([schoolId])
    });
  }

  Future<void> removeSchoolFromItinerary(
      String itineraryId, String schoolId) async {
    await _firebaseFirestore.collection('itineraries').doc(itineraryId).update({
      'schoolIds': FieldValue.arrayRemove([schoolId])
    });
  }
}
