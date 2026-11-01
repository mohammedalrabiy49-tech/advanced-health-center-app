import 'package:advaced_health_center/queue_controller/queue_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QueueScreen extends StatelessWidget {
  const QueueScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final QueueController controller = Get.put(QueueController());

    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'متابعة الدور المباشر',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              Expanded(
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: Colors.blueAccent.withOpacity(0.3),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.confirmation_number_outlined,
                          color: Colors.blueAccent,
                          size: 50,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'رقم دورك الحالي في الطابور',
                          style: TextStyle(color: Colors.white54, fontSize: 16),
                        ),
                        const SizedBox(height: 8),

                        // عرض رقم الدور المتغير
                        Obx(
                          () => Text(
                            controller.currentTicketNumber.value == 0
                                ? 'لا يوجد دور'
                                : '#${controller.currentTicketNumber.value}',
                            style: TextStyle(
                              color: controller.currentTicketNumber.value == 0
                                  ? Colors.white54
                                  : Colors.white,
                              fontSize:
                                  controller.currentTicketNumber.value == 0
                                  ? 28
                                  : 48,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        const Divider(color: Colors.white10, height: 30),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Obx(
                              () => _buildInfoColumn(
                                'أمامك أشخاص',
                                '${controller.peopleAhead.value} أشخاص',
                              ),
                            ),
                            Obx(
                              () => _buildInfoColumn(
                                'الوقت التقديري',
                                '${controller.estimatedMinutes.value} دقيقة',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoColumn(String title, String value) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.white54, fontSize: 13),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.tealAccent,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
