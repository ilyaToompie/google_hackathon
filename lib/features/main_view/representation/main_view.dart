import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hackathon_google/core/extensions/theme_extension.dart';
import 'package:hackathon_google/features/auth_screen/auth_screen.dart';
import 'package:hackathon_google/features/home_screen/representation/home_screen.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const AuthScreen(),
    const Center(child: Text('Home Screen')),
    const Center(child: Text('Home Screen')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: _screens[_selectedIndex]),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 3,
                        spreadRadius: 2,
                        color: Colors.grey[400]!,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(32),
                    color: context.colors.secondary,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GNav(
                      textSize: context.text.displayLarge!.fontSize,
                      duration: Duration(milliseconds: 200),
                      selectedIndex: _selectedIndex,
                      onTabChange: (index) {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                      gap: 8,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      activeColor: context.colors.onPrimary,
                      color: context.colors.onPrimary,
                      tabBackgroundColor: context.colors.primary,
                      tabs: [
                        GButton(
                          icon: Icons.home_rounded,
                          text: 'navigation.home-screen'.tr(),
                        ),
                        GButton(
                          icon: Icons.school_rounded,
                          text: 'navigation.learn-screen'.tr(),
                        ),
                        GButton(
                          icon: Icons.sports_martial_arts_rounded,
                          text: 'navigation.practice-screen'.tr(),
                        ),
                        GButton(
                          icon: Icons.favorite_rounded,
                          text: 'navigation.social-screen'.tr(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
