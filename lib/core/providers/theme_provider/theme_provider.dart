import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.system);

bool isDarkMode(WidgetRef ref) =>
    ref.watch(themeModeProvider) == ThemeMode.dark;
