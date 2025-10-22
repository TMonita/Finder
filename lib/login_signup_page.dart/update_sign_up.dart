import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/main_screen.dart';
import 'package:flutter_application_1/controllers/login_controller.dart';
import 'package:flutter_application_1/login_signup_page.dart/update_sign_in.dart';
// import 'package:flutter_application_1/login_signup_page.dart/update_sign_in.dart';
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
  final controller = Get.put(LoginController());

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  bool _isPasswordVisible = false;
  // bool _isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  // String? _validateEmail(String? value) {
  //   if (value == null || value.trim().isEmpty) {
  //     return 'Email is required';
  //   }
  //   final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  //   if (!emailRegex.hasMatch(value.trim())) {
  //     return 'Please enter a valid email';
  //   }
  //   return null;
  // }

  // String? _validatePassword(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return 'Password is required';
  //   }
  //   if (value.length < 6) {
  //     return 'Password must be at least 6 characters';
  //   }
  //   if (!RegExp(r'[A-Z]').hasMatch(value)) {
  //     return 'Password must contain at least one uppercase letter';
  //   }
  //   if (!RegExp(r'[a-z]').hasMatch(value)) {
  //     return 'Password must contain at least one lowercase letter';
  //   }
  //   if (!RegExp(r'[0-9]').hasMatch(value)) {
  //     return 'Password must contain at least one number';
  //   }
  //   return null;
  // }

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
      body: Center(
        child: SingleChildScrollView(
          reverse: true,
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Form(
              key: _formKey,
              child: Obx(
                () => Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 100, 0, 50),
                      child: Image.asset(
                        'images/LogoFinder.png',
                        width: 200,
                        height: 100,
                      ),
                    ),

                    TextFormField(
                      controller: usernameController,
                      validator:
                          (value) =>
                              value!.isEmpty ? 'Username is required' : null,
                      // decoration: _inputDecoration('Email'),
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
                    const SizedBox(height: 20),

                    TextFormField(
                      controller: emailController,
                      validator:
                          (value) =>
                              value!.isEmpty ? 'Email is required' : null,
                      // decoration: _inputDecoration('Email'),
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
                    const SizedBox(height: 20),

                    TextFormField(
                      controller: passwordController,
                      validator:
                          (value) =>
                              value!.isEmpty ? 'Password is required' : null,
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: AppTextStyle.hintText.copyWith(
                          color: Colors.black,
                        ),
                        //  labelStyle: AppTextStyle.hintText,
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

                    const SizedBox(height: 5),

                    TextButton(
                      onPressed: () => Get.to(() => SignInScreen()),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Already Have Account?",
                            style: AppTextStyle.bodyLarge.copyWith(
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'Sign In',
                            style: AppTextStyle.bodyLarge.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),

                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child:
                          controller.isLoading.value
                              ? const Center(child: CircularProgressIndicator())
                              : ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    controller.register(
                                      username: usernameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF274C77),
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

                    const SizedBox(height: 10),

                    TextButton(
                      onPressed: () => Get.to(() => SignInScreen()),
                      child: Column(
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
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),

                    _socialButton(
                      onPressed: () {},
                      label: 'CONNECT WITH FACEBOOK',
                      icon: const Icon(Icons.facebook, color: Colors.white),
                      color: const Color(0xFF367BC7),
                    ),
                    const SizedBox(height: 10),
                    _socialButton(
                      onPressed: googleSignin,
                      label: 'CONNECT WITH GOOGLE',
                      icon: Image.asset('images/google.png', height: 30),
                      color: const Color(0xFF367BC7),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _socialButton({
    required VoidCallback onPressed,
    required String label,
    required Widget icon,
    required Color color,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: icon,
        label: Text(
          label,
          style: AppTextStyle.bodyLarge.copyWith(color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(backgroundColor: color),
      ),
    );
  }
}
