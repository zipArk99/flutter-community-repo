import 'package:flutter/material.dart';
import 'package:flutter_reddit/services/auth/controller/auth_controller.dart';
import 'package:flutter_reddit/theme/pallete.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserProfileDrawer extends ConsumerWidget {
  const UserProfileDrawer({super.key});

  void signOut(WidgetRef ref) {
    ref.watch(authControllerProvider.notifier).signOutUser();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(userProvider)!;
    return Scaffold(
      backgroundColor:Pallete.backgroundColor,
      appBar: AppBar(
        title:const Text('Profile'),
        backgroundColor: Pallete.appBarColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              height:20,
            ),
            CircleAvatar(
              backgroundImage: NetworkImage(user.profilPic),
              radius: 60,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'u/${user.name}',
              style: const TextStyle(
                color: Pallete.textColor1,
                  fontSize: Pallete.fontSize1, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 50,
            ),
            
            ListTile(
              onTap: () {},
              title: const Text("Profile Settings",style: TextStyle(color: Pallete.textColor1)),
              leading: const Icon(
                Icons.settings_applications_outlined,
                color: Colors.white,
              ),
            ),
               const Divider(
              color: Pallete.textColor1,
      
            ),
            ListTile(
              onTap: () {
                signOut(ref);
              },
              title: const Text("Log Out",style: TextStyle(color: Pallete.textColor1),),
              leading: const Icon(
                Icons.logout,
                color: Colors.red,
              ),
            ),
                const Divider(
              color: Pallete.textColor1,
      
            ),
          ],
        ),
      ),
    );
  }
}
