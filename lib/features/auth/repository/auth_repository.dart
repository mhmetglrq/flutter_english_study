import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_english_study/core/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository(
      firestore: FirebaseFirestore.instance,
      auth: FirebaseAuth.instance,
    ));

class AuthRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  AuthRepository({required this.firestore, required this.auth});

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then(
            (value) => addUserToFirestore(email: email, uid: value.user!.uid),
          );
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> addUserToFirestore({
    required String email,
    required String uid,
  }) async {
    try {
      final user = UserModel(email: email, uid: uid);
      await firestore.collection('users').doc(uid).set(user.toMap());
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<User?> get currentUser async {
    return auth.currentUser;
  }
}
