import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:flutter_application_1/service/dio.dart';
import 'package:flutter_application_1/model/allitems_model.dart';

class MyReportController extends GetxController {
  final Dio _dio = DioService.getInstance();

  // Reactive state variables
  var isLoading = false.obs;
  var myReports = <AllItemsModel>[].obs;
  var errorMessage = ''.obs;

  /// Fetch all reports for a specific user
  Future<void> fetchMyReports(int userId) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final response = await _dio.get(
        '/api/v1/users/$userId/history-report-all',
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        final List data = response.data['data'];

        myReports.value =
            data.map((json) => AllItemsModel.fromJson(json)).toList();
      } else {
        errorMessage.value = 'Failed to fetch reports';
      }
    } on DioError catch (e) {
      errorMessage.value =
          e.response?.data?['message'] ?? 'Network error occurred';
    } catch (e) {
      errorMessage.value = 'Unexpected error: $e';
    } finally {
      isLoading.value = false;
    }
  }
}
