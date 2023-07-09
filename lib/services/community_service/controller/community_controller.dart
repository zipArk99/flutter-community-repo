import 'package:flutter/material.dart';
import 'package:flutter_reddit/models/community.dart';
import 'package:flutter_reddit/services/auth/controller/auth_controller.dart';
import 'package:flutter_reddit/services/community_service/repository/community_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

final communityControllerProvider =
    StateNotifierProvider<CommunityController, bool>(
  (ref) {
    return CommunityController(
      communityRepository: ref.watch(communityRepositoryProvider),
      ref: ref,
    );
  },
);
final getCommunityByNameStreamProvider = StreamProvider.family((ref,
        String name) =>
    ref.watch(communityControllerProvider.notifier).getCommunityByName(name));
final communityProvider = StateProvider<Community?>((ref) =>null);
final communityStreamProvider = StreamProvider<List<Community>>((ref) {
  return ref.watch(communityControllerProvider.notifier).getListOfCommunities();
});

class CommunityController extends StateNotifier<bool> {
  final CommunityRepository _communityRepository;
  final Ref _ref;

  CommunityController(
      {required CommunityRepository communityRepository, required Ref ref})
      : _communityRepository = communityRepository,
        _ref = ref,
        super(false);


  String get userId {
    return _ref.read(userProvider)!.uId;
  }

  Stream<Community> getCommunityByName(String name) {
    return _communityRepository.getCommunityByName(name);
  }

  Stream<List<Community>> getListOfCommunities() {
   return _communityRepository.getListOfCommunities(userId);
   
   
  }


  

  void createCommunity(String name, BuildContext contx) async {
    state = true;

    Community community = Community(
      id: name,
      avatar: '',
      banner: '',
      members: [userId],
      mods: [userId],
      name: name,
    );
    var res = await _communityRepository.createCommunity(community);
    state = false;
    res.fold((error) {
      ScaffoldMessenger.of(contx)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(error),
          ),
        );
    }, (community) {
      Routemaster.of(contx).pop();
      ScaffoldMessenger.of(contx)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text("Community created successfully"),
          ),
        );
    });
  }
}
