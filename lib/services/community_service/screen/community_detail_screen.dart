import "package:flutter/material.dart";
import "package:flutter_reddit/core/constants/constants.dart";
import "package:flutter_reddit/services/auth/controller/auth_controller.dart";
import "package:flutter_reddit/services/community_service/controller/community_controller.dart";
import "package:flutter_reddit/theme/pallete.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:routemaster/routemaster.dart";

class CommunityDetailScreen extends ConsumerWidget {
  final String communityName;
  const CommunityDetailScreen({super.key, required this.communityName});

  void navigateToModsTools(BuildContext contx) {
    Routemaster.of(contx).push('/modtools');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;

    return Scaffold(
      backgroundColor: Pallete.backgroundColor,
      body: ref.watch(getCommunityByNameStreamProvider(communityName)).when(
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        error: (error, stackTrace) {
          print("error:" + error.toString());
        },
        data: (community) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: true,
                pinned: true,
                expandedHeight: 180,
                backgroundColor: Pallete.appBarColor,
                flexibleSpace: FlexibleSpaceBar(
                  title: const Text("Title"),
                  background: Image.asset(
                    Constants.communityDefaultBanner,
                    fit: BoxFit.cover,
                    height: 20,
                    width: 20,
                  ),
                ),
              ),
              SliverFillRemaining(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          maxRadius: 30,
                          child: Image.asset(
                            Constants.redditCommunityLogo,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "r/${community.name}",
                                style: const TextStyle(
                                    color: Pallete.textColor1,
                                    fontSize: Pallete.fontSize2,
                                    fontWeight: FontWeight.w900),
                              ),
                              community.mods.contains(user.uId)
                                  ? OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        side: const BorderSide(
                                            color: Pallete.borderColor1),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                      ),
                                      onPressed: () {
                                        navigateToModsTools(context);
                                      },
                                      child: const Text(
                                        "Mod Tools",
                                        style: TextStyle(
                                            fontSize: Pallete.fontSize1),
                                      ),
                                    )
                                  : OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                          side: const BorderSide(
                                            color: Pallete.borderColor1,
                                          ),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20)),
                                      onPressed: () {},
                                      child: Text(
                                        community.members.contains(user.uId)
                                            ? "Joined"
                                            : "Join",
                                        style: const TextStyle(
                                            fontSize: Pallete.fontSize2),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Text(
                            "${community.members.length} members",
                            style: const TextStyle(
                              color: Pallete.textColor1,
                              fontSize: Pallete.fontSize1,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
