// import 'package:dio/dio.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// class DioService {
//   static Dio? _dio;
//   static const String baseUrl = 'http://10.0.2.2:8000';
//   // static const String baseUrl = 'http://192.168.18.194:8000';
//   static final FlutterSecureStorage storage = FlutterSecureStorage();

//   // Singleton Dio instance
//   static Dio getInstance() {
//     if (_dio == null) {
//       _dio = Dio(
//         BaseOptions(
//           baseUrl: baseUrl,
//           connectTimeout: Duration(seconds: 45),
//           receiveTimeout: Duration(seconds: 45),
//           headers: {'Content-Type': 'application/json'},
//         ),
//       );

//       _dio!.interceptors.add(
//         InterceptorsWrapper(
//           onRequest: (options, handler) async {
//             // Get token from storage
//             String? token = await storage.read(key: 'access_token');
//             if (token != null) {
//               options.headers['Authorization'] = 'Bearer $token';
//             }
//             return handler.next(options); // continue
//           },
//           onResponse: (response, handler) {
//             // You can handle global responses here
//             return handler.next(response);
//           },
//           onError: (DioError e, handler) async {
//             // Handle 401, refresh token etc. here
//             if (e.response?.statusCode == 401) {
//               // You can try refreshing the token here
//               // e.g., await refreshToken();
//             }
//             return handler.next(e);
//           },
//         ),
//       );
//     }
//     return _dio!;
//   }

//   //  GET request
//   static Future<Response> get(
//     String path, {
//     Map<String, dynamic>? queryParams,
//   }) async {
//     return await getInstance().get(path, queryParameters: queryParams);
//   }

//   //  POST request
//   static Future<Response> post(String path, {dynamic data}) async {
//     return await getInstance().post(path, data: data);
//   }
// }

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DioService {
  static Dio? _dio;

  // static const String baseUrl = 'http://10.0.2.2:8000';
  // static const String baseUrl = 'http://192.168.18.194:8000';
  static const String baseUrl = 'https://finder-backend-t9rm.onrender.com';
  static final FlutterSecureStorage storage = FlutterSecureStorage();

  // Singleton Dio instance
  static Dio getInstance() {
    if (_dio == null) {
      _dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 45),
          receiveTimeout: const Duration(seconds: 45),
          headers: {'Content-Type': 'application/json'},
        ),
      );

      _dio!.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) async {
            // 🔑 Automatically attach access token to all requests
            String? token = await storage.read(key: 'access_token');
            if (token != null) {
              options.headers['Authorization'] = 'Bearer $token';
            }
            return handler.next(options);
          },
          onResponse: (response, handler) {
            // Global success handler
            return handler.next(response);
          },
          onError: (DioError e, handler) async {
            // Global error handler (handle 401, etc.)
            if (e.response?.statusCode == 401) {
              // Example: refresh token logic here if needed
              // await refreshToken();
            }
            return handler.next(e);
          },
        ),
      );
    }
    return _dio!;
  }

  // 📥 GET request
  static Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParams,
  }) async {
    return await getInstance().get(path, queryParameters: queryParams);
  }

  // 📤 POST request
  static Future<Response> post(String path, {dynamic data}) async {
    return await getInstance().post(path, data: data);
  }

  // 📝 PUT request (for updating resources)
  static Future<Response> put(String path, {dynamic data}) async {
    return await getInstance().put(path, data: data);
  }

  // ❌ DELETE request (for deleting resources)
  static Future<Response> delete(String path, {dynamic data}) async {
    return await getInstance().delete(path, data: data);
  }
}
