import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/restaurant_provider.dart';
import '../providers/auth_provider.dart';
import '../models/restaurant.dart';
import 'restaurant_details.dart';
import 'profile.dart';
import '../services/firestore_service.dart';
import '../models/review.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final TextEditingController _searchController = TextEditingController();

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      HomeContent(searchController: _searchController),
      const ReviewsScreen(),
      const ProfileScreen(),
    ];
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (index != 0) {
      _searchController.clear();
      Provider.of<RestaurantProvider>(context, listen: false).searchRestaurants('');
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    const brandColor = Color(0xFF002A8B);
    const creamColor = Color(0xFFF8F0E2);

    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: creamColor,
        selectedItemColor: brandColor,
        unselectedItemColor: Color(0xFF888780),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        elevation: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.rate_review_outlined), label: 'Reviews'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  final TextEditingController searchController;
  const HomeContent({super.key, required this.searchController});

  @override
  Widget build(BuildContext context) {
    const brandColor = Color(0xFF002A8B);
    const creamColor = Color(0xFFF8F0E2);
    const darkGray = Color(0xFF3A3A3A);

    final restaurantProvider = Provider.of<RestaurantProvider>(context);

    return Scaffold(
      backgroundColor: creamColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Logo + greeting header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/images/logo2.png', height: 48),

                ],
              ),
            ),

            // Page title
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 4),
              child: Text(
                'Discover',
                style: TextStyle(
                  color: brandColor,
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 16),
              child: Text(
                'Find your next favourite spot',
                style: TextStyle(
                  color: darkGray,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),

            // Search bar
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
              child: TextField(
                controller: searchController,
                style: const TextStyle(color: Color(0xFF002A8B)),
                onChanged: (value) {
                  restaurantProvider.searchRestaurants(value);
                },
                decoration: InputDecoration(
                  hintText: 'Search restaurants...',
                  hintStyle: TextStyle(
                    color: brandColor.withOpacity(0.4),
                    fontSize: 14,
                  ),
                  prefixIcon: const Icon(Icons.search, color: brandColor, size: 20),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            // Category chips
            const CategoriesRow(),
            const SizedBox(height: 12),

            // Restaurant list
            Expanded(
              child: restaurantProvider.isLoading
                  ? const Center(
                child: CircularProgressIndicator(color: brandColor),
              )
                  : restaurantProvider.restaurants.isEmpty
                  ? const Center(
                child: Text(
                  'No restaurants found.',
                  style: TextStyle(color: Color(0xFF3A3A3A)),
                ),
              )
                  : ListView.builder(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                itemCount: restaurantProvider.restaurants.length,
                itemBuilder: (context, index) {
                  return RestaurantCard(
                    restaurant: restaurantProvider.restaurants[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoriesRow extends StatefulWidget {
  const CategoriesRow({super.key});

  @override
  State<CategoriesRow> createState() => _CategoriesRowState();
}

class _CategoriesRowState extends State<CategoriesRow> {
  String _selected = 'All';

  @override
  Widget build(BuildContext context) {
    const brandColor = Color(0xFF002A8B);
    const creamColor = Color(0xFFF8F0E2);
    final categories = ['All', 'Café', 'Fine Dining', 'Street Food', 'Asian', 'Filipino'];
    final restaurantProvider = Provider.of<RestaurantProvider>(context, listen: false);

    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = _selected == category;
          return GestureDetector(
            onTap: () {
              setState(() => _selected = category);
              restaurantProvider.filterByCategory(category);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? brandColor : Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                category,
                style: TextStyle(
                  color: isSelected ? creamColor : brandColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;
  const RestaurantCard({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    const brandColor = Color(0xFF002A8B);
    const darkGray = Color(0xFF3A3A3A);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => RestaurantDetailsScreen(restaurant: restaurant),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Restaurant image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(
                restaurant.imageUrl,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 150,
                  color: const Color(0xFFE8E0D0),
                  child: const Icon(
                    Icons.restaurant,
                    size: 48,
                    color: Color(0xFF002A8B),
                  ),
                ),
              ),
            ),

            // Card content
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // Name + rating row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          restaurant.name,
                          style: const TextStyle(
                            color: brandColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8F0E2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '⭐ ${restaurant.rating}',
                          style: const TextStyle(
                            color: brandColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),

                  // Category pill
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFF002A8B),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      restaurant.category,
                      style: const TextStyle(
                        color: Color(0xFFF8F0E2),
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Address
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined,
                          size: 13, color: darkGray),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          restaurant.address,
                          style: const TextStyle(
                            color: darkGray,
                            fontSize: 12,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),

                  // Review count
                  Text(
                    '${restaurant.reviewsCount} reviews',
                    style: const TextStyle(
                      color: Color(0xFF888780),
                      fontSize: 11,
                    ),
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

// ── ReviewsScreen ─────────────────────────────────────────────────────────────

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({super.key});

  Future<String> _getRestaurantName(String restaurantId) async {
    final doc = await FirebaseFirestore.instance
        .collection('tbl_restaurants')
        .doc(restaurantId)
        .get();
    if (doc.exists) {
      return doc.data()?['name'] ?? 'Unknown Restaurant';
    }
    return 'Unknown Restaurant';
  }

  @override
  Widget build(BuildContext context) {
    const brandColor = Color(0xFF002A8B);
    const creamColor = Color(0xFFF8F0E2);
    const darkGray = Color(0xFF3A3A3A);

    final user = Provider.of<AuthProvider>(context).userModel;

    if (user == null) {
      return const Center(child: CircularProgressIndicator(color: brandColor));
    }

    return Scaffold(
      backgroundColor: creamColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
              child: Center(
                child: Image.asset('assets/images/logo2.png', height: 60),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 12.0),
              child: Text(
                'Your Reviews',
                style: TextStyle(
                  color: brandColor,
                  fontWeight: FontWeight.w900,
                  fontSize: 22,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: StreamBuilder<List<Review>>(
                stream: FirestoreService().getUserReviews(user.userId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator(color: brandColor));
                  }
                  if (snapshot.hasError) {
                    return Center(
                        child: Text('Error: ${snapshot.error}',
                            style: const TextStyle(color: darkGray)));
                  }
                  final reviews = snapshot.data ?? [];
                  if (reviews.isEmpty) {
                    return const Center(
                        child: Text('No reviews yet.',
                            style: TextStyle(color: darkGray)));
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: reviews.length,
                    itemBuilder: (context, index) {
                      final review = reviews[index];
                      return FutureBuilder<String>(
                        future: _getRestaurantName(review.restaurantId),
                        builder: (context, nameSnapshot) {
                          final restaurantName = nameSnapshot.data ?? '...';
                          return Card(
                            color: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            margin: const EdgeInsets.only(bottom: 10),
                            child: Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(restaurantName,
                                      style: const TextStyle(
                                          color: brandColor,
                                          fontWeight: FontWeight.w800,
                                          fontSize: 15)),
                                  const SizedBox(height: 4),
                                  Text('⭐ ${review.rating}',
                                      style: const TextStyle(
                                          color: darkGray,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13)),
                                  const SizedBox(height: 4),
                                  Text(review.content,
                                      style: const TextStyle(
                                          color: darkGray, fontSize: 13)),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}