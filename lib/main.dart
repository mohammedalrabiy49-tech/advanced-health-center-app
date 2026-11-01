import 'package:advaced_health_center/screens/home_screen.dart';
import 'package:advaced_health_center/screens/login_screen.dart';
import 'package:advaced_health_center/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();

    // 1. هل شاهَد شاشة الترحيب من قبل؟
    bool seenOnboarding = box.read('seenOnboarding') ?? false;
    // 2. هل هو مسجل دخول حالياً؟
    bool isLoggedIn = box.read('isLoggedIn') ?? false;

    // تحديد المسار الافتراضي بناءً على الحالة
    String initialScreen = '/onboarding';
    if (seenOnboarding) {
      initialScreen = isLoggedIn ? '/home' : '/login';
    }

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Advanced Health Center',
      initialRoute: initialScreen,
      getPages: [
        GetPage(name: '/onboarding', page: () => const OnboardingScreen()),
        GetPage(name: '/login', page: () => const LoginScreen()),
        GetPage(name: '/home', page: () => const HomeScreen()),
      ],
    );
  }
}
