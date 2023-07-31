import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reddit/models/user.dart';
import 'package:flutter_reddit/services/auth/repository/auth_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

final authControllerProvider = StateNotifierProvider<AuthController, bool>(
  (ref) => AuthController(
    authRepository: ref.watch(authRepositoryProvider),
    ref: ref,
  ),
);
final authStateChangeProvider = StreamProvider<User?>((ref) {
  AuthController val = ref.read(authControllerProvider.notifier);
  return val.authStateChange();
});

final getUserDataByIdProvider = StreamProvider.family((ref, String userId) {
  AuthController val = ref.read(authControllerProvider.notifier);
  return val.getUserDataById(userId);
});
final userProvider = StateProvider<UserModel?>((ref) => null);

class AuthController extends StateNotifier<bool> {  
  final AuthRepository _authRepository;
  final Ref _ref;
  AuthController({required AuthRepository authRepository, required Ref ref})
      : _authRepository = authRepository,
        _ref = ref,
        super(false);
  Stream<User?> authStateChange() {
    return _authRepository.authState;
  }

  Stream<UserModel> getUserDataById(String userId) {
    return _authRepository.getUserById(userId);
  }

  void signOutUser(){
    //_authRepository.signOut();
  
  }

  void signWithGoogle(BuildContext context) async {
    state = true;
    final user = await _authRepository.signInWithGoolge();
    state = false;
    user.fold(
      (l) {
        return ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(l),
            ),
          );
      },
      (r) {
        _ref.read(userProvider.notifier).update((state) => r);
      },
    );
  }
}
