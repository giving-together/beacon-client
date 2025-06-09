// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';

class Person {
  final int id;
  final String fullName;
  final String email;
  final List<String> type;
  final String? avatarUrl;
  Person({
    required this.id,
    required this.fullName,
    required this.email,
    required this.type,
    this.avatarUrl,
  });

  Person copyWith({
    int? id,
    String? fullName,
    String? email,
    List<String>? type,
    String? avatarUrl,
  }) {
    return Person(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      type: type ?? this.type,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fullName': fullName,
      'email': email,
      'type': type,
      'avatarUrl': avatarUrl,
    };
  }

  factory Person.fromMap(Map<String, dynamic> map) {
    return Person(
      id: map['id'] as int,
      fullName: map['fullName'] as String,
      email: map['email'] as String,
      type: List<String>.from((map['type'] as List<String>)),
      avatarUrl: map['avatarUrl'] != null ? map['avatarUrl'] as String : null,
    );
  }

  factory Person.fromBeacon(Map<String, dynamic> map) {
    final entity = map['entity'] as Map<String, dynamic>;

    return Person(
      id: entity['id'] as int,
      fullName: entity['name']['full'] as String,
      email: _getPrimaryEmail(entity['emails'] as List<dynamic>),
      type: List<String>.from(entity['type']),
      avatarUrl: entity['avatar'] != null ? entity['avatar'] as String : null,
    );
  }

  static String _getPrimaryEmail(List<dynamic> emails) {
    return emails.firstWhere((email) => email['is_primary'] == true)['email'];
  }

  String toJson() => json.encode(toMap());

  factory Person.fromJson(String source) =>
      Person.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Person(id: $id, fullName: $fullName, email: $email, type: $type, avatarUrl: $avatarUrl)';
  }

  @override
  bool operator ==(covariant Person other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.id == id &&
        other.fullName == fullName &&
        other.email == email &&
        listEquals(other.type, type) &&
        other.avatarUrl == avatarUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        fullName.hashCode ^
        email.hashCode ^
        type.hashCode ^
        avatarUrl.hashCode;
  }
}
