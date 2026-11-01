import 'package:advaced_health_center/bookings_controller/bookings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingsScreen extends StatelessWidget {
  const BookingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BookingsController controller = Get.put(BookingsController());
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // الهيدر مع زر التقويم الفعال
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'حجوزاتي والمواعيد',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.calendar_month,
                      color: Colors.blueAccent,
                    ),
                    onPressed: () => controller.pickDate(
                      context,
                    ), // فتح التقويم الحقيقي عند الضغط
                    tooltip: 'اختر تاريخ الحجز',
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // عرض التاريخ المختار حالياً
              Obx(
                () => Text(
                  'التاريخ المحدد للحجوزات الجديدة: ${controller.selectedDate.value.year}-${controller.selectedDate.value.month}-${controller.selectedDate.value.day}',
                  style: const TextStyle(color: Colors.white54, fontSize: 12),
                ),
              ),
              const SizedBox(height: 16),

              // قائمة الحجوزات
              Expanded(
                child: Obx(() {
                  if (controller.bookings.isEmpty) {
                    return const Center(
                      child: Text(
                        'لا توجد حجوزات نشطة حالياً',
                        style: TextStyle(color: Colors.white54, fontSize: 16),
                      ),
                    );
                  }

                  return ListView.separated(
                    itemCount: controller.bookings.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final booking = controller.bookings[index];
                      return Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.white10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  booking['title'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'التاريخ: ${booking['date']} • ${booking['time']}',
                                  style: const TextStyle(
                                    color: Colors.white54,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            // زر إزالة الحجز (سواء ملغي أو مكتمل)
                            IconButton(
                              icon: const Icon(
                                Icons.delete_outline,
                                color: Colors.redAccent,
                              ),
                              onPressed: () =>
                                  controller.removeBooking(booking['id']),
                              tooltip: 'إزالة الحجز',
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
