import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/main_screen.dart';
import 'package:flutter_application_1/login_signup_page.dart/update_SignIn.dart';
import 'package:flutter_application_1/utils/app_textstyle.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          reverse: true,
          child: Container(
            margin: EdgeInsets.all(25),

            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 100, 0, 50),
                  child: Container(
                    width: 200,
                    height: 100,
                    child: Image(image: AssetImage('images/LogoFinder.png')),
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                    labelStyle: AppTextStyle.hintText.copyWith(
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.white,

                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),

                SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: AppTextStyle.hintText.copyWith(
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.white,

                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                TextField(
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: AppTextStyle.hintText,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),

                SizedBox(height: 10),

                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignInScreen()),
                    );
                  },
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(
                      Colors.grey.withOpacity(0.2),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Already have account? Sign In",
                        style: AppTextStyle.bodyLarge.copyWith(
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MainScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF274C77),
                      padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                      overlayColor: const Color(0xFF274C77).withOpacity(0.2),
                    ),
                    child: Text(
                      'SIGN UP',
                      style: AppTextStyle.bodyLarge.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "By Signing Up you agree to our Terms",
                      style: AppTextStyle.bodyLarge.copyWith(
                        color: Colors.black54,
                      ),
                    ),
                    Text(
                      'Conditions & Privacy Policy.',
                      style: AppTextStyle.bodyLarge.copyWith(
                        color: Colors.black54,
                      ),
                    ),

                    SizedBox(height: 10),
                    Text(
                      'Or',
                      style: AppTextStyle.bodyLarge.copyWith(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.facebook, size: 35, color: Colors.white),

                    label: Text(
                      'CONNECT WITH FACEBOOK',
                      style: AppTextStyle.bodyLarge.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF367BC7),
                      overlayColor: const Color(0xFF274C77).withOpacity(0.2),
                    ),
                  ),
                ),

                SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: Image.asset(
                      'images/google.png',
                      height: 40,
                      width: 40,
                    ),
                    label: Text(
                      'CONNECT WITH GOOGLE',
                      style: AppTextStyle.bodyLarge.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF367BC7),
                      overlayColor: const Color(0xFF274C77).withOpacity(0.2),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
