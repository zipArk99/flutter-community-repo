import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_reddit/models/community.dart';
import 'package:flutter_reddit/services/community_service/controller/community_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

import '../../../../core/constants/constants.dart';
import '../../../../theme/pallete.dart';

class CommunityDrawer extends ConsumerWidget {
  const CommunityDrawer({super.key});

  void navigateToCreateCommunityScreen(BuildContext contx) {
    Routemaster.of(contx).push('/create-community');
  }

  void navigateToCommunityDetailScreen(
      WidgetRef ref, BuildContext contx, Community community) {

    ref.read(communityProvider.notifier).update((state) => community);
    Routemaster.of(contx).push('/community-details/${community.name}');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Drawer(
        backgroundColor: Pallete.appBarColor,
        child: Column(
          children: [
            ListTile(
              onTap: () {
                navigateToCreateCommunityScreen(context);
              },
              leading: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              title: const Text(
                "Create a community",
                style: TextStyle(
                  fontSize: 15,
                  color: Pallete.textColor1,
                ),
              ),
            ),
            StreamBuilder(
              stream: ref
                  .watch(communityControllerProvider.notifier)
                  .getListOfCommunities(),
              builder: (context, snapshot) {
                final data = snapshot.data ?? [];
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {}
                return Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          onTap: () {
                            navigateToCommunityDetailScreen(
                              ref,
                              context,
                              data[index],
                            );
                          },
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey.shade600,
                            radius: 25,
                            child: Image.asset(
                              Constants.redditCommunityLogo,
                              width: 30,
                              color: Colors.white,
                              fit: BoxFit.contain,
                            ),
                          ),
                          title: Text(
                            "r/${data[index].name}",
                            style: const TextStyle(
                              color: Pallete.textColor1,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: data.length,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
