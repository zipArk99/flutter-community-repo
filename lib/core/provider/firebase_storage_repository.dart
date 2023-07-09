import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_reddit/typedefs/exception_typedefs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

final firebaseStorageRepositoryProvider = Provider((ref) => FirebaseStorageRepository());

class FirebaseStorageRepository {
  final _firebaseStorageInstance = FirebaseStorage.instance;

  FutureEither<String> storeFile(
      {required String bucket, required String id, required File? file}) async {
    try {
      final ref =
          _firebaseStorageInstance.ref().child(bucket).child(id).child(id);
      ref.putFile(file!); 
      return right(await ref.getDownloadURL());
    } catch (error) {
      return left(error.toString());
    }
  }
}
