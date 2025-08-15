import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hackathon_google/core/extensions/theme_extension.dart';
import 'package:hackathon_google/features/dashboard_screen/dashboard_screen.dart';
import 'package:hackathon_google/features/industrial_pulse/industrial_pulse.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    DashboardScreen(),
    IndustrialPulse(),
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
                      duration: Duration(milliseconds: 200),
                      selectedIndex: _selectedIndex,
                      onTabChange: (index) {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                      gap: 8,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      activeColor: context.colors.onPrimary,
                      color: context.colors.onPrimary,
                      tabBackgroundColor: context.colors.primary,
                      tabs: [
                        GButton(
                          icon: Icons.dashboard_rounded,
                          text: 'navigation.dash-board'.tr(),
                        ),
                        GButton(
                          icon: Icons.factory_rounded,
                          text: 'navigation.industrial_pulse'.tr(),
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
