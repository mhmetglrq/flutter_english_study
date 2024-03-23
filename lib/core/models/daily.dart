import 'dart:convert';

class Daily {
  String? uid;
  String? title;
  String? description;
  DateTime? date;
  String? type;
  Daily({
    this.uid,
    this.title,
    this.description,
    this.date,
    this.type,
  });

  Daily copyWith({
    String? uid,
    String? title,
    String? description,
    DateTime? date,
    String? type,
  }) {
    return Daily(
      uid: uid ?? this.uid,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'title': title,
      'description': description,
      'date': date?.millisecondsSinceEpoch,
      'type': type,
    };
  }

  factory Daily.fromMap(Map<String, dynamic> map) {
    return Daily(
      uid: map['uid'] != null ? map['uid'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      date: map['date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['date'] as int)
          : null,
      type: map['type'] != null ? map['type'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Daily.fromJson(String source) =>
      Daily.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Daily(uid: $uid, title: $title, description: $description, date: $date, type: $type)';
  }

  @override
  bool operator ==(covariant Daily other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.title == title &&
        other.description == description &&
        other.date == date &&
        other.type == type;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        title.hashCode ^
        description.hashCode ^
        date.hashCode ^
        type.hashCode;
  }
}
