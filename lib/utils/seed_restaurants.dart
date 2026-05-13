import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

class SeedRestaurants {
  static final List<Map<String, dynamic>> restaurants = [
    {
      'restaurant_id': 'wildflour_salcedo',
      'name': 'Wildflour Cafe + Bakery',
      'address': 'Salcedo Village, Makati',
      'category': 'Café',
      'image_url': 'https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=500',
      'description': 'Classy brunch, freshly baked pastries, and very Instagrammable vibes. Perfect for weekend mornings.',
      'opening_hours': '7 AM - 10 PM',
      'price_range': '₱₱₱',
      'featured_dishes': ['Cronuts', 'Shakshuka', 'Wildflour Breakfast'],
    },
    {
      'restaurant_id': 'tobys_estate',
      'name': 'Toby’s Estate',
      'address': 'Salcedo Village, Makati',
      'category': 'Café',
      'image_url': 'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=500',
      'description': 'Cozy specialty coffee shop with a calm work/study vibe. Famous for their Flat White.',
      'opening_hours': '7 AM - 8 PM',
      'price_range': '₱₱',
      'featured_dishes': ['Flat White', 'Gibraltar', 'Avocado Toast'],
    },
    {
      'restaurant_id': 'h_proper',
      'name': 'H Proper Coffee Roasters',
      'address': 'Ayala Triangle, Makati',
      'category': 'Café',
      'image_url': 'https://images.unsplash.com/photo-1507133750040-4a8f5700817f?w=500',
      'description': 'Minimalist aesthetic coffee shop featuring strong specialty coffee and trendy drinks.',
      'opening_hours': '8 AM - 9 PM',
      'price_range': '₱₱',
      'featured_dishes': ['Pour Over', 'Iced Latte', 'Cold Brew'],
    },
    {
      'restaurant_id': 'helm_ayala',
      'name': 'Helm',
      'address': 'Ayala Triangle Gardens, Makati',
      'category': 'Fine Dining',
      'image_url': 'https://images.unsplash.com/photo-1514362545857-3bc16c4c7d1b?w=500',
      'description': 'Ultra fine dining featuring a tasting menu. A true Michelin-level culinary experience.',
      'opening_hours': '6 PM - 10 PM',
      'price_range': '₱₱₱₱',
      'featured_dishes': ['Tasting Menu', 'Wine Pairing'],
    },
    {
      'restaurant_id': 'blackbird_makati',
      'name': 'Blackbird',
      'address': 'Nielson Tower, Ayala Triangle, Makati',
      'category': 'Fine Dining',
      'image_url': 'https://images.unsplash.com/photo-1550966842-2849a224987f?w=500',
      'description': 'Elegant architecture in a historic tower. Upscale European-Asian dishes with a romantic vibe.',
      'opening_hours': '11 AM - 11 PM',
      'price_range': '₱₱₱₱',
      'featured_dishes': ['Seafood Platter', 'Lamb Chops', 'Afternoon Tea'],
    },
    {
      'restaurant_id': 'azuthai_makati',
      'name': 'Azuthai',
      'address': 'Pasay Road, Makati',
      'category': 'Asian',
      'image_url': 'https://images.unsplash.com/photo-1559339352-11d035aa65de?w=500',
      'description': 'Authentic Thai food run by Thai chefs. Famous for their pad thai and mango sticky rice.',
      'opening_hours': '11 AM - 10 PM',
      'price_range': '₱₱₱',
      'featured_dishes': ['Pad Thai', 'Crispy Catfish Salad', 'Mango Sticky Rice'],
    },
    {
      'restaurant_id': 'kazu_cafe',
      'name': 'Kazu Cafe',
      'address': 'Ayala Triangle, Makati',
      'category': 'Asian',
      'image_url': 'https://images.unsplash.com/photo-1522336572468-97b06e8ef143?w=500',
      'description': 'Modern Japanese fusion café with cute desserts and signature matcha drinks.',
      'opening_hours': '10 AM - 9 PM',
      'price_range': '₱₱',
      'featured_dishes': ['Matcha Latte', 'Japanese Cheesecake', 'Fusion Bento'],
    },
    {
      'restaurant_id': 'your_local',
      'name': 'Your Local',
      'address': 'Legazpi Village, Makati',
      'category': 'Asian',
      'image_url': 'https://images.unsplash.com/photo-1512132411229-c30391241dd8?w=500',
      'description': 'Modern Asian fusion known for trendy vibes and aesthetic plating. A Legazpi staple.',
      'opening_hours': '11 AM - 10 PM',
      'price_range': '₱₱₱',
      'featured_dishes': ['Torched Salmon Donburi', 'Chili Crab Bun'],
    },
    {
      'restaurant_id': 'milkyway_cafe',
      'name': 'MilkyWay Cafe',
      'address': 'Makati Ave, Makati',
      'category': 'Filipino',
      'image_url': 'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?w=500',
      'description': 'Classic Filipino comfort food and nostalgic desserts. Known for the best Halo-Halo.',
      'opening_hours': '11 AM - 9 PM',
      'price_range': '₱₱',
      'featured_dishes': ['Halo-Halo', 'Chicken Galantina', 'Dinuguan'],
    },
    {
      'restaurant_id': 'manam_ayala',
      'name': 'Manam Comfort Filipino',
      'address': 'Ayala Center, Makati',
      'category': 'Filipino',
      'image_url': 'https://images.unsplash.com/photo-1589302168068-964664d93dc0?w=500',
      'description': 'Modern Filipino dishes with a twist. Perfect for sharing and cute presentation.',
      'opening_hours': '10 AM - 10 PM',
      'price_range': '₱₱',
      'featured_dishes': ['House Crispy Sisig', 'Watermelon Sinigang'],
    },
    {
      'restaurant_id': 'poblacion_district',
      'name': 'Poblacion Food District',
      'address': 'Poblacion, Makati',
      'category': 'Street Food',
      'image_url': 'https://images.unsplash.com/photo-1514933651103-005eec06c04b?w=500',
      'description': 'Vibrant district with street food, cheap eats, and aesthetic night lights.',
      'opening_hours': '5 PM - 2 AM',
      'price_range': '₱',
      'featured_dishes': ['Grilled Skewers', 'Local Craft Beer', 'Tacos'],
    },
  ];

