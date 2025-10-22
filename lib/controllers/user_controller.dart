import 'package:get/get.dart';
import 'package:flutter_application_1/model/user_model.dart';
import 'package:flutter_application_1/service/dio.dart';

class UserController extends GetxController {
  var isLoading = false.obs;
  var userList = <UserModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllUsers();
  }

  Future<void> fetchAllUsers() async {
    try {
      isLoading(true);

      final response = await DioService.get('/api/v1/users');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        userList.value = data.map((json) => UserModel.fromJson(json)).toList();
      } else {
        Get.snackbar('Error', 'Failed to load users');
      }
    } catch (e) {
      print('❌ Fetch users error: $e');
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  /// Helper: get username by userId
  String getUserName(int? userId) {
    if (userId == null) return 'Unknown';
    final user = userList.firstWhereOrNull((u) => u.id == userId);
    return user?.name ?? 'Unknown';
  }
}
