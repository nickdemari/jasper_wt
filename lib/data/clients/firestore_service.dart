import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jasper_wt/data/models/weight_log.dart';
import 'package:jasper_wt/data/service_locator.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static FirestoreService get instance => locator<FirestoreService>();

  Future<void> addData(Map<String, dynamic> data, String collectionName) async {
    try {
      // add data to the collection with the data id as the document id.
      await _firestore.collection(collectionName).doc(data['id']).set(data);
    } catch (e) {
      print('Error adding data: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getData(String collectionName) async {
    try {
      final snapshot = await _firestore.collection(collectionName).get();
      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print('Error getting data: $e');
      return [];
    }
  }

  Future<void> updateData(
    Map<String, dynamic> data,
    String collectionName,
    String documentId,
  ) async {
    try {
      await _firestore.collection(collectionName).doc(documentId).update(data);
    } catch (e) {
      print('Error updating data: $e');
    }
  }

  Future<void> deleteData(String collectionName, String documentId) async {
    try {
      await _firestore.collection(collectionName).doc(documentId).delete();
    } catch (e) {
      print('Error deleting data: $e');
    }
  }

  // sorted by most recent date.
  Stream<List<WeightLog>> getLogs() {
    return _firestore
        .collection('logs')
        .orderBy('dateTime', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return WeightLog.fromJson(doc.data());
      }).toList();
    });
  }
}
