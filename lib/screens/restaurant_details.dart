import 'package:flutter/material.dart';
import '../models/restaurant.dart';
import '../models/review.dart';
import '../services/firestore_service.dart';
import '../constants/colors.dart';
import 'review_page.dart';

class RestaurantDetailsScreen extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantDetailsScreen({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    final firestoreService = FirestoreService();

    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              restaurant.imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 200,
                color: AppColors.grey,
                child: const Icon(Icons.restaurant, size: 100),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurant.name,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text('${restaurant.category} • ${restaurant.rating} ⭐ (${restaurant.reviewsCount} reviews)'),
                  const SizedBox(height: 8),
                  Text(restaurant.address),
                  const SizedBox(height: 8),
                  Text('Price Range: ${restaurant.priceRange}'),
                  const SizedBox(height: 8),
                  Text('Hours: ${restaurant.openingHours}'),
                  const SizedBox(height: 16),
                  Text(restaurant.description),
                  const SizedBox(height: 16),
                  if (restaurant.featuredDishes.isNotEmpty) ...[
                    Text(
                      'Featured Dishes:',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: restaurant.featuredDishes
                          .map((dish) => Chip(label: Text(dish)))
                          .toList(),
                    ),
                  ],
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ReviewPage(restaurant: restaurant),
                        ),
                      );
                    },
                    child: const Text('Add Review'),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Reviews',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                  StreamBuilder<List<Review>>(
                    stream: firestoreService.getReviews(restaurant.restaurantId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }
                      final reviews = snapshot.data ?? [];
                      if (reviews.isEmpty) {
                        return const Text('No reviews yet.');
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: reviews.length,
                        itemBuilder: (context, index) {
                          final review = reviews[index];
                          return ReviewCard(review: review);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReviewCard extends StatelessWidget {
  final Review review;

  const ReviewCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  child: Text(review.username[0].toUpperCase()),
                ),
                const SizedBox(width: 8),
                Text(review.username, style: const TextStyle(fontWeight: FontWeight.bold)),
                const Spacer(),
                Text('${review.rating} ⭐'),
              ],
            ),
            const SizedBox(height: 8),
            Text(review.content),
            if (review.imageUrl.isNotEmpty) ...[
              const SizedBox(height: 8),
              Image.network(
                review.imageUrl,
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const SizedBox(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
