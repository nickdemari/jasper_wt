import 'package:jasper_wt/data/models/weight_log.dart';

import '../clients/firestore_service.dart';
import '../service_locator.dart';

class LogRepository {
  final FirestoreService _firestore = locator<FirestoreService>();

  Stream<List<WeightLog>> getLogs() {
    return _firestore.getLogs();
  }

  Future<void> addLog(Map<String, dynamic> data) async {
    await _firestore.addData(data, 'logs');
  }

  Future<void> updateLog(Map<String, dynamic> data, String documentId) async {
    await _firestore.updateData(data, 'logs', documentId);
  }

  Future<void> deleteLog(String documentId) async {
    await _firestore.deleteData('logs', documentId);
  }
}
