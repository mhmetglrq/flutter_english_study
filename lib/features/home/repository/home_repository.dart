import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_english_study/core/models/group_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getMyGroupsFutureProvider = FutureProvider<List<GroupModel>>(
  (ref) async {
    final homeRepository = ref.read(homeRepositoryProvider);
    return await homeRepository.getMyGroups();
  },
);

final getAllGroupsFutureProvider = FutureProvider<List<GroupModel>>(
  (ref) async {
    final homeRepository = ref.read(homeRepositoryProvider);
    return homeRepository.getAllGroups();
  },
);

final homeRepositoryProvider = Provider<HomeRepository>(
  (ref) => HomeRepository(
    firebaseFirestore: FirebaseFirestore.instance,
    auth: FirebaseAuth.instance,
  ),
);

class HomeRepository {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth auth;

  HomeRepository({required this.firebaseFirestore, required this.auth});

  Future<List<GroupModel>> getAllGroups() async {
    List<GroupModel> groups = [];
    try {
      await firebaseFirestore.collection("groups").get().then(
        (value) {
          for (var doc in value.docs) {
            groups.add(GroupModel.fromMap(doc.data()));
          }
        },
      );
      return groups;
    } catch (e) {
      throw (Exception(e.toString()));
    }
  }

  Future<List<GroupModel>> getMyGroups() async {
    List<GroupModel> groups = [];
    try {
      await firebaseFirestore
          .collection("groups")
          .where("members", arrayContains: auth.currentUser!.uid)
          .get()
          .then(
        (value) {
          for (var doc in value.docs) {
            groups.add(GroupModel.fromMap(doc.data()));
          }
        },
      );
      return groups;
    } catch (e) {
      throw (Exception(e.toString()));
    }
  }
}
