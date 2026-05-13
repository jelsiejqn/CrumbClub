import 'package:cloud_firestore/cloud_firestore.dart';

class Review {
  final String reviewId;
  final String restaurantId;
  final String userId;
  final String username;
  final double rating;
  final String content;
  final String imageUrl;
  final Timestamp timestamp;

  Review({
    required this.reviewId,
    required this.restaurantId,
    required this.userId,
    required this.username,
    required this.rating,
    required this.content,
    required this.imageUrl,
    required this.timestamp,
  });

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      reviewId: map['review_id'] ?? '',
      restaurantId: map['restaurant_id'] ?? '',
      userId: map['user_id'] ?? '',
      username: map['username'] ?? '',
      rating: (map['rating'] ?? 0.0).toDouble(),
      content: map['content'] ?? '',
      imageUrl: map['image_url'] ?? '',
      timestamp: map['timestamp'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'review_id': reviewId,
      'restaurant_id': restaurantId,
      'user_id': userId,
      'username': username,
      'rating': rating,
      'content': content,
      'image_url': imageUrl,
      'timestamp': timestamp,
    };
  }
}
