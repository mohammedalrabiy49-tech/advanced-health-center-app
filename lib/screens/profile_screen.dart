import 'package:advaced_health_center/profile_controller/profile_controller.dart';
import 'package:advaced_health_center/screens/SecurityScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  void goToSecurityScreen() {
    Get.to(() => const SecurityScreen());
  }

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());

    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'حسابي الشخصي',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blueAccent,
                child: Icon(Icons.person, size: 50, color: Colors.white),
              ),
              const SizedBox(height: 16),
              Obx(
                () => Text(
                  controller.userName.value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Obx(
                () => Text(
                  controller.userEmail.value,
                  style: const TextStyle(color: Colors.white54, fontSize: 14),
                ),
              ),
              const SizedBox(height: 30),

              // 1. زر الإشعارات والتنبيهات (يعرض الحجوزات ووقتها)
              _buildProfileOption(
                icon: Icons.notifications_active_outlined,
                title: 'الإشعارات والتنبيهات',
                onTap: () => controller.showNotificationsAndBookings(),
              ),

              // 2. زر الأمان وكلمة المرور (ينتقل للشاشة الجديدة)
              _buildProfileOption(
                icon: Icons.lock_outline,
                title: 'الأمان وكلمة المرور',
                onTap: () => controller.goToSecurityScreen(), // <-- تعديل هنا
              ),

              // 3. زر عن المركز الطبي (يعرض نبذة مختصرة)
              _buildProfileOption(
                icon: Icons.info_outline,
                title: 'عن المركز الطبي',
                onTap: () => controller.showAboutCenter(),
              ),

              // 4. زر تسجيل الخروج
              _buildProfileOption(
                icon: Icons.logout,
                title: 'تسجيل الخروج',
                isRed: true,
                onTap: () => controller.logout(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isRed = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.white10),
        ),
        child: Row(
          children: [
            Icon(icon, color: isRed ? Colors.redAccent : Colors.blueAccent),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: isRed ? Colors.redAccent : Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white54,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
