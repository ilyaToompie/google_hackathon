import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackathon_google/core/providers/theme_provider/theme_provider.dart';
import 'package:hackathon_google/core/themes/themes.dart';
import 'package:hackathon_google/features/main_view/representation/main_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hackathon_google/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('kk'), Locale('ru')],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      child: ProviderScope(child: const MainApp()),
    ),
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      themeMode: themeMode,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: MainView(),
    );
  }
}
