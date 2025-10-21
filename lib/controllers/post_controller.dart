import 'dart:io';

import 'package:flutter_application_1/service/dio.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

class PostController extends GetxController {
  var isLoading = false.obs;
  var isSuccess = false.obs;
  var errorMessage = ''.obs;

  /// Create a new report/post
  Future<void> createReport({
    required String type,
    required String title,
    required String timeLostAt,
    required String description,
    required String location,
    required String imageUrl,
    required int userId,
    required int categoryId,
    File? imageFile,
  }) async {
    isLoading.value = true;
    isSuccess.value = false;
    errorMessage.value = '';

    try {
      final response = await DioService.post(
        '/api/v1/reports',
        data: {
          "type": type,
          "title": title,
          "timeLostAt": timeLostAt,
          "description": description,
          "location": location,
          "imageUrl": imageUrl,
          "userId": userId,
          "categoryId": categoryId,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        isSuccess.value = true;
        Get.snackbar('Success', 'Report created successfully ✅');
      } else {
        errorMessage.value =
            response.data['message'] ?? 'Failed to create report';
        Get.snackbar('Error', errorMessage.value);
      }
    } on DioError catch (e) {
      if (e.response != null) {
        errorMessage.value = e.response?.data['message'] ?? 'Request failed';
      } else {
        errorMessage.value = e.message ?? 'Unexpected error';
      }
      Get.snackbar('Error', errorMessage.value);
    } finally {
      isLoading.value = false;
    }
  }
}
