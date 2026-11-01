import 'package:advaced_health_center/queue_controller/queue_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingsController extends GetxController {
  // قائمة الحجوزات التفاعلية
  var bookings = [].obs;

  // تاريخ الحجز المحدد حالياً (يبدأ بتسجيل تاريخ اليوم افتراضياً)
  var selectedDate = DateTime.now().obs;

  // دالة اختيار التاريخ عبر التقويم الحقيقي
  Future<void> pickDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Colors.blueAccent,
              onPrimary: Colors.white,
              surface: Color.fromARGB(255, 1, 22, 45),
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      selectedDate.value = picked;
      Get.snackbar(
        'تم تحديد التاريخ',
        'الموعد الجديد: ${picked.year}-${picked.month}-${picked.day}',
        backgroundColor: Colors.teal,
        colorText: Colors.white,
      );
    }
  }

  // إضافة حجز جديد
  void addNewBooking(String title, String price) {
    String formattedDate =
        "${selectedDate.value.year}-${selectedDate.value.month.toString().padLeft(2, '0')}-${selectedDate.value.day.toString().padLeft(2, '0')}";

    bookings.add({
      'id': DateTime.now().millisecondsSinceEpoch.toString(), // معرف فريد للحذف
      'title': title,
      'date': formattedDate,
      'time': '12:00 ظهراً',
      'status': 'مؤكد', // أو 'مكتمل'
      'price': price,
      'doctor': 'د. المسؤول',
    });

    _updateQueueSafely();

    Get.snackbar(
      'نجاح',
      'تم إضافة الحجز بنجاح',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.teal,
      colorText: Colors.white,
    );
  }

  // حذف أو إزالة حجز (سواء كان ملغياً أو مكتملأً)
  void removeBooking(String id) {
    bookings.removeWhere((booking) => booking['id'] == id);
    _updateQueueSafely();

    Get.snackbar(
      'تمت الإزالة',
      'تمت إزالة الحجز من القائمة بنجاح',
      backgroundColor: Colors.orange,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  // تحديث شاشة الدور بأمان
  void _updateQueueSafely() {
    if (Get.isRegistered<QueueController>()) {
      Get.find<QueueController>().updateQueue();
    }
  }
}
