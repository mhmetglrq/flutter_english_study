// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'group_model.dart';

class UserModel {
  String? uid;
  String? email;
  GroupModel? group;

  UserModel({
    this.uid,
    this.email,
    this.group,
  });

  UserModel copyWith({
    String? uid,
    String? email,
    GroupModel? group,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      group: group ?? this.group,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'email': email,
      'group': group?.toMap(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] != null ? map['uid'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      group: map['group'] != null ? GroupModel.fromMap(map['group'] as Map<String,dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UserModel(uid: $uid, email: $email, group: $group)';

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.uid == uid &&
      other.email == email &&
      other.group == group;
  }

  @override
  int get hashCode => uid.hashCode ^ email.hashCode ^ group.hashCode;
}
