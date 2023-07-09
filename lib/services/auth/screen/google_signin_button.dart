import 'package:flutter/material.dart';
import 'package:flutter_reddit/services/auth/controller/auth_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/constants.dart';

class GoogleSignInButton extends ConsumerWidget {
  const GoogleSignInButton({super.key});

  void signInWithGoogle(WidgetRef ref,BuildContext context) {
    ref.read(authControllerProvider.notifier).signWithGoogle(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          maximumSize: const Size(double.infinity, 50),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(23)),
          backgroundColor: Colors.blueGrey.shade900,
          padding: const EdgeInsets.all(
            10,
          ),
        ),
        onPressed: () {
          signInWithGoogle(ref,context);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Constants.google_logo,
              width: 30,
            ),
            const SizedBox(
              width: 20,
            ),
            const Text(
              'Continue with Google',
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
