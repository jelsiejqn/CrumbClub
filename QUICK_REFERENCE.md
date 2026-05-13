# Crumb Club - Quick Reference Guide

## 🚀 Quick Start (5 Minutes)

### 1. Create Firebase Project (2 min)
```
https://console.firebase.google.com
+ Create project → crumb-club
+ Add Android app → download google-services.json
+ Enable Auth (Email/Password)
+ Enable Firestore (Test Mode)
```

### 2. Configure Android (2 min)
```
Place google-services.json in:
android/app/google-services.json
```

### 3. Run App (1 min)
```bash
flutter clean
flutter pub get
flutter run
```

---

## 🎯 File Reference

| File | Purpose |
|------|---------|
| `main.dart` | App setup, theme, auth wrapper |
| `constants/colors.dart` | Color palette |
| `models/*.dart` | Data structures |
| `services/*.dart` | Firebase wrappers |
| `providers/*.dart` | State management |
| `screens/home.dart` | Restaurant list & search |
| `screens/restaurant_details.dart` | Details & reviews |
| `screens/review_page.dart` | Write review form |
| `screens/profile.dart` | User profile |
| `utils/seed_restaurants.dart` | 70 restaurants data |

---

## 🔑 Key Code Snippets

### Access Auth
```dart
final auth = Provider.of<AuthProvider>(context);
final user = auth.user;
```

### Access Restaurants
```dart
final restaurantProvider = Provider.of<RestaurantProvider>(context);
final restaurants = restaurantProvider.restaurants;
```

### Make API Call
```dart
await FirestoreService().addReview(review);
```

### Stream Data
```dart
StreamBuilder<List<Review>>(
  stream: firestoreService.getReviews(restaurantId),
  builder: (context, snapshot) { ... }
)
```

---

## 🎨 Color Codes

```
Background:  #F8F0E2  (Cream)
Accent:      #002A8B  (Blue)
Text:        #35353A  (Dark Gray)
White:       #FFFFFF
```

---

## 🗂️ Collections Structure

```
tbl_restaurants/
  ├─ restaurant_id (string)
  ├─ name (string)
  ├─ rating (number)
  └─ ... 10+ more fields

tbl_reviews/
  ├─ review_id (string)
  ├─ restaurant_id (string)
  ├─ rating (number)
  └─ timestamp (timestamp)

tbl_users/
  ├─ user_id (string)
  ├─ username (string)
  └─ email (string)
```

---

## 📱 Screen Navigation

```
AuthWrapper (root)
├─ LoginScreen
│  └─ RegisterScreen
└─ HomeScreen (with BottomNavBar)
   ├─ HomeContent
   │  └─ RestaurantDetailsScreen
   │     └─ ReviewPage
   ├─ ReviewsScreen
   └─ ProfileScreen
```

---

## 🧪 Testing Credentials

```
Email: test@example.com
Password: test123456

(Create your own in Firebase Auth)
```

---

## ⚡ Common Commands

```bash
# Clean everything
flutter clean

# Get dependencies
flutter pub get

# Run app
flutter run

# Check code quality
flutter analyze

# Build APK
flutter build apk --release

# Check device
adb devices

# View logs
flutter logs
```

---

## 🐛 Quick Fixes

| Problem | Solution |
|---------|----------|
| App won't build | `flutter clean` |
| Dependencies not found | `flutter pub get` |
| Firebase error | Check google-services.json |
| No restaurants | Run seeding function |
| Auth error | Check email/password format |
| Image not showing | Check image URL |

---

## ✅ Pre-Launch Checklist

- [ ] Firebase project created
- [ ] google-services.json placed
- [ ] Auth enabled
- [ ] Firestore created
- [ ] Restaurants seeded
- [ ] App builds
- [ ] Can register
- [ ] Can login
- [ ] Can see restaurants
- [ ] Can add review

---

## 📊 App Stats

- **Total Files**: 15+ Dart files
- **Lines of Code**: ~2000+ LOC
- **Restaurants**: 70 pre-populated
- **Categories**: 6 main types
- **Build Time**: ~2-5 minutes
- **App Size**: ~50-70 MB (with assets)

---

## 🎓 Learning Points

✅ Firebase Auth (email/password)  
✅ Firestore (CRUD operations)  
✅ Real-time Streams  
✅ Provider state management  
✅ Material Design 3  
✅ Form validation  
✅ Image handling  
✅ Navigation patterns  
✅ Error handling  
✅ Clean architecture  

---

## 📚 Documentation

| Document | Content |
|----------|---------|
| README.md | Features overview |
| FIREBASE_SETUP.md | Detailed Firebase guide |
| APP_ARCHITECTURE.md | Architecture details |
| SETUP_INSTRUCTIONS.md | Step-by-step setup |
| QUICK_REFERENCE.md | This file |

---

## 💡 Pro Tips

1. **Use `flutter pub upgrade`** to get latest packages
2. **Run in Release mode** for testing: `flutter run --release`
3. **Check Firestore rules** if queries fail
4. **Use Postman** to test Firebase REST API
5. **Monitor Firebase console** in real-time
6. **Test on actual device** for real experience
7. **Use DevTools** for debugging: `flutter pub global run devtools`

---

## 🔗 Useful Links

- Firebase Console: https://console.firebase.google.com
- Flutter Dev: https://flutter.dev
- Dart Packages: https://pub.dev
- Google Fonts: https://fonts.google.com
- Material Design: https://material.io

---

## 🎬 Demo Flow

1. **Register** → Create account
2. **Login** → Show home
3. **Search** → Find "Matcha Café"
4. **Filter** → Show only "Café" category
5. **View Details** → Show full info
6. **Add Review** → Rate 5 stars
7. **Submit** → Show confirmation
8. **Profile** → See your review
9. **Logout** → Return to login

---

## 🔐 Security Notes

- Passwords: Min 6 characters, Firebase validates
- Database: Rules enforce authenticated access
- Null Safety: Prevents runtime errors
- Validation: All forms validated before submit

---

## 📞 Support Quick Links

| Issue | Link |
|-------|------|
| Firebase Help | firebase.google.com/support |
| Flutter Issues | github.com/flutter/flutter/issues |
| Dart Help | dart.dev/help |
| Stack Overflow | stackoverflow.com/questions/tagged/flutter |

---

## ✨ Highlights for Presentation

🌟 **70 Realistic Metro Manila Restaurants**  
🌟 **Real-time Firestore Integration**  
🌟 **Beautiful Material Design 3 UI**  
🌟 **Complete Authentication System**  
🌟 **Review & Rating System**  
🌟 **Search & Filter Functionality**  
🌟 **User Profile Management**  
🌟 **Production-Ready Code Quality**  

---

**Version**: 1.0.0  
**Status**: Complete & Ready  
**Date**: May 13, 2026  

Good luck! 🚀

