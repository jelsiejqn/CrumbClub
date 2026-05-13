import 'package:flutter/material.dart';
import '../services/firestore_service.dart';
import '../models/restaurant.dart';

class RestaurantProvider with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();

  List<Restaurant> _restaurants = [];
  List<Restaurant> _filteredRestaurants = [];
  bool _isLoading = true;

  List<Restaurant> get restaurants => _filteredRestaurants;
  bool get isLoading => _isLoading;

  RestaurantProvider() {
    loadRestaurants();
  }

  void loadRestaurants() {
    _firestoreService.getRestaurants().listen((restaurants) {
      _restaurants = restaurants;
      _filteredRestaurants = restaurants;
      _isLoading = false;
      notifyListeners();
    });
  }

  void searchRestaurants(String query) {
    if (query.isEmpty) {
      _filteredRestaurants = _restaurants;
    } else {
      _filteredRestaurants = _restaurants
          .where((restaurant) =>
              restaurant.name.toLowerCase().contains(query.toLowerCase()) ||
              restaurant.category.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  void filterByCategory(String category) {
    if (category == 'All') {
      _filteredRestaurants = _restaurants;
    } else {
      _filteredRestaurants = _restaurants
          .where((restaurant) => restaurant.category == category)
          .toList();
    }
    notifyListeners();
  }
}