  static Future<void> seed() async {
    final db = FirebaseFirestore.instance;
    final random = Random();
    
    final List<String> users = ['Juan D.', 'Maria C.', 'Jose R.', 'Leonor V.', 'Andres B.', 'Gabriela S.', 'Liza S.', 'Dionne B.'];
    final List<String> comments = [
      'Amazing food and great service! Definitely coming back.',
      'The ambiance is perfect for a date night.',
      'A bit pricey but worth every peso.',
      'The best version of this dish I have ever tasted!',
      'Clean, affordable, and very authentic flavors.',
      'Instagrammable place and the coffee is top-tier.',
      'Highly recommended for families and big groups.',
      'Perfect spot for studying or working quietly.'
    ];

    print('🚀 Seeding consistent data for your requested restaurants...');

    for (var i = 0; i < restaurants.length; i++) {
      var res = Map<String, dynamic>.from(restaurants[i]);
      String resId = res['restaurant_id'];
      
      int numReviews = 3 + random.nextInt(3); // 3-5 reviews per restaurant
      double totalRating = 0;

      for (int j = 1; j <= numReviews; j++) {
        double rating = 4.0 + (random.nextDouble() * 1.0); // 4.0 to 5.0
        totalRating += rating;
        
        String reviewId = 'rev_${resId}_$j';
        await db.collection('tbl_reviews').doc(reviewId).set({
          'review_id': reviewId,
          'restaurant_id': resId,
          'user_id': 'user_${random.nextInt(1000)}',
          'username': users[random.nextInt(users.length)],
          'rating': double.parse(rating.toStringAsFixed(1)),
          'content': comments[random.nextInt(comments.length)],
          'image_url': '',
          'timestamp': Timestamp.now(),
        });
      }

      res['reviews_count'] = numReviews;
      res['rating'] = double.parse((totalRating / numReviews).toStringAsFixed(1));

      await db.collection('tbl_restaurants').doc(resId).set(res);
    }
    print('✅ Seeding complete! All cute cafes, fine dining, Asian, and Filipino spots are now live.');
  }
}
