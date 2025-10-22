// import 'package:get/get.dart';
// import 'package:flutter_application_1/model/allitems_model.dart';
// import 'package:flutter_application_1/service/dio.dart';

// class ItemsController extends GetxController {
//   var isLoading = false.obs;
//   var itemList = <AllItemsModel>[].obs;
//   @override
//   void onInit() {
//     super.onInit();
//     fetchAllItems();
//   }

//   Future<void> fetchAllItems() async {
//     try {
//       isLoading(true);

//       final response = await DioService.get('/api/v1/reports');

//       if (response.statusCode == 200) {
//         final List<dynamic> dataList = response.data['data'];
//         itemList.value =
//             dataList.map((json) => AllItemsModel.fromJson(json)).toList();
//       } else {
//         Get.snackbar('Error', 'Failed to load items');
//       }
//     } catch (e) {
//       print('❌ Fetch error: $e');
//       Get.snackbar('Error', e.toString());
//     } finally {
//       isLoading(false);
//     }
//   }
// }

import 'package:get/get.dart';
import 'package:flutter_application_1/model/allitems_model.dart';
import 'package:flutter_application_1/service/dio.dart';

class ItemsController extends GetxController {
  var isLoading = false.obs;
  var itemList = <AllItemsModel>[].obs;

  // ✅ Filter states
  var categoryId = Rxn<int>(); // can be null initially
  var type = ''.obs; // "FOUND", "LOST", etc.

  @override
  void onInit() {
    super.onInit();
    fetchAllItems();
  }

  // ✅ Function to update filters and refetch items
  void updateFilter({int? newCategoryId, String? newType}) {
    if (newCategoryId != null) categoryId.value = newCategoryId;
    if (newType != null) type.value = newType;
    fetchAllItems();
  }

  Future<void> fetchAllItems() async {
    try {
      isLoading(true);

      // ✅ Build query parameters dynamically
      String query = '';
      if (categoryId.value != null || type.value.isNotEmpty) {
        query = '?';
        if (categoryId.value != null) {
          query += 'categoryId=${categoryId.value}';
        }
        if (type.value.isNotEmpty) {
          if (query.length > 1) query += '&';
          query += 'type=${type.value}';
        }
      }

      final response = await DioService.get('/api/v1/reports$query');

      if (response.statusCode == 200) {
        final List<dynamic> dataList = response.data['data'];
        itemList.value =
            dataList.map((json) => AllItemsModel.fromJson(json)).toList();
      } else {
        Get.snackbar('Error', 'Failed to load items');
      }
    } catch (e) {
      print('❌ Fetch error: $e');
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }
}
