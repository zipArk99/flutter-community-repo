import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_reddit/core/constants/firebase_constants.dart';
import 'package:flutter_reddit/models/community.dart';
import 'package:flutter_reddit/services/auth/controller/auth_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import '../../../typedefs/exception_typedefs.dart';

final communityRepositoryProvider =
    Provider((ref) => CommunityRepository(ref: ref));

class CommunityRepository {
  Ref _ref;

  CommunityRepository({
    required Ref ref,
  }) : _ref = ref;

  CollectionReference get _fireBaseCommunityCollection {
    return FirebaseFirestore.instance
        .collection(FirebaseConstants.communityCollection);
  }

  FutureVoid createCommunity(Community community) async {
    try {
      var communityDoc =
          await _fireBaseCommunityCollection.doc(community.name).get();
      if (communityDoc.exists) {
        throw "Community already exists!";
      } else {
        return Right(
          _fireBaseCommunityCollection
              .doc(community.name)
              .set(community.toMap()),
        );
      }
    } catch (e) {
      return left(e.toString());
    }
  }

  FutureVoid editCommunity(Community community) async {
    try {
      print("community::"+community.banner);
      return right(
        _fireBaseCommunityCollection.doc(community.name).update(
              community.toMap(),
            ),
      );
    } catch (error) {
      return left(error.toString());
    }
  }

  Stream<List<Community>> getListOfCommunities(String userId) {
    return _fireBaseCommunityCollection
        .where("members", arrayContains: userId)
        .snapshots()
        .map((event) {
      List<Community> comm = [];

      for (var doc in event.docs) {
        comm.add(Community.fromMap(doc.data() as Map<String, dynamic>));
      }
      return comm;
    });
  }

  Stream<List<Community>> searchCommunity(String query)    {
    return _fireBaseCommunityCollection.where('id',isGreaterThanOrEqualTo: query).where('id',isLessThan: query+'z').snapshots().map((event){
      List<Community> communities=[];

      for(var doc in event.docs){
        Community com=Community.fromMap(doc.data() as Map<String,dynamic>);
        communities.add(com);
      }
      return communities;

    });
  }

  Stream<Community> getCommunityByName(String name) {
    return _fireBaseCommunityCollection.doc(name).snapshots().map((event) {
      return Community.fromMap(event.data() as Map<String, dynamic>);
    });
  }
}
