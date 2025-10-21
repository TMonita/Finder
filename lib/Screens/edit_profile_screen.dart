import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/login_signup_page.dart/update_sign_in.dart';
import 'package:flutter_application_1/utils/app_colortheme.dart';
import 'package:flutter_application_1/utils/app_textstyle.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _usernameController = TextEditingController(text: "Tho Violet");
  final _emailController = TextEditingController(text: "violet23!@gmail.com");
  final _phoneController = TextEditingController(text: "+85577919843");
  final _newPasswordController = TextEditingController();
  final _addressController = TextEditingController(text: "Sen Sok, Phnom Penh");

  File? _selectedImage;

  Future<void> _pick(ImageSource src) async {
    final picker = ImagePicker();
    final XFile? x = await picker.pickImage(source: src);
    if (x != null) setState(() => _selectedImage = File(x.path));
  }

  void _showPicker() {
    showModalBottomSheet(
      context: context,
      builder:
          (_) => SafeArea(
            child: Wrap(
              children: [
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: Text(
                    'Choose from Gallery',
                    style: AppTextStyle.bodyLarge,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _pick(ImageSource.gallery);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: Text('Take a Photo', style: AppTextStyle.bodyLarge),
                  onTap: () {
                    Navigator.pop(context);
                    _pick(ImageSource.camera);
                  },
                ),
              ],
            ),
          ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    bool isPassword = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyle.h2),
        const SizedBox(height: 5),
        TextField(
          style: AppTextStyle.bodyLarge,
          controller: controller,
          obscureText: isPassword,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 15,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: AppColors.primary),
          onPressed: () {
            // final String? imagePath = _selectedImage?.path;
            Navigator.pop(context);
          },
        ),

        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, {
                'imagePath': _selectedImage?.path,
                'username': _usernameController.text,
                'address': _addressController.text,
              });
            },
            child: Text(
              "Save",
              style: AppTextStyle.h2_3.copyWith(color: AppColors.primary),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 55,
                      backgroundColor: AppColors.secondary,
                      backgroundImage:
                          _selectedImage != null
                              ? FileImage(_selectedImage!)
                              : const AssetImage("assets/profile.png")
                                  as ImageProvider,
                    ),
                    Positioned(
                      bottom: 2,
                      right: 2,
                      child: InkWell(
                        onTap: _showPicker,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.secondary,
                              width: 2,
                            ),
                          ),
                          padding: const EdgeInsets.all(6),
                          child: const Icon(
                            Icons.edit,
                            size: 16,
                            color: AppColors.secondary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              _buildTextField("Username", _usernameController),
              const SizedBox(height: 15),

              _buildTextField("Email", _emailController),
              const SizedBox(height: 15),

              _buildTextField("Phone Number", _phoneController),
              const SizedBox(height: 15),

              _buildTextField(
                "New Password",
                _newPasswordController,
                isPassword: true,
              ),
              const SizedBox(height: 15),

              _buildTextField("Address", _addressController),
              const SizedBox(height: 15),

              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignInScreen()),
                  );
                },
                child: Text('LogOut'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
