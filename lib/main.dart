import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:safe_guard/screens/app_navigator.dart';
import 'package:safe_guard/screens/login_screen.dart';
import 'package:safe_guard/screens/onboarding_screen.dart';
import 'package:safe_guard/screens/splash_screen.dart';
import 'package:safe_guard/theme/theme.dart';
import 'package:safe_guard/services/preferences_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize preferences service
  await PreferencesService.init();

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.white,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));

  runApp(const SafeGuardApp());
}

class SafeGuardApp extends StatelessWidget {
  const SafeGuardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SafeGuard',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      routes: {
        '/onboarding': (context) => const OnboardingScreen(),
        "/login": (context) => const LoginScreen(),
        '/home': (context) => const AppNavigator(),
      },
    );
  }
}
