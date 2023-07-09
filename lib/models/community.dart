import 'package:flutter/foundation.dart';

class Community {
  final String id;
  final String name;
  final String banner;
  final String avatar;
  final List<String> members;
  final List<String> mods;

  Community({
    required this.id,
    required this.avatar,
    required this.banner,
    required this.members,
    required this.mods,
    required this.name,
  });

  Community copyWith(
      {String? id,
      String? avatar,
      String? banner,
      List<String>? members,
      List<String>? mods,
      String? name}) {
    return Community(
      id: id ?? this.id,
      avatar: avatar ?? this.avatar,
      banner: banner ?? this.banner,
      members: members ?? this.members,
      mods: mods ?? this.mods,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'banner': banner,
      'avatar': avatar,
      'members': members,
      'mods': mods,
    };
  }
  

  factory Community.fromMap(Map<String, dynamic> map) {
    
    return Community(
      id: map['id'] ?? '',
      avatar: map['avatar'] ?? '',
      banner: map['banner'] ?? '',
      members: List.from(map['members'] ?? []),
      mods: List.from(map['mods'] ?? []),
      name: map['name'] ?? '',
    );
  }
}
