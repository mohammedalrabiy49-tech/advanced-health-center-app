import 'package:advaced_health_center/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class OnboardingModel {
  final String imagePath;
  final String title;
  final String description;

  OnboardingModel({
    required this.imagePath,
    required this.title,
    required this.description,
  });
}

class OnboardingController extends GetxController {
  final PageController pageController = PageController();
  final GetStorage storage = GetStorage();
  var currentPage = 0.obs;

  // قائمة صفحات الترحيب بالأسماء الصحيحة للصور في مجلد assets/images/
  final List<OnboardingModel> pages = [
    OnboardingModel(
      imagePath: 'assets/images/profile.png',
      title: 'أهلاً بكم في المركز الطبي المتقدم',
      description: 'خدمات طبية شاملة، رعاية متميزة، وتقنيات متطورة لضمان صحتكم وأمانتكم.',
    ),
    OnboardingModel(
      imagePath: 'assets/images/medicaltest.png', // تم تصحيح الفاصلة إلى نقطة
      title: 'مختبرات وتحاليل طبية دقيقة',
      description:
          'نقدم أحدث الفحوصات الطبية والتحاليل المخبرية الشاملة بكل دقة وسرعة.',
    ),
    OnboardingModel(
      imagePath: 'assets/images/pharmacy.png',
      title: 'صيدلية وصرف الأدوية',
      description:
          'صرف الوصفات الطبية بسهولة ومتابعة مستمرة لدوائك عبر تطبيقنا.',
    ),
    OnboardingModel(
      imagePath: 'assets/images/specializedclinic.png',
      title: 'عيادات تخصصية متكاملة',
      description:
          'نخبة من الأطباء الاستشاريين والأخصائيين في خدمتكم ورعايتكم.',
    ),
  ];

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  void nextPage() {
    if (currentPage.value < pages.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      finishOnboarding();
    }
  }

  void finishOnboarding() {
    storage.write('isFirstTime', false);
    Get.off(() => const LoginScreen());
  }
}
