import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  Stream<QuerySnapshot> getTodos(String uid) {
    return users.doc(uid).collection('todos').orderBy('createdAt', descending: true).snapshots();
  }

  Future<void> addTodo(String uid, String title) async {
    await users.doc(uid).collection('todos').add({
      'title': title,
      'isDone': false,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> toggleTodo(String uid, String id, bool isDone) async {
    await users.doc(uid).collection('todos').doc(id).update({'isDone': isDone});
  }

  Future<void> deleteTodo(String uid, String id) async {
    await users.doc(uid).collection('todos').doc(id).delete();
  }
}
