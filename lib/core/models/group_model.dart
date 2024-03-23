// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class GroupModel {
  String? uid;
  String? title;
  String? description;
  List<String>? userList;
  GroupModel({
    this.uid,
    this.title,
    this.description,
    this.userList,
  });

  GroupModel copyWith({
    String? uid,
    String? title,
    String? description,
    List<String>? userList,
  }) {
    return GroupModel(
      uid: uid ?? this.uid,
      title: title ?? this.title,
      description: description ?? this.description,
      userList: userList ?? this.userList,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'title': title,
      'description': description,
      'userList': userList,
    };
  }

  factory GroupModel.fromMap(Map<String, dynamic> map) {
    return GroupModel(
      uid: map['uid'] != null ? map['uid'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      userList: map['userList'] != null
          ? List<String>.from((map['userList'] as List<String>))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GroupModel.fromJson(String source) =>
      GroupModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GroupModel(uid: $uid, title: $title, description: $description, userList: $userList)';
  }

  @override
  bool operator ==(covariant GroupModel other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.title == title &&
        other.description == description &&
        listEquals(other.userList, userList);
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        title.hashCode ^
        description.hashCode ^
        userList.hashCode;
  }
}
