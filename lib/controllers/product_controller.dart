// import 'package:flutter_application_1/model/postitems_model.dart';
// import 'package:flutter_application_1/service/dio.dart';
// import 'package:get/get.dart';
// // import 'package:dio/dio.dart' as dio;

// class ProductController extends GetxController {
//   var isLoading = false.obs;
//   var productList = <PostItemModel>[].obs;

//   @override
//   void onInit() {
//     fetchAllPosts();
//     super.onInit();
//   }

//   Future<void> fetchAllPosts() async {
//     try {
//       isLoading.value = true;

//       final response = await DioService.get('/api/v1/reports');

//       if (response.statusCode == 200) {
//         final List<dynamic> dataList = response.data['data'];
//         productList.value =
//             dataList.map((json) => PostItemModel.fromJson(json)).toList();
//       } else {
//         Get.snackbar('Error', 'Failed to load posts');
//       }
//     } catch (e) {
//       print('❌ Fetch error: $e');
//       Get.snackbar('Error', e.toString());
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }

// product_controller.dart
import 'package:get/get.dart';
import 'package:flutter_application_1/model/allitems_model.dart';
import 'package:flutter_application_1/service/dio.dart';

class ProductController extends GetxController {
  var isLoading = false.obs;
  var itemList = <AllItemsModel>[].obs; // use your AllItemsModel

  @override
  void onInit() {
    super.onInit();
    fetchAllItems();
  }

  Future<void> fetchAllItems() async {
    try {
      isLoading(true);

      final response = await DioService.get('/api/v1/reports');

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
