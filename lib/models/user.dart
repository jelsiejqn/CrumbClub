import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String userId;
  final String username;
  final String email;
  final String profileImage;
  final Timestamp joinedAt;

  UserModel({
    required this.userId,
    required this.username,
    required this.email,
    required this.profileImage,
    required this.joinedAt,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['user_id'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      profileImage: map['profile_image'] ?? '',
      joinedAt: map['joined_at'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'username': username,
      'email': email,
      'profile_image': profileImage,
      'joined_at': joinedAt,
    };
  }
}
