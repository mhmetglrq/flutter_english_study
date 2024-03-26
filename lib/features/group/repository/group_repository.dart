import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_english_study/core/models/group_model.dart';
import 'package:flutter_english_study/core/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

final groupRepositoryProvider = Provider((ref) => GroupRepository(
      auth: FirebaseAuth.instance,
      firestore: FirebaseFirestore.instance,
    ));

class GroupRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  GroupRepository({required this.auth, required this.firestore});

  Future<void> createGroup(GroupModel group) async {
    final user = auth.currentUser;
    final uid = const Uuid().v4();
    group.uid = uid;
    group.members?.add(user!.uid);
    try {
      await firestore.collection('groups').doc(uid).set(group.toMap());
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<UserModel> getUser({required String uid}) async {
    final userDoc = await firestore.collection('users').doc(uid).get();
    return UserModel.fromMap(userDoc.data() as Map<String, dynamic>);
  }

  Future<UserModel> getCurrentUser() async {
    final user = auth.currentUser;
    final userDoc = await firestore.collection('users').doc(user!.uid).get();
    return UserModel.fromMap(userDoc.data() as Map<String, dynamic>);
  }

  Future<GroupModel> getGroup({required String uid}) async {
    final groupDoc = await firestore.collection('groups').doc(uid).get();
    return GroupModel.fromMap(groupDoc.data() as Map<String, dynamic>);
  }
}
