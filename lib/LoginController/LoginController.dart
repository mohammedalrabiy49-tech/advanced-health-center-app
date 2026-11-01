import 'package:advaced_health_center/api_service.dart';
import 'package:advaced_health_center/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final ApiService _apiService = ApiService();

  // حقول الإدخال
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // متغير حالة التحميل
  var isLoading = false.obs;

  // متغير ودالة العين السحرية (إظهار وإخفاء كلمة المرور)
  var isPasswordHidden = true.obs;

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  // دالة تسجيل الدخول
  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar(
        'تنبيه',
        'الرجاء إدخال البريد الإلكتروني وكلمة المرور',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading.value = true;
      var response = await _apiService.login(email: email, password: password);
      isLoading.value = false;

      print('Login Response: $response'); // لطباعة الرد في التيرمينال

      if (response != null && response['success'] == true) {
        Get.snackbar(
          'نجاح',
          response['message'] ?? 'تم تسجيل الدخول بنجاح',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // الانتقال الشاشة الرئيسية (Home Screen) بعد نجاح تسجيل الدخول
        Get.offAll(() => const HomeScreen());
      } else {
        Get.snackbar(
          'خطأ',
          response?['message'] ?? 'فشل تسجيل الدخول، تأكد من البيانات',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'خطأ',
        'حدث خطأ غير متوقع: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
