import 'package:flutter_application_1/service/dio.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

class SearchController extends GetxController {
  var isLoading = false.obs;
  var searchResults = [].obs;
  var searchText = ''.obs;

  /// Fetch and filter reports from the backend
  Future<void> searchReports(String query) async {
    try {
      isLoading.value = true;

      // Fetch all reports from your API
      final response = await DioService.get('/api/v1/reports');

      if (response.statusCode == 200 && response.data['success'] == true) {
        List data = response.data['data'];

        // Local filter (if backend doesn’t support ?q= search param)
        if (query.isNotEmpty) {
          final filtered =
              data.where((item) {
                final title = (item['title'] ?? '').toString().toLowerCase();
                final description =
                    (item['description'] ?? '').toString().toLowerCase();
                final location =
                    (item['location'] ?? '').toString().toLowerCase();
                final type = (item['type'] ?? '').toString().toLowerCase();

                return title.contains(query.toLowerCase()) ||
                    description.contains(query.toLowerCase()) ||
                    location.contains(query.toLowerCase()) ||
                    type.contains(query.toLowerCase());
              }).toList();

          searchResults.value = filtered;
        } else {
          searchResults.value = data;
        }
      } else {
        searchResults.clear();
      }
    } on DioError catch (e) {
      print('Search error: ${e.message}');
      searchResults.clear();
    } finally {
      isLoading.value = false;
    }
  }
}
