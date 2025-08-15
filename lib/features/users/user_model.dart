import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppUser {
  final String uid;
  final String? email;
  final String? displayName;
  final String? photoUrl;

  AppUser({required this.uid, this.email, this.displayName, this.photoUrl});

  Map<String, dynamic> toMap() {
    return {'email': email, 'displayName': displayName, 'photoUrl': photoUrl};
  }

  factory AppUser.fromFirestore(DocumentSnapshot doc) {
    return AppUser(
      uid: doc.id,
      email: doc['email'] as String?,
      displayName: doc['displayName'] as String? ?? 'user',
      photoUrl: doc['photoUrl'] as String? ?? '',
    );
  }
}

Future<AppUser?> fetchUserByUid(String uid) async {
  final doc = await FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .get();

  if (!doc.exists) return null;

  return AppUser.fromFirestore(doc);
}

Future<AppUser?> loadUser() async {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) return null;
  return await fetchUserByUid(uid);
}
