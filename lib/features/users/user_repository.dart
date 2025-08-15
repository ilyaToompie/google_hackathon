import 'package:hackathon_google/core/services/firebase/firebase_auth_service.dart';
import 'package:hackathon_google/core/services/firebase/firestore_service.dart';
import 'package:hackathon_google/features/users/user_model.dart';

class UserRepository {
  final _usersCollection = firestoreService.collection('users');

  Future<UserModel?> getCurrentUser() async {
    final current = authService.currentUser;
    if (current == null) return null;
    final doc = await _usersCollection.doc(current.uid).get();
    if (!doc.exists) return null;
    return UserModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
  }

  Future<UserModel?> getUserByUid(String uid) async {
    final doc = await _usersCollection.doc(uid).get();
    if (!doc.exists) return null;
    return UserModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
  }
}

final userRepository = UserRepository();
