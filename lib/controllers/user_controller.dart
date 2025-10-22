// import 'package:get/get.dart';
// import 'package:flutter_application_1/model/user_model.dart';
// import 'package:flutter_application_1/service/dio.dart';

// class UserController extends GetxController {
//   var isLoading = false.obs;
//   var userList = <UserModel>[].obs;
//   var currentUser = Rxn<UserModel>();

//   @override
//   void onInit() {
//     super.onInit();
//     fetchAllUsers();
//   }

//   Future<void> fetchAllUsers() async {
//     try {
//       isLoading(true);

//       final response = await DioService.get('/api/v1/users');

//       if (response.statusCode == 200) {
//         final List<dynamic> data = response.data['data'];
//         userList.value = data.map((json) => UserModel.fromJson(json)).toList();
//       } else {
//         Get.snackbar('Error', 'Failed to load users');
//       }
//     } catch (e) {
//       print('❌ Fetch users error: $e');
//       Get.snackbar('Error', e.toString());
//     } finally {
//       isLoading(false);
//     }
//   }

//   /// Helper: get username by userId
//   String getUserName(int? userId) {
//     if (userId == null) return 'Unknown';
//     final user = userList.firstWhereOrNull((u) => u.id == userId);
//     return user?.name ?? 'Unknown';
//   }
// }

import 'package:get/get.dart';
import 'package:flutter_application_1/model/user_model.dart';
import 'package:flutter_application_1/service/dio.dart';

class UserController extends GetxController {
  var isLoading = false.obs;
  var userList = <UserModel>[].obs;
  var currentUser = Rxn<UserModel>();

  @override
  void onInit() {
    super.onInit();
    fetchCurrentUser();
  }

  // / Fetch current logged-in user profile
  // Future<void> fetchCurrentUser() async {
  //   try {
  //     isLoading(true);
  //     final response = await DioService.get('/api/v1/users');

  //     if (response.statusCode == 200) {
  //       currentUser.value = UserModel.fromJson(response.data['data']);
  //     } else {
  //       Get.snackbar('Error', 'Failed to load profile');
  //     }
  //   } catch (e) {
  //     print('❌ Fetch current user error: $e');
  //     Get.snackbar('Error', e.toString());
  //   } finally {
  //     isLoading(false);
  //   }
  // }

  Future<void> fetchCurrentUser() async {
    try {
      isLoading(true);
      final userId = await DioService.storage.read(key: 'user_id');
      if (userId == null) {
        Get.snackbar('Error', 'User ID not found');
        return;
      }

      final response = await DioService.get('/api/v1/users/$userId');

      if (response.statusCode == 200 && response.data['success'] == true) {
        currentUser.value = UserModel.fromJson(response.data['data']);
      } else {
        Get.snackbar('Error', 'Failed to load profile');
      }
    } catch (e) {
      print('❌ Fetch current user error: $e');
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  /// Update user info
  Future<void> updateUser(UserModel updatedUser) async {
    try {
      isLoading(true);
      final response = await DioService.put(
        '/api/v1/users/${updatedUser.id}',
        data: {
          "name": updatedUser.name,
          "email": updatedUser.email,
          "phone": updatedUser.phone,
          "address": updatedUser.address,
          "profileImageUrl": updatedUser.profileImageUrl,
        },
      );

      if (response.statusCode == 200) {
        currentUser.value = updatedUser;
        Get.snackbar('Success', 'Profile updated successfully');
      } else {
        Get.snackbar('Error', 'Failed to update user');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  String getUserName(int? userId) {
    if (userId == null) return 'Unknown';
    final user = userList.firstWhereOrNull((u) => u.id == userId);
    return user?.name ?? 'Unknown';
  }
}

// import 'package:get/get.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import '../service/dio.dart';

// class UserController extends GetxController {
//   final Dio _dio = DioService.getInstance();
//   final FlutterSecureStorage _storage = const FlutterSecureStorage();

//   var userData = {}.obs;
//   var isLoading = false.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     fetchUserProfile();
//   }

//   Future<void> fetchUserProfile() async {
//     isLoading.value = true;
//     try {
//       final token = await _storage.read(key: 'access_token');
//       final userId = await _storage.read(key: 'user_id');

//       if (token == null || userId == null) {
//         print('❌ No token or userId found');
//         return;
//       }

//       final response = await _dio.get(
//         '/api/v1/users/$userId',
//         options: Options(headers: {'Authorization': 'Bearer $token'}),
//       );

//       if (response.data != null) {
//         userData.value = response.data;
//         print('✅ User fetched: ${response.data}');
//       }
//     } on DioException catch (e) {
//       print('❌ Fetch user failed: ${e.response?.data}');
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }
