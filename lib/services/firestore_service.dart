import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/restaurant.dart';
import '../models/review.dart';
import '../models/user.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Restaurants
  Stream<List<Restaurant>> getRestaurants() {
    return _db.collection('tbl_restaurants').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Restaurant.fromMap(doc.data())).toList());
  }

  Future<void> addRestaurant(Restaurant restaurant) {
    return _db.collection('tbl_restaurants').doc(restaurant.restaurantId).set(restaurant.toMap());
  }

  // Reviews
  Stream<List<Review>> getReviews(String restaurantId) {
    return _db.collection('tbl_reviews')
        .where('restaurant_id', isEqualTo: restaurantId)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => Review.fromMap(doc.data())).toList());
  }

  Future<void> addReview(Review review) {
    return _db.collection('tbl_reviews').doc(review.reviewId).set(review.toMap());
  }

  Stream<List<Review>> getUserReviews(String userId) {
    return _db.collection('tbl_reviews')
        .where('user_id', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => Review.fromMap(doc.data())).toList());
  }

  // Users
  Future<void> addUser(UserModel user) {
    return _db.collection('tbl_users').doc(user.userId).set(user.toMap());
  }

  Future<UserModel?> getUser(String userId) async {
    DocumentSnapshot doc = await _db.collection('tbl_users').doc(userId).get();
    if (doc.exists) {
      return UserModel.fromMap(doc.data() as Map<String, dynamic>);
    }
    return null;
  }
}
