import "package:flutter/material.dart";
import "package:flutter_reddit/core/constants/constants.dart";
import "package:flutter_reddit/services/auth/controller/auth_controller.dart";
import 'package:flutter_reddit/services/auth/screen/google_signin_button.dart';
import "package:flutter_reddit/theme/pallete.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

class LoginScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      backgroundColor: Pallete.backgroundColor,
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () => null,
            child: const Text('Skip'),
          ),
        ],
        backgroundColor:Pallete.appBarColor,
        centerTitle: true,
        title: Image.asset(
          Constants.app_logo,
          height: 50,
          width: 50,
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Container(
              margin: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      top: 20,
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      "Dive into anything",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Image.asset(
                    Constants.reddit_screen_img,
                    width: 300,
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  const GoogleSignInButton()
                ],
              ),
            ),
    );
  }
}
