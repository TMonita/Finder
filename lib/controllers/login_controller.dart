import 'package:flutter_application_1/service/dio.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class LoginController extends GetxController {
  final Dio _dio = DioService.getInstance();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // Reactive variables
  var isLoading = false.obs;
  var isLoggedIn = false.obs;

  // For text fields
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // Register user
  Future<void> register({
    String? username,
    String? email,
    String? password,
  }) async {
    isLoading.value = true;
    try {
      print('email:$username, $email , $password');
      final response = await _dio.post(
        '/api/v1/users/register',
        data: {
          "username": username,
          "email": email,
          "password": password,
          "method": "email",
        },
      );

      print('Response: ${response.data}');

      if (response.data['success'] == true) {
        final data = response.data['data'];

        final token =
            data is Map && data['token'] is String
                ? data['token']
                : data is Map && data['token'] is List
                ? data['token'].first.toString()
                : null;

        if (token != null) {
          // await _storage.write(key: 'access_token', value: token);
          // isLoggedIn.value = true;
          // Get.snackbar("✅ Success", "Register successful");

          //updated
          await _storage.write(key: 'access_token', value: token);

          if (data['id'] != null) {
            await _storage.write(key: 'user_id', value: data['id'].toString());
          }

          isLoggedIn.value = true;
          Get.snackbar("✅ Success", "Login successful");
          Get.offAllNamed('/mainscreen');
        } else {
          Get.snackbar("Error", "Invalid token format from server");
        }
      } else {
        Get.snackbar(
          "Error",
          response.data['error'] ??
              response.data['message'] ??
              "Register failed",
        );
      }
    } on DioException catch (e) {
      print("DioException: ${e.response?.data}");
      Get.snackbar("Error", e.response?.data['message'] ?? "Register failed");
    } finally {
      isLoading.value = false;
    }
  }

  // Login user
  Future<void> login({String? email, String? password}) async {
    isLoading.value = true;
    try {
      print('email: $email , $password');
      final response = await _dio.post(
        '/api/v1/users/login',
        data: {"email": email, "password": password, "method": "email"},
      );

      print('Response: ${response.data}');

      if (response.data['success'] == true) {
        final data = response.data['data'];

        // ✅ Safely extract token only if it's a String
        final token =
            data is Map && data['token'] is String
                ? data['token']
                : data is Map && data['token'] is List
                ? data['token'].first.toString()
                : null;

        if (token != null) {
          // await _storage.write(key: 'access_token', value: token);
          // isLoggedIn.value = true;
          // Get.snackbar("✅ Success", "Login successful");

          await _storage.write(key: 'access_token', value: token);

          // ✅ Save userId
          if (data['id'] != null) {
            await _storage.write(key: 'user_id', value: data['id'].toString());
          }

          isLoggedIn.value = true;
          Get.snackbar("✅ Success", "Login successful");

          Get.offAllNamed('/mainscreen');
        } else {
          Get.snackbar("Error", "Invalid token format from server");
        }
      } else {
        Get.snackbar(
          "Error",
          response.data['error'] ?? response.data['message'] ?? "Login failed",
        );
      }
    } on DioException catch (e) {
      print("DioException: ${e.response?.data}");
      Get.snackbar("Error", e.response?.data['message'] ?? "Login failed");
    } finally {
      isLoading.value = false;
    }
  }

  // Logout user
  // Future<void> logout() async {
  //   await _storage.delete(key: 'access_token');
  //   isLoggedIn.value = false;
  //   Get.offAllNamed('/logout');
  // }

  Future<void> logout() async {
    isLoading.value = true;
    try {
      final token = await _storage.read(key: 'access_token');

      // Optional: Notify backend (if supported)
      if (token != null) {
        try {
          await _dio.post(
            '/api/v1/users/logout',
            options: Options(headers: {'Authorization': 'Bearer $token'}),
          );
        } catch (e) {
          print('Logout API failed, proceeding to local cleanup...');
        }
      }

      // Clear secure storage & local state
      await _storage.delete(key: 'access_token');
      emailController.clear();
      passwordController.clear();
      usernameController.clear();
      isLoggedIn.value = false;

      Get.snackbar("👋 Logged Out", "You have been logged out successfully");
      Get.offAllNamed('/login'); // safer redirect
    } catch (e) {
      Get.snackbar("Error", "Something went wrong during logout");
      print("Logout error: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
