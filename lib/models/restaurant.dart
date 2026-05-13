class Restaurant {
  final String restaurantId;
  final String name;
  final String address;
  final String category;
  final double rating;
  final int reviewsCount;
  final String imageUrl;
  final String description;
  final String openingHours;
  final String priceRange;
  final List<String> featuredDishes;

  Restaurant({
    required this.restaurantId,
    required this.name,
    required this.address,
    required this.category,
    required this.rating,
    required this.reviewsCount,
    required this.imageUrl,
    required this.description,
    required this.openingHours,
    required this.priceRange,
    required this.featuredDishes,
  });

  factory Restaurant.fromMap(Map<String, dynamic> map) {
    return Restaurant(
      restaurantId: map['restaurant_id'] ?? '',
      name: map['name'] ?? '',
      address: map['address'] ?? '',
      category: map['category'] ?? '',
      rating: (map['rating'] ?? 0.0).toDouble(),
      reviewsCount: map['reviews_count'] ?? 0,
      imageUrl: map['image_url'] ?? '',
      description: map['description'] ?? '',
      openingHours: map['opening_hours'] ?? '',
      priceRange: map['price_range'] ?? '',
      featuredDishes: List<String>.from(map['featured_dishes'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'restaurant_id': restaurantId,
      'name': name,
      'address': address,
      'category': category,
      'rating': rating,
      'reviews_count': reviewsCount,
      'image_url': imageUrl,
      'description': description,
      'opening_hours': openingHours,
      'price_range': priceRange,
      'featured_dishes': featuredDishes,
    };
  }
}
