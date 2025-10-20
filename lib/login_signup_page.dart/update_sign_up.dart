import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/main_screen.dart';
import 'package:flutter_application_1/login_signup_page.dart/update_sign_in.dart';
import 'package:flutter_application_1/utils/app_colortheme.dart';
import 'package:flutter_application_1/utils/app_textstyle.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password must contain at least one lowercase letter';
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain at least one number';
    }
    return null;
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);

  Future<void> googleSignin() async {
    try {
      await _googleSignIn.signOut();
      final GoogleSignInAccount? user = await _googleSignIn.signIn();

      if (user != null) {
        final auth = await user.authentication;
        print('✅ Token: ${auth.accessToken}');
        print('📧 Email: ${user.email}');
        print('🖼️ Photo: ${user.photoUrl}');
        Get.offAll(() => MainScreen());
      } else {
        print('❌ Sign-Up cancelled');
      }
    } catch (e) {
      print('⚠️ Google sign-up error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('werw'),

      //   body: Center(
      //     child: SingleChildScrollView(
      //       reverse: true,
      //       child: Container(
      //         margin: EdgeInsets.all(25),

      //         child: Form(
      //           key: _formKey,
      //           child: Obx(
      //             () => Column(
      //               children: [
      //                 Padding(
      //                   padding: const EdgeInsets.fromLTRB(0, 100, 0, 50),
      //                   child: Image.asset(
      //                     'images/LogoFinder.png',
      //                     width: 200,
      //                     height: 100,
      //                   ),
      //                 ),
      //                 TextFormField(
      //                   controller: usernameController,
      //                   decoration: InputDecoration(
      //                     labelText: 'Full Name',
      //                     labelStyle: AppTextStyle.hintText.copyWith(
      //                       color: Colors.black,
      //                     ),
      //                     border: OutlineInputBorder(
      //                       borderRadius: BorderRadius.circular(10),
      //                     ),
      //                     filled: true,
      //                     fillColor: Colors.white,

      //                     enabledBorder: OutlineInputBorder(
      //                       borderRadius: BorderRadius.circular(12),
      //                       borderSide: BorderSide(color: Colors.white),
      //                     ),
      //                     focusedBorder: OutlineInputBorder(
      //                       borderRadius: BorderRadius.circular(12),
      //                       borderSide: BorderSide(color: Colors.white),
      //                     ),
      //                   ),
      //                 ),

      //                 SizedBox(height: 20),
      //                 TextFormField(
      //                   controller: emailController,
      //                   validator: _validateEmail,
      //                   keyboardType: TextInputType.emailAddress,
      //                   enabled: !_isLoading,
      //                   decoration: InputDecoration(
      //                     labelText: 'Email',
      //                     labelStyle: AppTextStyle.hintText.copyWith(
      //                       color: Colors.black,
      //                     ),
      //                     border: OutlineInputBorder(
      //                       borderRadius: BorderRadius.circular(10),
      //                     ),
      //                     filled: true,
      //                     fillColor: Colors.white,

      //                     enabledBorder: OutlineInputBorder(
      //                       borderRadius: BorderRadius.circular(12),
      //                       borderSide: BorderSide(color: Colors.white),
      //                     ),
      //                     focusedBorder: OutlineInputBorder(
      //                       borderRadius: BorderRadius.circular(12),
      //                       borderSide: BorderSide(color: Colors.white),
      //                     ),
      //                   ),
      //                 ),
      //                 SizedBox(height: 20),

      //                 TextFormField(
      //                   controller: passwordController,
      //                   validator: _validatePassword,
      //                   enabled: !_isLoading,
      //                   obscureText: !_isPasswordVisible,
      //                   decoration: InputDecoration(
      //                     labelText: 'Password',
      //                     labelStyle: AppTextStyle.hintText,
      //                     border: OutlineInputBorder(
      //                       borderRadius: BorderRadius.circular(10),
      //                     ),
      //                     filled: true,
      //                     fillColor: Colors.white,
      //                     suffixIcon: IconButton(
      //                       icon: Icon(
      //                         _isPasswordVisible
      //                             ? Icons.visibility
      //                             : Icons.visibility_off,
      //                         color: Colors.grey,
      //                       ),
      //                       onPressed: () {
      //                         setState(() {
      //                           _isPasswordVisible = !_isPasswordVisible;
      //                         });
      //                       },
      //                     ),
      //                     enabledBorder: OutlineInputBorder(
      //                       borderRadius: BorderRadius.circular(12),
      //                       borderSide: BorderSide(color: Colors.white),
      //                     ),
      //                     focusedBorder: OutlineInputBorder(
      //                       borderRadius: BorderRadius.circular(12),
      //                       borderSide: BorderSide(color: Colors.white),
      //                     ),
      //                   ),
      //                 ),

      //                 SizedBox(height: 10),

      //                 TextButton(
      //                   onPressed: () {
      //                     Navigator.push(
      //                       context,
      //                       MaterialPageRoute(
      //                         builder: (context) => SignInScreen(),
      //                       ),
      //                     );
      //                   },
      //                   style: ButtonStyle(
      //                     overlayColor: MaterialStateProperty.all(
      //                       Colors.grey.withOpacity(0.2),
      //                     ),
      //                   ),
      //                   child: Row(
      //                     mainAxisAlignment: MainAxisAlignment.end,
      //                     children: [
      //                       Text(
      //                         "Already have account?",
      //                         style: AppTextStyle.bodyLarge.copyWith(
      //                           color: Colors.black54,
      //                         ),
      //                       ),
      //                       SizedBox(width: 5),
      //                       Text(
      //                         'Sign In',
      //                         style: AppTextStyle.bodyLarge.copyWith(
      //                           color: AppColors.primary,
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //                 SizedBox(height: 20),

      //                 SizedBox(
      //                   width: double.infinity,
      //                   height: 55,
      //                   child: ElevatedButton(
      //                     onPressed: () {
      //                       // Navigator.push(
      //                       //   context,
      //                       //   MaterialPageRoute(builder: (context) => MainScreen()),
      //                       // );
      //                       if (_formKey.currentState!.validate()) {
      //                         Navigator.push(
      //                           context,
      //                           MaterialPageRoute(
      //                             builder: (context) => MainScreen(),
      //                           ),
      //                         );
      //                       } else {
      //                         print("Form validation failed");
      //                       }
      //                     },
      //                     style: ElevatedButton.styleFrom(
      //                       backgroundColor: Color(0xFF274C77),
      //                       padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
      //                       overlayColor: const Color(
      //                         0xFF274C77,
      //                       ).withOpacity(0.2),
      //                     ),
      //                     child: Text(
      //                       'SIGN UP',
      //                       style: AppTextStyle.bodyLarge.copyWith(
      //                         color: Colors.white,
      //                         fontWeight: FontWeight.bold,
      //                       ),
      //                     ),
      //                   ),
      //                 ),

      //                 SizedBox(height: 10),
      //                 Column(
      //                   mainAxisAlignment: MainAxisAlignment.center,
      //                   children: [
      //                     Text(
      //                       "By Signing Up you agree to our Terms",
      //                       style: AppTextStyle.bodyLarge.copyWith(
      //                         color: Colors.black54,
      //                       ),
      //                     ),
      //                     Text(
      //                       'Conditions & Privacy Policy.',
      //                       style: AppTextStyle.bodyLarge.copyWith(
      //                         color: Colors.black54,
      //                       ),
      //                     ),

      //                     SizedBox(height: 10),
      //                     Text(
      //                       'Or',
      //                       style: AppTextStyle.bodyLarge.copyWith(
      //                         color: Colors.black,
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //                 SizedBox(height: 10),

      //                 SizedBox(
      //                   width: double.infinity,
      //                   height: 55,
      //                   child: ElevatedButton.icon(
      //                     onPressed: () {},
      //                     icon: Icon(
      //                       Icons.facebook,
      //                       size: 35,
      //                       color: Colors.white,
      //                     ),

      //                     label: Text(
      //                       'CONNECT WITH FACEBOOK',
      //                       style: AppTextStyle.bodyLarge.copyWith(
      //                         color: Colors.white,
      //                       ),
      //                     ),
      //                     style: ElevatedButton.styleFrom(
      //                       backgroundColor: Color(0xFF367BC7),
      //                       overlayColor: const Color(
      //                         0xFF274C77,
      //                       ).withOpacity(0.2),
      //                     ),
      //                   ),
      //                 ),

      //                 SizedBox(height: 10),
      //                 SizedBox(
      //                   width: double.infinity,
      //                   height: 55,
      //                   child: ElevatedButton.icon(
      //                     onPressed: () {
      //                       googleSignin();
      //                     },
      //                     icon: Image.asset(
      //                       'images/google.png',
      //                       height: 40,
      //                       width: 40,
      //                     ),
      //                     label: Text(
      //                       'CONNECT WITH GOOGLE',
      //                       style: AppTextStyle.bodyLarge.copyWith(
      //                         color: Colors.white,
      //                       ),
      //                     ),
      //                     style: ElevatedButton.styleFrom(
      //                       backgroundColor: const Color(0xFF367BC7),
      //                       overlayColor: const Color(
      //                         0xFF274C77,
      //                       ).withOpacity(0.2),
      //                     ),
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ),
      //       ),
      //     ),
      //   ),
    );
  }
}
