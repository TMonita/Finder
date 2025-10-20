import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DioService {
  static Dio? _dio;
  static const String baseUrl = 'http://10.0.2.2:8000'; // Replace with your API
  static final FlutterSecureStorage storage = FlutterSecureStorage();

  // Singleton Dio instance
  static Dio getInstance() {
    if (_dio == null) {
      _dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: Duration(seconds: 45),
          receiveTimeout: Duration(seconds: 45),
          headers: {'Content-Type': 'application/json'},
        ),
      );

      _dio!.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) async {
            // Get token from storage
            String? token = await storage.read(key: 'access_token');
            if (token != null) {
              options.headers['Authorization'] = 'Bearer $token';
            }
            return handler.next(options); // continue
          },
          onResponse: (response, handler) {
            // You can handle global responses here
            return handler.next(response);
          },
          onError: (DioError e, handler) async {
            // Handle 401, refresh token etc. here
            if (e.response?.statusCode == 401) {
              // You can try refreshing the token here
              // e.g., await refreshToken();
            }
            return handler.next(e);
          },
        ),
      );
    }
    return _dio!;
  }

  // Example GET request
  static Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParams,
  }) async {
    return await getInstance().get(path, queryParameters: queryParams);
  }

  // Example POST request
  static Future<Response> post(String path, {dynamic data}) async {
    return await getInstance().post(path, data: data);
  }
}
