import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  CollectionReference collection(String path) => _db.collection(path);
  DocumentReference doc(String path) => _db.doc(path);

  Future<void> setData(
    String path,
    Map<String, dynamic> data, {
    bool merge = true,
  }) {
    return _db.doc(path).set(data, SetOptions(merge: merge));
  }

  Future<void> updateData(String path, Map<String, dynamic> data) {
    return _db.doc(path).update(data);
  }

  Future<void> deleteData(String path) {
    return _db.doc(path).delete();
  }

  Stream<DocumentSnapshot> streamDoc(String path) {
    return _db.doc(path).snapshots();
  }

  Stream<QuerySnapshot> streamCollection(String path) {
    return _db.collection(path).snapshots();
  }
}

final firestoreService = FirestoreService();
