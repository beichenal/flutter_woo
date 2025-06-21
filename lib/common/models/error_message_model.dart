import 'dart:convert';

import 'package:collection/collection.dart';

class ErrorMessageModel {
  int? statusCode;
  String? error;
  String? message;

  ErrorMessageModel({this.statusCode, this.error, this.message});

  @override
  String toString() {
    return 'ErrorMessageModel(statusCode: $statusCode, error: $error, message: $message)';
  }

  factory ErrorMessageModel.fromMap(Map<String, dynamic> data) {
    return ErrorMessageModel(
      statusCode: data['statusCode'] as int?,
      error: data['error'] as String?,
      message: data['message'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'statusCode': statusCode,
        'error': error,
        'message': message,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ErrorMessageModel].
  factory ErrorMessageModel.fromJson(String data) {
    return ErrorMessageModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ErrorMessageModel] to a JSON string.
  String toJson() => json.encode(toMap());

  ErrorMessageModel copyWith({
    int? statusCode,
    String? error,
    String? message,
  }) {
    return ErrorMessageModel(
      statusCode: statusCode ?? this.statusCode,
      error: error ?? this.error,
      message: message ?? this.message,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! ErrorMessageModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => statusCode.hashCode ^ error.hashCode ^ message.hashCode;
}
