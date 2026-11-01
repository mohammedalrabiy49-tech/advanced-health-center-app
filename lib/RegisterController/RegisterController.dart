import 'package:advaced_health_center/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final ApiService _apiService = ApiService();

  // حقول الإدخال
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // متغيرات العين السحرية (إظهار / إخفاء كلمة المرور)
  var isPasswordHidden = true.obs;
  var isConfirmPasswordHidden = true.obs;

  // متغير حالة التحميل
  var isLoading = false.obs;

  // دالة تبديل رؤية كلمة المرور الأولى
  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  // دالة تبديل رؤية كلمة المرور الثانية
  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordHidden.value = !isConfirmPasswordHidden.value;
  }

  // دالة إنشاء الحساب
  void register() async {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String phone = phoneController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    // التحقق من تعبئة كافة الحقول
    if (name.isEmpty ||
        email.isEmpty ||
        phone.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      Get.snackbar(
        'تنبيه',
        'الرجاء تعبئة جميع الحقول المطلوبة',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    // التحقق من تطابق كلمتي المرور
    if (password != confirmPassword) {
      Get.snackbar(
        'تنبيه',
        'كلمة المرور وتأكيد كلمة المرور غير متطابقين',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading.value = true;
      var response = await _apiService.register(
        name: name,
        email: email,
        password: password,
        passwordConfirmation: confirmPassword, // تم التمرير هنا
        phone: phone,
      );
      isLoading.value = false;

      print('Server Response: $response'); // لطباعة الرد بدقة في التيرمينال

      if (response != null && response['status'] == true) {
        Get.snackbar(
          'نجاح',
          response['message'] ?? 'تم إنشاء الحساب بنجاح',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.back();
      } else {
        Get.snackbar(
          'خطأ',
          response?['message'] ?? 'فشل إنشاء الحساب، تأكد من البيانات',
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
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
