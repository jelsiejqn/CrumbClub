import 'package:flutter/material.dart';
import '../models/restaurant.dart';
import '../models/review.dart';
import '../services/firestore_service.dart';
import 'review_page.dart';

class RestaurantDetailsScreen extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantDetailsScreen({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    const brandColor = Color(0xFF002A8B);
    const creamColor = Color(0xFFF8F0E2);
    const darkGray = Color(0xFF3A3A3A);

    final firestoreService = FirestoreService();

    return Scaffold(
      backgroundColor: creamColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Hero image with back button overlay
            Stack(
              children: [
                Image.network(
                  restaurant.imageUrl,
                  height: 260,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 260,
                    color: const Color(0xFFE8E0D0),
                    child: const Icon(Icons.restaurant, size: 80, color: brandColor),
                  ),
                ),
                // Dark gradient at top for back button legibility
                Container(
                  height: 100,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.black45, Colors.transparent],
                    ),
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.arrow_back, color: brandColor, size: 20),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Main content card that overlaps the image
            Transform.translate(
              offset: const Offset(0, -20),
              child: Container(
                decoration: const BoxDecoration(
                  color: creamColor,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // Name + rating row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            restaurant.name,
                            style: const TextStyle(
                              color: brandColor,
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '⭐ ${restaurant.rating}',
                            style: const TextStyle(
                              color: brandColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Category pill + review count
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: brandColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            restaurant.category,
                            style: const TextStyle(
                              color: creamColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          '${restaurant.reviewsCount} reviews',
                          style: const TextStyle(
                            color: Color(0xFF888780),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Info rows
                    _InfoRow(icon: Icons.location_on_outlined,
                        text: restaurant.address),
                    const SizedBox(height: 10),
                    _InfoRow(icon: Icons.attach_money,
                        text: restaurant.priceRange),
                    const SizedBox(height: 10),
                    _InfoRow(icon: Icons.access_time_outlined,
                        text: restaurant.openingHours),
                    const SizedBox(height: 20),

                    // Description
                    Text(
                      restaurant.description,
                      style: const TextStyle(
                        color: darkGray,
                        fontSize: 14,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Featured dishes
                    if (restaurant.featuredDishes.isNotEmpty) ...[
                      const Text(
                        'Featured Dishes',
                        style: TextStyle(
                          color: brandColor,
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: restaurant.featuredDishes.map((dish) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              dish,
                              style: const TextStyle(
                                color: brandColor,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 24),
                    ],

                    // Add review button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  ReviewPage(restaurant: restaurant),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: brandColor,
                          foregroundColor: creamColor,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Add Review',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Reviews section
                    const Text(
                      'Reviews',
                      style: TextStyle(
                        color: brandColor,
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 12),

                    StreamBuilder<List<Review>>(
                      stream: firestoreService
                          .getReviews(restaurant.restaurantId),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(
                                color: brandColor),
                          );
                        }
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}',
                              style: const TextStyle(color: darkGray));
                        }
                        final reviews = snapshot.data ?? [];
                        if (reviews.isEmpty) {
                          return const Padding(
                            padding: EdgeInsets.only(bottom: 24.0),
                            child: Text('No reviews yet.',
                                style: TextStyle(color: Color(0xFF888780))),
                          );
                        }
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: reviews.length,
                          itemBuilder: (context, index) {
                            return ReviewCard(review: reviews[index]);
                          },
                        );
                      },
                    ),

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: const Color(0xFF888780)),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: Color(0xFF3A3A3A),
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }
}

class ReviewCard extends StatelessWidget {
  final Review review;

  const ReviewCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    const brandColor = Color(0xFF002A8B);
    const darkGray = Color(0xFF3A3A3A);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // Avatar + username + rating
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: brandColor,
                child: Text(
                  review.username[0].toUpperCase(),
                  style: const TextStyle(
                    color: Color(0xFFF8F0E2),
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  review.username,
                  style: const TextStyle(
                    color: brandColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
              ),
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F0E2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '⭐ ${review.rating}',
                  style: const TextStyle(
                    color: brandColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Review text
          Text(
            review.content,
            style: const TextStyle(color: darkGray, fontSize: 13, height: 1.5),
          ),

          // Review image if present
          if (review.imageUrl.isNotEmpty) ...[
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                review.imageUrl,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                const SizedBox(),
              ),
            ),
          ],
        ],
      ),
    );
  }
}