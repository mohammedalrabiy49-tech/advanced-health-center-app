import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  final box = GetStorage(); // صندوق التخزين

  // دالة تسجيل الدخول
  void login(String email, String password) {
    // هنا تفترض أن بيانات الدخول صحيحة
    if (email.isNotEmpty && password.isNotEmpty) {
      // **حفظ أن المستخدم مسجل دخول بالفعل**
      box.write('isLoggedIn', true);
      box.write('userEmail', email); // حفظ الإيميل إذا احتجناه لاحقاً

      // الانتقال للشاشة الرئيسية ومنع الرجوع للخلف لصفحة تسجيل الدخول
      Get.offAllNamed('/home');
    } else {
      Get.snackbar(
        'خطأ',
        'يرجى إدخال البيانات بشكل صحيح',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // دالة تسجيل الخروج (لمسح البيانات المحفوظة عند الخروج)
  void logout() {
    box.remove('isLoggedIn');
    box.remove('userEmail');
    Get.offAllNamed('/login'); // العودة لشاشة تسجيل الدخول
  }
}
