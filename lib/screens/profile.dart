import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../services/firestore_service.dart';
import '../models/review.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const brandColor = Color(0xFF002A8B);
    const creamColor = Color(0xFFF8F0E2);
    const darkGray = Color(0xFF3A3A3A);

    final auth = Provider.of<AuthProvider>(context);
    final user = auth.userModel;

    if (user == null) {
      return const Scaffold(
        backgroundColor: creamColor,
        body: Center(child: CircularProgressIndicator(color: brandColor)),
      );
    }

    return Scaffold(
      backgroundColor: creamColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center, // ← everything centered
            children: [

              // Logo replaces AppBar
              Image.asset(
                'assets/images/logo2.png',
                height: 60,
              ),
              const SizedBox(height: 24),

              // Avatar
              CircleAvatar(
                radius: 46,
                backgroundColor: brandColor,
                backgroundImage: user.profileImage.isNotEmpty
                    ? NetworkImage(user.profileImage)
                    : null,
                child: user.profileImage.isEmpty
                    ? Text(
                  user.username[0].toUpperCase(),
                  style: const TextStyle(
                    fontSize: 36,
                    color: creamColor,
                    fontWeight: FontWeight.w900,
                  ),
                )
                    : null,
              ),
              const SizedBox(height: 14),

              // Username
              Text(
                user.username,
                style: const TextStyle(
                  color: brandColor,
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),

              // Email
              Text(
                user.email,
                style: const TextStyle(color: darkGray, fontSize: 14),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),

              // Joined date
              Text(
                'Joined: ${user.joinedAt.toDate().toString().split(' ')[0]}',
                style: const TextStyle(color: darkGray, fontSize: 14),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 300),

              // Logout button — blue filled, cream text
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (dialogContext) => AlertDialog(
                        title: const Text('Log Out'),
                        content: const Text('Are you sure you want to log out?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(dialogContext),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(dialogContext);
                              auth.signOut();
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.red,
                            ),
                            child: const Text('Log Out'),
                          ),
                        ],
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
                    'Logout',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}