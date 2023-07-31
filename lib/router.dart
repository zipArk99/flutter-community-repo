//there will be two types of routes

//loggedIn routes which can we accessed only and only if user is logged in
//loggedOut when user is loged out

import 'package:flutter/material.dart';
import 'package:flutter_reddit/services/auth/screen/login_screen.dart';
import 'package:flutter_reddit/services/community_service/screen/community_detail_screen.dart';
import 'package:flutter_reddit/services/community_service/screen/edit_community_screen.dart';
import 'package:flutter_reddit/services/community_service/screen/mod_tools_screen.dart';
import 'package:flutter_reddit/services/home/screen/drawer/user_profile_drawer.dart';
import 'package:flutter_reddit/services/home/screen/homescreen.dart';
import 'package:flutter_reddit/services/post/screen/add_post_type_screen.dart';
import 'package:routemaster/routemaster.dart';
import 'package:flutter_reddit/services/community_service/screen/create_community_screen.dart';

final loggedOutRoute = RouteMap(
  routes: {
    "/": (_) => MaterialPage(
          child: LoginScreen(),
        ),
  },
);
final loggedInRoute = RouteMap(routes: {
  "/": (route) => MaterialPage(child: HomePageScreen()),
  "/create-community": (route) => MaterialPage(child: CreateComumunityScreen()),
  "/community-details/:name": (route) => MaterialPage(
        child:
            CommunityDetailScreen(communityName: route.pathParameters['name']!),
      ),
  "/modtools/": (route) => MaterialPage(child: ModToolsScreen()),
  "/edit-community": (route) => MaterialPage(child: EditCommunityScreen()),
  "/profile":(route)=> const MaterialPage(child:UserProfileDrawer()),
  "/add-post-screen-type/:type": (route) => MaterialPage(
      child: AddPostTypeScreen(type: route.pathParameters['type']!)),
});
