import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

class ApiService {
  final String baseUrl = "https://dori.toldpath.com/api/v1";
  final String placeSlug = "advanced-health-centre";
  final GetStorage storage = GetStorage();

  // دالة تسجيل الدخول
  Future<dynamic> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/places/$placeSlug/auth/login'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'email': email, 'password': password}),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (data['data'] != null && data['data']['token'] != null) {
          storage.write('token', data['data']['token']);
        }
      }
      return data;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  // دالة إنشاء حساب جديد
  Future<dynamic> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation, // أضفنا هذا الحقل
    required String phone,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/places/$placeSlug/auth/register'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'phone': phone,
          'password_confirmation':
              passwordConfirmation, // إرسال تأكيد كلمة المرور للسيرفر
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (data['data'] != null && data['data']['token'] != null) {
          storage.write('token', data['data']['token']);
        }
      }
      return data;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
