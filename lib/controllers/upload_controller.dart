// import 'dart:io';
// import 'package:get/get.dart';
// import 'package:dio/dio.dart' as dio; // 👈 alias Dio
// import 'package:flutter_application_1/service/dio.dart';

// class UploadController extends GetxController {
//   var isUploading = false.obs;
//   var fileUrl = RxnString();

//   Future<void> uploadFile(File file) async {
//     isUploading.value = true;
//     try {
//       final formData = dio.FormData.fromMap({
//         // 👈 use alias here
//         'file': await dio.MultipartFile.fromFile(file.path), // 👈 alias too
//       });

//       final response = await DioService.post(
//         '/api/v1/upload',
//         data: formData,
//         options: dio.Options(contentType: 'multipart/form-data'), // 👈 alias
//       );

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         fileUrl.value = response.data['data'];
//         Get.snackbar('✅ Uploaded', 'File uploaded successfully');
//       } else {
//         Get.snackbar('❌ Error', 'Upload failed: ${response.statusMessage}');
//       }
//     } catch (e) {
//       Get.snackbar('❌ Upload failed', e.toString());
//     } finally {
//       isUploading.value = false;
//     }
//   }

//   void clearUrl() => fileUrl.value = null;
// }
