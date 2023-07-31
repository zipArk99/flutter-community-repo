import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_reddit/core/provider/firebase_storage_repository.dart';
import 'package:flutter_reddit/models/community.dart';
import 'package:flutter_reddit/services/auth/controller/auth_controller.dart';
import 'package:flutter_reddit/services/community_service/repository/community_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

final communityControllerProvider =
    StateNotifierProvider<CommunityController, bool>(
  (ref) {
    return CommunityController(
      firebaseStorageRepository: ref.watch(firebaseStorageRepositoryProvider),
      communityRepository: ref.watch(communityRepositoryProvider),
      ref: ref,
    );
  },
);
final getCommunityByNameStreamProvider = StreamProvider.family((ref,
        String name) =>
    ref.watch(communityControllerProvider.notifier).getCommunityByName(name));
final communityProvider = StateProvider<Community?>((ref) => null);
final communityStreamProvider = StreamProvider<List<Community>>((ref) {
  return ref.watch(communityControllerProvider.notifier).getListOfCommunities();
});

final communitySerachStreamProvider =
    StreamProvider.family((ref, String query) {
  return ref.watch(communityControllerProvider.notifier).searchCommunity(query);
});

class CommunityController extends StateNotifier<bool> {
  final CommunityRepository _communityRepository;
  final Ref _ref;
  final FirebaseStorageRepository _firebaseStorageRepository;

  CommunityController(
      {required CommunityRepository communityRepository,
      required Ref ref,
      required FirebaseStorageRepository firebaseStorageRepository})
      : _communityRepository = communityRepository,
        _ref = ref,
        _firebaseStorageRepository = firebaseStorageRepository,
        super(false);

  String get userId {
    return _ref.read(userProvider)!.uId;
  }

  Community get getCommunity {
    final value = _ref.read(communityProvider);
    return value as Community;
  }

  Stream<Community> getCommunityByName(String name) {
    return _communityRepository.getCommunityByName(name);
  }

  Stream<List<Community>> getListOfCommunities() {
    return _communityRepository.getListOfCommunities(userId);
  }

  void editCommunity(
      {required File? communityBanner,
      required File? communityAvatar,
      required BuildContext contx}) async {
    Community com = getCommunity;

    state = true;
    if (communityBanner != null) {
      var res = await _firebaseStorageRepository.storeFile(
          bucket: "community/banner", id: com.name, file: communityBanner);
      res.fold(
        (l) => ScaffoldMessenger.of(contx)
            .showSnackBar(SnackBar(content: Text(l))),
        (r) => com = com.copyWith(
          banner: r,
        ),
      );
    }
    print("banner ${com.id}, ${com.banner}");
    if (communityAvatar != null) {
      var res = await _firebaseStorageRepository.storeFile(
          bucket: "community/avatar", id: com.name, file: communityAvatar);
      res.fold(
        (l) => ScaffoldMessenger.of(contx)
            .showSnackBar(SnackBar(content: Text(l))),
        (r) => com = com.copyWith(
          avatar: r,
        ),
      );
    }
    if (communityBanner != null || communityAvatar != null) {
      await _communityRepository.editCommunity(com);
    }
    state = false;
  }

  Stream<List<Community>> searchCommunity(String query) {
   return _communityRepository.searchCommunity(query);
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
    res.fold(
      (error) {
        ScaffoldMessenger.of(contx)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(error),
            ),
          );
      },
      (community) {
        Routemaster.of(contx).pop();
        ScaffoldMessenger.of(contx)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(
              content: Text("Community created successfully"),
            ),
          );
      },
    );
  }
}
