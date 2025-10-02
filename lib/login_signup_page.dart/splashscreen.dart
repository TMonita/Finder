import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/login_signup_page.dart/signup_page.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignupPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 265,
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [Image(image: AssetImage('images/LogoFinder.png'))],
          ),
        ),
      ),
    );
  }
}
