import 'dart:convert';

import 'package:collection/collection.dart';

class UserRegisterReq {
  final String? username;
  final String? password;
  final String? email;
  final String? firstName;
  final String? lastName;

  const UserRegisterReq({
    this.username,
    this.password,
    this.email,
    this.firstName,
    this.lastName,
  });

  @override
  String toString() {
    return 'UserRegisterReq(username: $username, password: $password, email: $email, firstName: $firstName, lastName: $lastName)';
  }

  factory UserRegisterReq.fromMap(Map<String, dynamic> data) {
    return UserRegisterReq(
      username: data['username'] as String?,
      password: data['password'] as String?,
      email: data['email'] as String?,
      firstName: data['first_name'] as String?,
      lastName: data['last_name'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'username': username,
        'password': password,
        'email': email,
        'first_name': firstName,
        'last_name': lastName,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [UserRegisterReq].
  factory UserRegisterReq.fromJson(String data) {
    return UserRegisterReq.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [UserRegisterReq] to a JSON string.
  String toJson() => json.encode(toMap());

  UserRegisterReq copyWith({
    String? username,
    String? password,
    String? email,
    String? firstName,
    String? lastName,
  }) {
    return UserRegisterReq(
      username: username ?? this.username,
      password: password ?? this.password,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! UserRegisterReq) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      username.hashCode ^
      password.hashCode ^
      email.hashCode ^
      firstName.hashCode ^
      lastName.hashCode;
}
