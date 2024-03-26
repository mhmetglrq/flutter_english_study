import 'package:flutter_english_study/core/models/group_model.dart';
import 'package:flutter_english_study/core/models/user_model.dart';
import 'package:flutter_english_study/features/group/repository/group_repository.dart';
import 'package:flutter_english_study/features/home/repository/home_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final groupControllerProvider = Provider((ref) => GroupController(
      groupRepository: ref.read(groupRepositoryProvider),
      ref: ref,
    ));

final getGroupFutureProvider =
    FutureProvider.autoDispose.family<GroupModel, String>((ref, uid) async {
  final group = await ref.read(groupControllerProvider).getGroup(uid: uid);
  return group;
});

class GroupController {
  final GroupRepository groupRepository;
  ProviderRef ref;

  GroupController({required this.groupRepository, required this.ref});

  Future<void> createGroup(GroupModel group) async {
    await groupRepository.createGroup(group);
    ref.refresh(getMyGroupsFutureProvider);
    ref.refresh(getAllGroupsFutureProvider);
  }

  Future<UserModel> getUser({required String uid}) async {
    return await groupRepository.getUser(uid: uid);
  }

  Future<UserModel> getCurrentUser() async {
    return await groupRepository.getCurrentUser();
  }

  Future<GroupModel> getGroup({required String uid}) async {
    return await groupRepository.getGroup(uid: uid);
  }
}
