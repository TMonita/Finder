import 'package:flutter_application_1/Screens/main_screen.dart';
import 'package:flutter_application_1/controllers/product_controller.dart';
import 'package:flutter_application_1/controllers/user_controller.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:flutter_application_1/login_signup_page.dart/update_sign_in.dart';

void main() async {
  // runApp(const MainApp());

  WidgetsFlutterBinding.ensureInitialized();

  final storage = FlutterSecureStorage();
  final token = await storage.read(key: 'access_token');
  Get.put(ProductController(), permanent: true);
  Get.put(UserController(), permanent: true);
  final initRoute = token != null ? '/mainscreen' : '/login';
  runApp(
    GetMaterialApp(
      initialRoute: initRoute,
      getPages: [
        GetPage(name: '/login', page: () => SignInScreen()),
        GetPage(name: '/mainscreen', page: () => MainScreen()),
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFF5F5F5),
        appBarTheme: AppBarTheme(backgroundColor: Color(0xFFF5F5F5)),
      ),
    ),
  );
}

// class MainApp extends StatelessWidget {
//   const MainApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         scaffoldBackgroundColor: Color(0xFFF5F5F5),
//         appBarTheme: AppBarTheme(backgroundColor: Color(0xFFF5F5F5)),
//       ),
//       home: SignInScreen(),
//     );
//   }
// }
