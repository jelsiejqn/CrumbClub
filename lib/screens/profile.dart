import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

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
        body: Center(
          child: CircularProgressIndicator(color: brandColor),
        ),
      );
    }

    return Scaffold(
      backgroundColor: creamColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 16.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo
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
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: brandColor,
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 4),

              // Email
              Text(
                user.email,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: darkGray,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),

              // Joined Date
              Text(
                'Joined: ${user.joinedAt.toDate().toString().split(' ')[0]}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: darkGray,
                  fontSize: 14,
                ),
              ),

              const Spacer(),

              // Logout Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (dialogContext) => Dialog(
                        backgroundColor: Colors.transparent,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          padding: const EdgeInsets.all(28),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Icon badge
                              Container(
                                width: 64,
                                height: 64,
                                decoration: BoxDecoration(
                                  color:
                                  brandColor.withOpacity(0.08),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.logout_rounded,
                                  color: brandColor,
                                  size: 30,
                                ),
                              ),
                              const SizedBox(height: 20),

                              // Title
                              const Text(
                                'Log Out',
                                style: TextStyle(
                                  color: brandColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 0.3,
                                ),
                              ),
                              const SizedBox(height: 8),

                              // Subtitle
                              const Text(
                                'Are you sure you want to log out?',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: darkGray,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  height: 1.5,
                                ),
                              ),
                              const SizedBox(height: 28),

                              // Buttons
                              Row(
                                children: [
                                  // Cancel
                                  Expanded(
                                    child: TextButton(
                                      onPressed: () =>
                                          Navigator.pop(dialogContext),
                                      style: TextButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        foregroundColor: brandColor,
                                        padding:
                                        const EdgeInsets.symmetric(
                                          vertical: 14,
                                        ),
                                        shape:
                                        RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(12),
                                        ),
                                      ),
                                      child: const Text(
                                        'Cancel',
                                        style: TextStyle(
                                          fontWeight:
                                          FontWeight.w700,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),

                                  // Log Out
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(dialogContext);
                                        auth.signOut();
                                      },
                                      style:
                                      ElevatedButton.styleFrom(
                                        backgroundColor:
                                        brandColor,
                                        foregroundColor:
                                        creamColor,
                                        elevation: 0,
                                        padding:
                                        const EdgeInsets.symmetric(
                                          vertical: 14,
                                        ),
                                        shape:
                                        RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(12),
                                        ),
                                      ),
                                      child: const Text(
                                        'Log Out',
                                        style: TextStyle(
                                          fontWeight:
                                          FontWeight.w700,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: brandColor,
                    foregroundColor: creamColor,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Log Out',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
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