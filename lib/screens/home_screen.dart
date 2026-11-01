import 'package:advaced_health_center/HomeController/HomeController.dart';
import 'package:advaced_health_center/screens/bookings_screen.dart';
import 'package:advaced_health_center/screens/queue_screen.dart';
import 'package:advaced_health_center/screens/team_screen.dart';
import 'package:advaced_health_center/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    // حقن الـ HomeController
    final HomeController controller = Get.put(HomeController());

    // 1. قائمة الشاشات الخمس المرتبطة بالشريط السفلي بالترتيب الصحيح
    final List<Widget> screens = [
      _buildHomeMainContent(context, controller), // 0: الرئيسية
      const BookingsScreen(), // 1: حجزاتي
      const QueueScreen(), // 2: الدور
      const TeamScreen(), // 3: الفريق
      const ProfileScreen(), // 4: حسابي
    ];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 1, 31, 60),

        // 2. تغيير الشاشة المعروضة ديناميكياً بناءً على اختيار الشريط السفلي
        body: Obx(
          () => IndexedStack(
            index: controller.selectedNavIndex.value,
            children: screens,
          ),
        ),

        // 3. الشريط السفلي المباشر والفعال
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            backgroundColor: const Color.fromARGB(255, 1, 22, 45),
            selectedItemColor: Colors.blueAccent,
            unselectedItemColor: Colors.white54,
            currentIndex: controller.selectedNavIndex.value,
            type: BottomNavigationBarType.fixed,
            onTap: (index) => controller.changeNavIndex(index),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'الرئيسية',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today),
                label: 'حجزاتي',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list_alt),
                label: 'الدور',
              ),
              BottomNavigationBarItem(icon: Icon(Icons.group), label: 'الفريق'),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: 'حسابي'),
            ],
          ),
        ),
      ),
    );
  }

  // --- محتوى واجهة الرئيسية الأصلي ---
  Widget _buildHomeMainContent(
    BuildContext context,
    HomeController controller,
  ) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // الهيدر العلوي
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.notifications_outlined,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    Text(
                      'Advanced health centre',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'فاذا مرضت فهو يشفين ',
                      style: TextStyle(color: Colors.white60, fontSize: 12),
                    ),
                  ],
                ),
                const CircleAvatar(
                  radius: 24,
                  backgroundImage: AssetImage('assets/images/cover.png'),
                  backgroundColor: Colors.blueGrey,
                ),
              ],
            ),
            const SizedBox(height: 20),

            // شريط البحث
            TextField(
              onChanged: (value) => controller.updateSearchQuery(value),
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'ابحث عن خدمة...',
                hintStyle: const TextStyle(color: Colors.white54),
                prefixIcon: const Icon(Icons.search, color: Colors.white54),
                filled: true,
                fillColor: Colors.white.withOpacity(0.08),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // البانر الرئيسي
            Container(
              height: 160,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: const DecorationImage(
                  image: AssetImage('assets/images/cover.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.black.withOpacity(0.25),
                    ),
                  ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          CircleAvatar(
                            radius: 3,
                            backgroundColor: Colors.white,
                          ),
                          SizedBox(width: 5),
                          Text(
                            'مفتوح الآن',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Positioned(
                    bottom: 12,
                    right: 12,
                    child: Text(
                      'Advanced health centre',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // الفئات الأفقية
            SizedBox(
              height: 45,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.categories.length,
                itemBuilder: (context, index) {
                  return Obx(() {
                    bool isSelected =
                        controller.selectedCategoryIndex.value == index;
                    return GestureDetector(
                      onTap: () => controller.changeCategory(index),
                      child: Container(
                        margin: const EdgeInsets.only(left: 10),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.blueAccent
                              : Colors.white.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Row(
                          children: [
                            if (index == 0) ...[
                              const Icon(
                                Icons.grid_view,
                                color: Colors.white,
                                size: 18,
                              ),
                              const SizedBox(width: 6),
                            ],
                            Text(
                              controller.categories[index],
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
                },
              ),
            ),
            const SizedBox(height: 20),

            // عنوان الخدمات
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                  () => Text(
                    'الخدمات (${controller.displayedServices.length})',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => controller.changeCategory(0),
                  child: const Text(
                    'عرض الكل',
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // قائمة الخدمات
            Obx(() {
              final services = controller.displayedServices;
              if (services.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: Center(
                    child: Text(
                      'لا توجد خدمات متاحة في هذه الفئة حالياً',
                      style: TextStyle(color: Colors.white54, fontSize: 16),
                    ),
                  ),
                );
              }
              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: services.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final service = services[index];
                  return _buildServiceCard(
                    title: service.title,
                    time: service.time,
                    price: service.price,
                    imageUrl: service.image,
                    onBookTap: () =>
                        controller.goToBooking(service.title, service.price),
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  // بطاقة الخدمة
  Widget _buildServiceCard({
    required String title,
    required String time,
    required String price,
    required String imageUrl,
    required VoidCallback onBookTap,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          ElevatedButton(
            onPressed: onBookTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            child: const Text('احجز', style: TextStyle(color: Colors.white)),
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Text(
                    price,
                    style: const TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text('  •  ', style: TextStyle(color: Colors.white54)),
                  Text(
                    time,
                    style: const TextStyle(color: Colors.white54, fontSize: 12),
                  ),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.access_time,
                    color: Colors.white54,
                    size: 14,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(width: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imageUrl,
              width: 65,
              height: 65,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
