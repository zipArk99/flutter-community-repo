import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reddit/services/auth/controller/auth_controller.dart';
import 'package:flutter_reddit/services/community_service/controller/community_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/common/post_card.dart';
import '../post/controller/post_controller.dart';

class FeedScreen extends ConsumerWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    final isGuest = !user.isAuthenticated;

    return ref.watch(communityStreamProvider).when(
          data: (communities) => ref.watch(userPostsProvider(communities)).when(
                data: (data) {
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      final post = data[index];
                      return PostCard(post: post);
                    },
                  );
                },
                error: (error, stackTrace) {
                  if(kDebugMode)
                  print(error.toString());
                  return Container();
                },
                loading: () => const CircularProgressIndicator(),
              ),
          error: (error, stackTrace) => Container(),
          loading: () => const CircularProgressIndicator(),
        );
  }
}
