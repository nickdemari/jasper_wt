import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

/// {@template user}
/// User model
///
/// [FirebaseUser.empty] represents an unauthenticated user.
/// {@endtemplate}
class FirebaseUser extends Equatable {
  /// {@macro user}
  const FirebaseUser({
    required this.id,
    this.createdDateTime,
  });

  /// The current user's id.
  final String id;

  /// The current user's created date time as a timestamp.
  final Timestamp? createdDateTime;

  /// Empty user which represents an unauthenticated user.
  static const empty = FirebaseUser(id: '');

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == FirebaseUser.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != FirebaseUser.empty;

  @override
  List<Object?> get props => [
        id,
      ];

  Map<String, dynamic> toJson() => {
        'id': id,
        'createdDateTime': DateTime.timestamp(),
      };

  /// Creates a [FirebaseUser] from a JSON map.
  static FirebaseUser fromJson(Map<String, dynamic> json) {
    return FirebaseUser(
      id: json['id'] as String,
      createdDateTime: json['createdDateTime'] as Timestamp?,
    );
  }
}
