import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/main_screen.dart';
import 'package:flutter_application_1/utils/app_textstyle.dart';

class CongratsScreen extends StatefulWidget {
  const CongratsScreen({super.key});

  @override
  _CongratsScreenState createState() => _CongratsScreenState();
}

class _CongratsScreenState extends State<CongratsScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to main screen after 5 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: BuildBody()));
  }

  Widget BuildBody() {
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/congrats.png', width: 220),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Congratulations! Your belonging is safely back in your hands.',
                style: AppTextStyle.h2_2, // Ensure AppTextStyle.h2 is defined
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
