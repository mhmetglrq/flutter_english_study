import 'package:flutter_english_study/features/home/repository/home_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeControllerProvider = Provider<HomeController>(
  (ref) => HomeController(
    homeRepository: ref.read(homeRepositoryProvider),
  ),
);

class HomeController {
  final HomeRepository homeRepository;

  HomeController({required this.homeRepository});

  Future<void> getAllGroups() async {
    await homeRepository.getAllGroups();
  }

  Future<void> getMyGroups() async {
    await homeRepository.getMyGroups();
  }

  Future<void> joinGroup(String groupUid) async {
    await homeRepository.joinGroup(groupUid);
  }

  Future<void> signOut() async {
    await homeRepository.signOut();
  }
}
