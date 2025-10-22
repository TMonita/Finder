import 'package:flutter_application_1/service/dio.dart';
import 'package:get/get.dart';

class FilterController extends GetxController {
  var selectedCategory = ''.obs;
  var filters = {}.obs;
  var isLoading = false.obs;
  var filteredItems = [].obs;

  void selectCategory(String category) {
    if (selectedCategory.value == category) {
      selectedCategory.value = ''; // deselect
    } else {
      selectedCategory.value = category;
    }
  }

  void applyFilters() async {
    filters['category'] = selectedCategory.value;
    await fetchFilteredItems(); // fetch immediately when applied
  }

  Future<void> fetchFilteredItems() async {
    try {
      isLoading.value = true;

      Map<String, dynamic> queryParams = {};
      if (selectedCategory.isNotEmpty) {
        queryParams['category'] = selectedCategory.value;
      }

      final response = await DioService.get(
        '/api/v1/reports',
        queryParams: queryParams,
      );

      if (response.statusCode == 200) {
        filteredItems.value = response.data['data'] ?? [];
      }
    } catch (e) {
      print('Error fetching filtered items: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void clearFilters() {
    selectedCategory.value = '';
    filters.clear();
    filteredItems.clear();
  }
}
