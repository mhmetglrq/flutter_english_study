import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/auth_repository.dart';

final authControllerProvider = Provider((ref) => AuthController(
      authRepository: ref.watch(authRepositoryProvider),
    ));

class AuthController {
  final AuthRepository authRepository;

  AuthController({required this.authRepository});

  Future<UserCredential?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      return await authRepository.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await authRepository.signUpWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> signOut() async {
    try {
      await authRepository.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }

  User? get currentUser {
    try {
      return authRepository.currentUser;
    } catch (e) {
      throw Exception(e);
    }
  }
}
