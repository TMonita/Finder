import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/main_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFF5F5F5),
        appBarTheme: AppBarTheme(backgroundColor: Color(0xFFF5F5F5)),
      ),
      home: MainScreen(),
    );
  }
}
