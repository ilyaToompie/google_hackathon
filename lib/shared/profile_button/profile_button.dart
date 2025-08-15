import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:hackathon_google/features/auth_screen/auth_screen.dart';
import 'package:hackathon_google/features/profile_screen/profile_screen.dart';
import 'package:hackathon_google/features/users/user_model.dart';
import 'package:hackathon_google/utils/adaptive_navigator/adaptive_navigator.dart';

class ProfileButton extends StatelessWidget {
  final AppUser? user;
  final double maxRadius;

  const ProfileButton({super.key, this.user, this.maxRadius = 22});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (user != null) {
          AdaptiveNavigator.push(context, ProfileScreen(user!.uid));
          return;
        }

        final currentUser = fb.FirebaseAuth.instance.currentUser;
        if (currentUser == null) {
          AdaptiveNavigator.push(context, const AuthScreen());
        } else {
          AdaptiveNavigator.push(context, ProfileScreen(currentUser.uid));
        }
      },
      child: CircleAvatar(
        minRadius: maxRadius - 2,
        maxRadius: maxRadius,
        foregroundImage: _getAvatarImage(),
      ),
    );
  }

  ImageProvider _getAvatarImage() {
    if (user != null && user!.photoUrl != null && user!.photoUrl!.isNotEmpty) {
      return NetworkImage(user!.photoUrl!);
    }
    return const AssetImage('assets/images/avatar.png');
  }
}
