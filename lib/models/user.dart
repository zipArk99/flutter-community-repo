
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userModelProvider=Provider((ref) =>UserModel);
class UserModel {
  final String name;
  final String profilPic;
  final String banner;
  final String uId;
  final bool isAuthenticated;
  final int karma;
  final List<String> awards;

  UserModel({
    required this.name,
    required this.banner,
    required this.profilPic,
    required this.isAuthenticated,
    required this.uId,
    required this.karma,
    required this.awards,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'profilPic': profilPic,
      'banner': banner,
      'uId': uId,
      'isAuthenticated': isAuthenticated,
      'karma': karma,
      'awards': awards
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        name: map['name'] ?? "",
        banner: map['banner'] ?? "",
        profilPic: map['profilPic'] ?? "",
        isAuthenticated: map['isAuthenticated'] ?? false,
        uId: map['uId'] ?? "",
        karma: map['karma'] ?? 0,
        awards: List<String>.from(map['awards']));
  }
}
