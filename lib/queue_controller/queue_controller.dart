import 'package:advaced_health_center/bookings_controller/bookings_controller.dart';
import 'package:get/get.dart';

class QueueController extends GetxController {
  var currentTicketNumber = 0.obs;
  var peopleAhead = 0.obs;
  var estimatedMinutes = 0.obs;

  @override
  void onInit() {
    super.onInit();
    updateQueue();
  }

  // دالة لتحديث الدور بدقة بناءً على الحجوزات الحالية
  void updateQueue() {
    try {
      if (Get.isRegistered<BookingsController>()) {
        final BookingsController bookingsController =
            Get.find<BookingsController>();
        int count = bookingsController.bookings.length;

        if (count == 0) {
          // إذا لم تكن هناك حجوزات، يكون الدور صفر أو غير مفعل
          currentTicketNumber.value = 0;
          peopleAhead.value = 0;
          estimatedMinutes.value = 0;
        } else {
          // إذا وجدت حجوزات، يبدأ الدور من 10 ويithزاد مع عدد الحجوزات
          currentTicketNumber.value = 9 + count;
          peopleAhead.value = count - 1 >= 0 ? count - 1 : 0;
          estimatedMinutes.value = peopleAhead.value * 5;
        }
      }
    } catch (e) {
      currentTicketNumber.value = 0;
    }
  }
}
