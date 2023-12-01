import 'package:jasper_wt/data/clients/firestore_service.dart';

import '../models/firebase_user.dart';
import '../service_locator.dart';

class UserRepository {
  final FirestoreService _firestore = locator<FirestoreService>();

  // service locator
  static UserRepository get instance => locator<UserRepository>();

  Future<void> saveUser(FirebaseUser user) async {
    await _firestore.addData(user.toJson(), 'users');
  }

  Future<FirebaseUser> getUser(String id) async {
    final data = await _firestore.getData('users');
    final user = data.firstWhere((user) => user['id'] == id);
    return FirebaseUser.fromJson(user);
  }
}
