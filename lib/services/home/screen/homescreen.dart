import 'package:flutter/material.dart';
import 'package:flutter_reddit/services/auth/controller/auth_controller.dart';
import 'package:flutter_reddit/services/home/delegates/search_community_delegate.dart';
import 'package:flutter_reddit/services/home/screen/drawer/user_profile_drawer.dart';
import 'package:flutter_reddit/theme/pallete.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

import '../../feed/feed_screen.dart';
import '../../post/screen/add_post_screen.dart';
import 'drawer/community_drawer.dart';


final selectIndex=StateProvider<int>((ref) =>0);
class HomePageScreen extends ConsumerWidget {

int _selectedIndex=0;
  HomePageScreen({super.key});
  void openEndDrawer(BuildContext context) {
    Routemaster.of(context).push("/profile");
  }

  static const List<Widget> _page=<Widget>[
    FeedScreen(),
    AddPostScreen(),

  ];
  
  void OnTapped(WidgetRef ref,int index){
    ref.watch(selectIndex.notifier).update((state) => index);
  }
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    final selectIdx = ref.watch(selectIndex);

    return Scaffold(
      //key: _scaffoldState,
      drawerEnableOpenDragGesture: false,
      backgroundColor: Pallete.backgroundColor,

      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: CommunitySearch(ref: ref));
            },
            icon: const Icon(Icons.search),
            iconSize: 30,
          ),
          const SizedBox(
            width: 10,
          ),
          IconButton(
            splashRadius: 25,
            onPressed: () => openEndDrawer(context),
            icon: CircleAvatar(
              backgroundImage: NetworkImage(user.profilPic),
            ),
          )
        ],
      ),
      drawer: const CommunityDrawer(),

      body:_page.elementAt(selectIdx),
      bottomNavigationBar: BottomNavigationBar(

        selectedItemColor:Colors.green,
        currentIndex: _selectedIndex,
        onTap:(index){
          OnTapped(ref, index);
        },
        items:const [
           BottomNavigationBarItem(icon: Icon(Icons.home),label:'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.add),label:'Add Post')
        ],
      ),
    );
  }
}
