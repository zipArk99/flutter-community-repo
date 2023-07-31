import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter_reddit/core/constants/firebase_constants.dart";
import "package:flutter_reddit/models/user.dart";
import "package:flutter_reddit/typedefs/exception_typedefs.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:fpdart/fpdart.dart";
import "package:google_sign_in/google_sign_in.dart";
import "package:routemaster/routemaster.dart";

final authRepositoryProvider =
    Provider<AuthRepository>((ref) => AuthRepository());


class AuthRepository {
  CollectionReference get _user {
    return FirebaseFirestore.instance
        .collection(FirebaseConstants.userCollection);
  }

  Stream<User?> get authState{
  final auth = FirebaseAuth.instance.authStateChanges();
  return auth;
}

Future<void> signOut(BuildContext contx) async{
  await FirebaseAuth.instance.signOut().then((value){
    Routemaster.of(contx).push("/");
  });
}

  late OAuthCredential credential;
  FutureEither<UserModel> signInWithGoolge() async {
    UserModel userModel;
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      userModel = UserModel(
        name: userCredential.user!.displayName ?? "",
        banner: "",
        profilPic: userCredential.user!.photoURL ?? "",
        isAuthenticated: true,
        uId: userCredential.user!.uid,
        karma: 0,
        awards: [],
      );
      print("data::${userModel.uId}");
      if (userCredential.additionalUserInfo!.isNewUser) {
        await _user.doc(userCredential.user!.uid).set(
              userModel.toMap(),
            );
      }
      return Right(userModel);
    } catch (e) {
      return left(e.toString());
    }
  }

  Stream<UserModel> getUserById(String userId) {
    return _user.doc(userId).snapshots().map(
      (event) {
        return UserModel.fromMap(event.data() as Map<String, dynamic>);
      },
    );
  }
}
