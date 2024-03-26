// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class GroupModel {
  String? uid;
  String? title;
  String? description;
  List<dynamic>? members;
  String? creatorUid;
  GroupModel({
    this.uid,
    this.title,
    this.description,
    this.members,
    this.creatorUid,
  });

  GroupModel copyWith({
    String? uid,
    String? title,
    String? description,
    List<dynamic>? members,
    String? creatorUid,
  }) {
    return GroupModel(
      uid: uid ?? this.uid,
      title: title ?? this.title,
      description: description ?? this.description,
      members: members ?? this.members,
      creatorUid: creatorUid ?? this.creatorUid,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'title': title,
      'description': description,
      'members': members,
      'creatorUid': creatorUid,
    };
  }

  factory GroupModel.fromMap(Map<String, dynamic> map) {
    return GroupModel(
      uid: map['uid'] != null ? map['uid'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      members: map['members'] != null
          ? List<dynamic>.from((map['members'] as List<dynamic>))
          : null,
      creatorUid:
          map['creatorUid'] != null ? map['creatorUid'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GroupModel.fromJson(String source) =>
      GroupModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GroupModel(uid: $uid, title: $title, description: $description, members: $members, creatorUid: $creatorUid)';
  }

  @override
  bool operator ==(covariant GroupModel other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.title == title &&
        other.description == description &&
        listEquals(other.members, members) &&
        other.creatorUid == creatorUid;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        title.hashCode ^
        description.hashCode ^
        members.hashCode ^
        creatorUid.hashCode;
  }
}
