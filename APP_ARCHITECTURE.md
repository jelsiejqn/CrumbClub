# Crumb Club - Project Documentation

## Overview

Crumb Club is a modern Flutter mobile application for discovering restaurants, reading reviews, and sharing dining experiences. The app connects users with a comprehensive database of Metro Manila food establishments across diverse cuisines and price points.

## Project Structure

```
crumb_club/
├── lib/
│   ├── main.dart                 # App entry point & theme setup
│   ├── constants/
│   │   └── colors.dart          # App color palette
│   ├── models/
│   │   ├── restaurant.dart       # Restaurant data model
│   │   ├── review.dart          # Review data model
│   │   └── user.dart            # User data model
│   ├── services/
│   │   ├── auth_service.dart     # Firebase Auth service
│   │   └── firestore_service.dart # Firestore operations
│   ├── providers/
│   │   ├── auth_provider.dart    # Authentication state management
│   │   └── restaurant_provider.dart # Restaurant list state
│   ├── screens/
│   │   ├── auth/
│   │   │   ├── login.dart        # Login screen
│   │   │   └── register.dart     # Registration screen
│   │   ├── home.dart             # Home screen with restaurant list
│   │   ├── restaurant_details.dart # Restaurant details & reviews
│   │   ├── review_page.dart      # Write review form
│   │   └── profile.dart          # User profile screen
│   ├── widgets/                  # Reusable UI components
│   ├── utils/
│   │   └── seed_restaurants.dart # Database seeding utility
│   └── providers/                # State management
├── android/                      # Android native code
├── ios/                         # iOS native code
├── pubspec.yaml                 # Project dependencies
├── analysis_options.yaml        # Lint rules
├── FIREBASE_SETUP.md            # Firebase configuration guide
├── README.md                    # Getting started guide
└── APP_ARCHITECTURE.md          # Architecture documentation
```

## Features

### 1. Authentication
- **Register**: Create new account with email and password
- **Login**: Secure Firebase Authentication
- **Persistent Login**: Shared Preferences remember logged-in users
- **Password Reset**: Email-based password recovery
- **Logout**: Clear session and return to login

### 2. Restaurant Discovery
- **Browse Restaurants**: Scrollable list of 70+ Metro Manila restaurants
- **Search**: Real-time search by restaurant name or category
- **Filter by Category**: Café, Street Food, Asian, Filipino, Fine Dining, etc.
- **Restaurant Details**: Full information with image, address, hours, menu
- **Ratings Display**: Average rating and review count per restaurant

### 3. Reviews & Ratings
- **Write Reviews**: Add text reviews with ratings (1-5 stars)
- **Upload Photos**: Attach food photos to reviews
- **View Reviews**: See all reviews for a restaurant sorted by newest first
- **Review Stats**: Automatic rating recalculation

### 4. User Profile
- **Profile Display**: Username, email, profile avatar
- **My Reviews**: View all reviews posted by user
- **Account Info**: Join date and member status

### 5. Navigation
- **Bottom Navigation**: Easy switching between Home, Reviews, Profile
- **Stack Navigation**: Push/pop screens for drill-down experience
- **Back Button**: Intuitive back navigation

## Technology Stack

### Frontend
- **Framework**: Flutter 3.x (latest stable)
- **Language**: Dart 3.x
- **State Management**: Provider 6.0+
- **UI Library**: Material Design 3

### Backend & Services
- **Authentication**: Firebase Auth (Email/Password)
- **Database**: Cloud Firestore
- **Storage**: Firebase Storage
- **Utilities**: Google Fonts, Image Picker, Cached Network Images

### Design System
- **Color Palette**:
  - Primary Background: #F8F0E2 (Cream)
  - Accent: #002A8B (Deep Blue)
  - Text: #35353A (Dark Gray)
- **Typography**: Poppins (Google Fonts)
- **Spacing**: Consistent 8pt grid
- **Corners**: 12pt border radius

## Database Schema

### Firestore Collections

#### tbl_restaurants
```json
{
  "restaurant_id": "1",
  "name": "The Fort Bonifacio Food Hall",
  "address": "Bonifacio Global City, Taguig",
  "category": "Food Hall",
  "rating": 4.5,
  "reviews_count": 120,
  "image_url": "https://...",
  "description": "A vibrant food hall with various cuisines.",
  "opening_hours": "10 AM - 10 PM",
  "price_range": "₱₱₱",
  "featured_dishes": ["Pizza", "Burgers", "Sushi"]
}
```

