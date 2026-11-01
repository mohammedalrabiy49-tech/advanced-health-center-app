import 'package:advaced_health_center/bookings_controller/bookings_controller.dart';
import 'package:advaced_health_center/models/service_model.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var selectedCategoryIndex = 0.obs;
  var selectedNavIndex = 0.obs;
  var searchQuery = ''.obs;

  final List<String> categories = [
    'الكل',
    'استشارات طبية',
    'تحاليل مخبرية',
    'أشعة وتصوير',
  ];

  final List<ServiceModel> allServices = [
    ServiceModel(
      title: 'صرف ادوية',
      category: 'استشارات طبية',
      time: '15 دقيقة',
      price: '15 ₪',
      image: 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?auto=format&fit=crop&w=200&q=80',
    ),
    ServiceModel(
      title: 'استشارة طبيب عام',
      category: 'استشارات طبية',
      time: '20 دقيقة',
      price: '30 ₪',
      image: 'https://images.unsplash.com/photo-1622253692010-333f2da6031d?auto=format&fit=crop&w=200&q=80',
    ),
    ServiceModel(
      title: 'تحاليل الدم الشاملة',
      category: 'تحاليل مخبرية',
      time: '10 دقائق',
      price: '50 ₪',
      image: 'https://images.unsplash.com/photo-1579684385127-1ef15d508118?auto=format&fit=crop&w=200&q=80',
    ),
    ServiceModel(
      title: 'فحص السكر التراكمي',
      category: 'تحاليل مخبرية',
      time: '10 دقائق',
      price: '35 ₪',
      image: 'https://images.unsplash.com/photo-1576091160399-112ba8d25d1d?auto=format&fit=crop&w=200&q=80',
    ),
    ServiceModel(
      title: 'تصوير الأشعة السينية',
      category: 'أشعة وتصوير',
      time: '20 دقيقة',
      price: '100 ₪',
      image: 'https://images.unsplash.com/photo-1516549655169-df83a0774514?auto=format&fit=crop&w=200&q=80',
    ),
  ];

  List<ServiceModel> get displayedServices {
    String cat = categories[selectedCategoryIndex.value];

    List<ServiceModel> filtered = cat == 'الكل'
        ? allServices
        : allServices.where((s) => s.category == cat).toList();

    if (searchQuery.value.trim().isNotEmpty) {
      filtered = filtered
          .where(
            (s) =>
                s.title.toLowerCase().contains(searchQuery.value.toLowerCase()),
          )
          .toList();
    }

    return filtered;
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }

  void changeCategory(int index) {
    selectedCategoryIndex.value = index;
  }

  void changeNavIndex(int index) {
    selectedNavIndex.value = index;
  }

  void goToBooking(String title, String price) {
    // 1. احصل على مثيل BookingsController
    final BookingsController bookingsController =
        Get.find<BookingsController>();

    // 2. أضف الحجز للقائمة
    bookingsController.addNewBooking(title, price);

    // 3. انتقل مباشرة لتبويب "حجزاتي" (الإندكس 1) لترى الحجز أمامك
    selectedNavIndex.value = 1;
  }
}
