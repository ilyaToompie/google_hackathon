import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_google/core/extensions/theme_extension.dart';
import 'package:hackathon_google/features/users/user_model.dart';
import 'package:hackathon_google/shared/profile_button/profile_button.dart';
import 'package:hackathon_google/shared/themed_background/themed_background.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          FutureBuilder<AppUser?>(
            future: loadUser(),
            builder: (context, snapshot) {
              return ProfileButton(user: snapshot.data);
            },
          ),
          SizedBox(width: 20),
        ],

        title: Text('home-screen.title'.tr()),
      ),

      body: ThemedBackground(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Home Screen', style: context.text.headlineLarge),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Action for button
              },
              child: Text('Click Me'),
            ),
          ],
        ),
      ),
    );
  }
}
