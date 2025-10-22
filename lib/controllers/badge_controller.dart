// import 'package:flutter_application_1/service/dio.dart';
// import 'package:get/get.dart';
// import 'package:flutter_application_1/model/badge_model.dart';

// class BadgeController extends GetxController {
//   var badges = <BadgeModel>[].obs;
//   var isLoading = false.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     fetchBadges();
//   }

//   Future<void> fetchBadges() async {
//     try {
//       isLoading.value = true;
//       final response = await DioService.get(
//         '/badges',
//       ); // ✅ your backend endpoint
//       if (response.statusCode == 200 && response.data['success'] == true) {
//         var list = response.data['data'] as List;
//         badges.value = list.map((e) => BadgeModel.fromJson(e)).toList();
//       } else {
//         Get.snackbar('Error', 'Failed to load badges');
//       }
//     } catch (e) {
//       print('Error fetching badges: $e');
//       Get.snackbar('Error', 'Something went wrong while fetching badges');
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }

//new updates
import 'package:flutter_application_1/service/dio.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/model/badge_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class BadgeController extends GetxController {
  var badges = <BadgeModel>[].obs;
  var unlockedBadgeIds = <int>[].obs;
  var isLoading = false.obs;

  final _storage = const FlutterSecureStorage();
  int? userId;

  @override
  void onInit() {
    super.onInit();
    _initUser();
  }

  Future<void> _initUser() async {
    userId = int.tryParse(await _storage.read(key: 'user_id') ?? '');
    if (userId != null) {
      await fetchBadges();
    } else {
      Get.snackbar('Error', 'User not logged in');
    }
  }

  Future<void> fetchBadges() async {
    if (userId == null) return;

    try {
      isLoading.value = true;

      final allResponse = await DioService.get('/api/v1/badges');
      final userResponse = await DioService.get(
        '/api/v1/users/$userId/badges/showall',
      );

      if (allResponse.statusCode == 200 &&
          allResponse.data['success'] == true) {
        final List<dynamic> allData = allResponse.data['data'];
        badges.value = allData.map((e) => BadgeModel.fromJson(e)).toList();
      }

      if (userResponse.statusCode == 200 &&
          userResponse.data['success'] == true) {
        final List<dynamic> userData = userResponse.data['data'];
        unlockedBadgeIds.value =
            userData.map((e) => e['badgeId'] as int).toList();
      }
    } catch (e) {
      print('❌ Error fetching badges: $e');
      Get.snackbar('Error', 'Failed to load badges');
    } finally {
      isLoading.value = false;
    }
  }

  bool isUnlocked(BadgeModel badge) {
    return unlockedBadgeIds.contains(badge.id);
  }
}
