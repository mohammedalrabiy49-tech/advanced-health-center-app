import 'package:advaced_health_center/bookings_controller/bookings_controller.dart';
import 'package:advaced_health_center/screens/SecurityScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfileController extends GetxController {
  var userName = 'محمد ماجد الربعي'.obs;
  var userEmail = 'aboalrabiy@gmail.com'.obs;
  var userPassword = 'Alrabiy*2004'.obs;
  var userPhone = '+970 59 000 0000'.obs;

  // حقول التحكم لتغيير كلمة المرور في شاشة الأمان
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();

  // 1. عرض التنبيهات والحجوزات والوقت المتبقي ديناميكياً
  void showNotificationsAndBookings() {
    try {
      final BookingsController bookingsController =
          Get.find<BookingsController>();
      if (bookingsController.bookings.isEmpty) {
        Get.snackbar(
          'الإشعارات',
          'لا توجد حجوزات نشطة حالياً لتنبيهك بها',
          backgroundColor: Colors.blueGrey,
          colorText: Colors.white,
        );
        return;
      }

      Get.bottomSheet(
        Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 1, 22, 45),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Wrap(
            children: [
              const Text(
                'تنبيهات الحجوزات والمواعيد',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              ...bookingsController.bookings.map((booking) {
                String dateStr = booking['date'] ?? '2026-11-05';
                String timeRemainingText = 'قريباً';

                try {
                  DateTime bookingDate = DateTime.parse(dateStr);
                  DateTime now = DateTime.now();
                  int differenceDays = bookingDate
                      .difference(DateTime(now.year, now.month, now.day))
                      .inDays;

                  if (differenceDays > 0) {
                    timeRemainingText = 'متبقي $differenceDays أيام';
                  } else if (differenceDays == 0) {
                    timeRemainingText = 'الموعد اليوم!';
                  } else {
                    timeRemainingText = 'فات موعده';
                  }
                } catch (e) {
                  timeRemainingText = 'موعد قادم';
                }

                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            booking['title'] ?? '',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'التاريخ: $dateStr • ${booking['time']}',
                            style: const TextStyle(
                              color: Colors.white54,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.tealAccent.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          timeRemainingText,
                          style: const TextStyle(
                            color: Colors.tealAccent,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      );
    } catch (e) {
      Get.snackbar('تنبيه', 'لا توجد حجوزات مسجلة بعد');
    }
  }

  // 2. الانتقال إلى شاشة الأمان المستقلة
  void goToSecurityScreen() {
    Get.to(() => const SecurityScreen()); // تأكد من استيراد الملف إذا لزم
  }

  // دالة تحديث كلمة المرور
  void updatePassword() {
    if (currentPasswordController.text == userPassword.value) {
      if (newPasswordController.text.length >= 6) {
        userPassword.value = newPasswordController.text;
        currentPasswordController.clear();
        newPasswordController.clear();
        Get.back();
        Get.snackbar(
          'نجاح',
          'تم تحديث كلمة المرور بنجاح',
          backgroundColor: Colors.teal,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        Get.snackbar(
          'خطأ',
          'كلمة المرور الجديدة يجب أن تكون 6 أحرف على الأقل',
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      }
    } else {
      Get.snackbar(
        'خطأ',
        'كلمة المرور الحالية غير صحيحة',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }

  // 3. عرض نبذة عن المركز الصحي
  void showAboutCenter() {
    Get.defaultDialog(
      title: 'عن المركز الصحي',
      titleStyle: const TextStyle(color: Colors.white),
      backgroundColor: const Color.fromARGB(255, 1, 22, 45),
      content: const Text(
        'Advanced Health Centre هو مركز طبي متطور يهدف لتقديم أفضل الخدمات الصحية والرعاية العلاجية بأحدث التقنيات الطبية وتحت إشراف نخبة من الأطباء المختصين.\n\n"فإذا مرضت فهو يشفين"',
        style: TextStyle(color: Colors.white70, fontSize: 14),
        textAlign: TextAlign.center,
      ),
      confirm: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
        onPressed: () => Get.back(),
        child: const Text('حسناً', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  // 4. تسجيل الخروج
  void logout() {
    Get.defaultDialog(
      title: 'تسجيل الخروج',
      titleStyle: const TextStyle(color: Colors.white),
      middleText: 'هل أنت متأكد من رغبتك في تسجيل الخروج؟',
      middleTextStyle: const TextStyle(color: Colors.white70),
      backgroundColor: const Color.fromARGB(255, 1, 22, 45),
      textConfirm: 'نعم',
      textCancel: 'إلغاء',
      confirmTextColor: Colors.white,
      buttonColor: Colors.redAccent,
      onConfirm: () {
        // **هنا الحل: تعريف صندوق التخزين المحلي أولاً**
        final box = GetStorage();

        // 1. مسح حالة تسجيل الدخول من التخزين المحلي
        box.remove('isLoggedIn');
        box.remove('userEmail');

        // 2. إغلاق نافذة الحوار
        Get.back();

        // 3. التوجيه الإجباري لشاشة تسجيل الخروج
        Get.offAllNamed('/login');

        Get.snackbar(
          'خروج',
          'تم تسجيل الخروج بنجاح',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      },
    );
  }
}