#### tbl_reviews
```json
{
  "review_id": "1234567890",
  "restaurant_id": "1",
  "user_id": "uid123",
  "username": "foodie_john",
  "rating": 4.5,
  "content": "Amazing pizza! Highly recommend.",
  "image_url": "https://...",
  "timestamp": "2024-05-13T10:30:00Z"
}
```

#### tbl_users
```json
{
  "user_id": "uid123",
  "username": "foodie_john",
  "email": "john@example.com",
  "profile_image": "https://...",
  "joined_at": "2024-01-15T10:30:00Z"
}
```

## Key Code Patterns

### State Management (Provider)
```dart
final auth = Provider.of<AuthProvider>(context);
final restaurants = Provider.of<RestaurantProvider>(context);
```

### Firebase Queries
```dart
FirebaseFirestore.instance
  .collection('tbl_restaurants')
  .snapshots()
  .map((snapshot) => ...)
```

### Form Validation
```dart
if (!_formKey.currentState!.validate()) return;
```

### Navigation
```dart
Navigator.push(
  context,
  MaterialPageRoute(builder: (_) => DetailsScreen()),
);
```

## Getting Started

### Prerequisites
1. Flutter SDK (3.x+)
2. Dart SDK (3.x+)
3. Firebase account
4. Android Studio or VS Code

### Installation

```bash
# Clone repository
git clone https://github.com/yourusername/crumb_club.git
cd crumb_club

# Get dependencies
flutter pub get

# Set up Firebase (see FIREBASE_SETUP.md)

# Run app
flutter run
```

### Configuration
1. Follow FIREBASE_SETUP.md for Firebase project setup
2. Add google-services.json (Android)
3. Add GoogleService-Info.plist (iOS)
4. Update package name if different

## Testing

### Manual Testing Checklist
- [ ] Register with new email
- [ ] Login with credentials
- [ ] Search restaurants
- [ ] Filter by category
- [ ] View restaurant details
- [ ] Add review with rating
- [ ] Upload review image
- [ ] View profile
- [ ] View my reviews
- [ ] Logout

### Firebase Test Mode Rules
```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write: if request.auth != null;
    }
  }
}
```

## Performance Optimization

1. **Image Caching**: Using cached_network_image package
2. **Lazy Loading**: ListView.builder for large lists
3. **Provider Optimization**: Selective listening with Consumer
4. **Firestore Indexing**: Automatic for common queries
5. **Code Splitting**: Organized file structure for maintainability

## Security Considerations

1. **Authentication**: Firebase Auth handles password security
2. **Database Rules**: Row-level security in Firestore
3. **Data Validation**: Client-side and server-side validation
4. **Error Handling**: User-friendly error messages
5. **Null Safety**: Dart null safety enabled

## Known Limitations

1. Image upload to Storage not yet implemented
2. No offline functionality
3. No push notifications
4. No restaurant map view
5. No booking/reservation system

## Future Enhancements

1. **Image Upload**: Full Firebase Storage integration
2. **Advanced Search**: AI-powered recommendations
3. **Social Features**: Follow users, share reviews
4. **Favorites**: Save favorite restaurants
5. **Notifications**: Push alerts for new reviews
6. **Maps**: Google Maps integration
7. **Ratings**: Visual rating stars
8. **Filtering**: Price range, distance, cuisine filters
9. **Owner Dashboard**: For restaurant partners
10. **Analytics**: User behavior tracking

## Deployment

### Android
```bash
flutter build apk --release
# APK available at: build/app/outputs/apk/release/app-release.apk
```

### iOS
```bash
flutter build ios --release
# Follow App Store Connect upload process
```

## Support & Contributing

For issues or feature requests:
1. Check existing Firebase setup guide
2. Review code comments
3. Check Flutter/Firebase documentation
4. Open GitHub issue with details

## License

This project is private academic work.

## Author

Built with Flutter, Dart, and Firebase as a comprehensive restaurant discovery application.

## Acknowledgments

- Flutter and Dart teams
- Firebase platform
- Google Fonts
- Open-source community

---

**Last Updated**: May 13, 2026
**Version**: 1.0.0
**Status**: Development

