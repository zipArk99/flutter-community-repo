import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reddit/core/constants/constants.dart';
import 'package:flutter_reddit/services/auth/controller/auth_controller.dart';
import 'package:flutter_reddit/theme/pallete.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'drawer/community_drawer.dart';

class HomePageScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext contx, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
  
    return Scaffold(
      backgroundColor: Pallete.backgroundColor,
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: Pallete.appBarColor,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
            iconSize:30,
          ),
          const SizedBox(
            width: 10,
          ),
          IconButton(
            splashRadius:25,
            onPressed: (){},
            icon: CircleAvatar(
              backgroundImage: NetworkImage(user.profilPic),
                  
              ),
          )
        ],
      ),
      drawer:const CommunityDrawer(),
      body: Center(
        child: Text(user.karma.toString()),
      ),
    );
  }
}
