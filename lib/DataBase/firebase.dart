import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notifytask/models/todo.dart';

class FirebaseApi {
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static Stream<List<Todo>> readTodos() {
    final User? user = _auth.currentUser;
    if (user == null) {
      throw Exception("No user logged in");
    }

    return _firestore
        .collection('users')
        .doc(user.uid)
        .collection('tasks')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Todo.fromJson(doc.data())).toList());
  }

  static Future<void> createTodo(Todo todo) async {
    final User? user = _auth.currentUser;
    if (user == null) {
      throw Exception("No user logged in");
    }
    DocumentReference docRef = _firestore
        .collection('users')
        .doc(user.uid)
        .collection('tasks')
        .doc(); // This generates a new document ID

    todo.id = docRef.id; // Set the document ID in the todo object
    await docRef.set(todo.toJson());
  }

  static Future<void> updateTodo(Todo todo) async {
    final User? user = _auth.currentUser;
    if (user == null) {
      throw Exception("No user logged in");
    }

    await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('tasks')
        .doc(todo.id)
        .update(todo.toJson());
  }

  static Future<void> deleteTodo(Todo todo) async {
    final User? user = _auth.currentUser;
    if (user == null) {
      throw Exception("No user logged in");
    }

    await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('tasks')
        .doc(todo.id)
        .delete();
  }
}
