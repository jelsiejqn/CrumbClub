# Crumb Club - Firebase Setup Guide

## Prerequisites

- Firebase account (https://firebase.google.com)
- Android Studio with Flutter & Dart plugins
- Flutter SDK (latest stable)
- Xcode (for iOS development)

## Step 1: Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com)
2. Click "Add Project"
3. Project Name: `crumb-club`
4. Enable Google Analytics (optional)
5. Click "Create project"

## Step 2: Register Your Apps

### Android App

1. In Firebase Console, click "Add app" → Android
2. Package name: `com.example.crumb_club`
3. App nickname: `Crumb Club Android`
4. Download `google-services.json`
5. Place it in `android/app/`

### iOS App (Optional)

1. Click "Add app" → iOS
2. Bundle ID: `com.example.crumbClub`
3. App nickname: `Crumb Club iOS`
4. Download `GoogleService-Info.plist`
5. Open Xcode project at `ios/Runner.xcworkspace`
6. Add the plist file to the Runner target

## Step 3: Enable Authentication

1. In Firebase Console, go to **Authentication**
2. Click "Get Started"
3. Click "Email/Password"
4. Enable Email/Password provider
5. Click "Save"

## Step 4: Create Firestore Database

1. Go to **Firestore Database**
2. Click "Create database"
3. Start in **Test Mode** (for development)
4. Choose your region (e.g., `asia-southeast1` for Philippines)
5. Click "Enable"

### Create Collections

Create the following collections in Firestore:

#### tbl_restaurants
- Fields: restaurant_id, name, address, category, rating, reviews_count, image_url, description, opening_hours, price_range, featured_dishes

#### tbl_reviews
- Fields: review_id, restaurant_id, user_id, username, rating, content, image_url, timestamp

#### tbl_users
- Fields: user_id, username, email, profile_image, joined_at

## Step 5: Enable Storage (Optional - for Review Images)

1. Go to **Storage**
2. Click "Get Started"
3. Start in **Test Mode**
4. Choose your region
5. Click "Enable"

## Step 6: Seed Database with Restaurants

### Option 1: Using Flutter App

1. Uncomment the seed function in your `main.dart`:
```dart
// In main(), add:
// await SeedRestaurants.seed();
```

2. Run the app once to populate the database
3. Comment it back out

### Option 2: Manual Import via Firebase Console

1. Go to Firestore Database
2. Create collection `tbl_restaurants`
3. Click "Add document"
4. Manually add restaurants or use bulk import

### Option 3: Use Firebase CLI

```bash
npm install -g firebase-tools
firebase login
firebase firestore:delete tbl_restaurants --all-collections
# Then run the app with seeding enabled
```

## Step 7: Firebase Rules (Security)

### For Testing (Development Only)

Go to Firestore Rules and set:

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

### For Production

```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /tbl_restaurants/{document=**} {
      allow read: if request.auth != null;
    }
    match /tbl_reviews/{document=**} {
      allow read: if request.auth != null;
      allow create: if request.auth != null;
    }
    match /tbl_users/{uid} {
      allow read, write: if request.auth.uid == uid;
    }
  }
}
```

## Step 8: Run the Flutter App

```bash
cd C:\Users\Dionne\AndroidStudioProjects\crumb_club
flutter pub get
flutter run
```

## Step 9: Test Authentication

1. Register a new user
2. Verify user appears in Firebase Authentication
3. Verify user document in Firestore `tbl_users`

## Step 10: Populate Test Data

On first run with seeding enabled, the app will populate 70 restaurants into Firestore.

## Troubleshooting

### Google Services Plugin Error
- Ensure `google-services.json` is in `android/app/`
- Rebuild: `flutter clean && flutter pub get && flutter run`

### Firestore Connection Error
- Check internet connection
- Verify Firebase project is active
- Check Firestore security rules
- Ensure collection names match exactly (tbl_restaurants, tbl_reviews, tbl_users)

### Authentication Error
- Verify Email/Password provider is enabled
- Check user credentials are correct
- Ensure strong password (min 6 characters)

### Image Loading Error
- Use placeholder images from https://via.placeholder.com/
- Or upload images to Firebase Storage and update URLs

## Next Steps

1. Implement image upload to Firebase Storage
2. Add favorites/bookmarks feature
3. Implement push notifications
4. Add restaurant map view
5. Implement advanced search filters
6. Add restaurant owner dashboard

## Support

For Firebase issues:
- https://firebase.google.com/support
- https://stackoverflow.com/questions/tagged/firebase

For Flutter issues:
- https://flutter.dev/docs
- https://github.com/flutter/flutter/issues

