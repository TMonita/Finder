// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/controllers/login_controller.dart';
// import 'package:flutter_application_1/utils/app_colortheme.dart';
// import 'package:flutter_application_1/utils/app_textstyle.dart';
// import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
// import 'package:get/instance_manager.dart';
// import 'package:image_picker/image_picker.dart';

// class EditProfileScreen extends StatefulWidget {
//   const EditProfileScreen({Key? key}) : super(key: key);

//   @override
//   State<EditProfileScreen> createState() => _EditProfileScreenState();
// }

// class _EditProfileScreenState extends State<EditProfileScreen> {
//   final LoginController _loginController = Get.put(LoginController());

//   final _usernameController = TextEditingController(text: "Tho Violet");
//   final _emailController = TextEditingController(text: "violet23!@gmail.com");
//   final _phoneController = TextEditingController(text: "+85577919843");
//   final _newPasswordController = TextEditingController();
//   final _addressController = TextEditingController(text: "Sen Sok, Phnom Penh");

//   File? _selectedImage;

//   Future<void> _pick(ImageSource src) async {
//     final picker = ImagePicker();
//     final XFile? x = await picker.pickImage(source: src);
//     if (x != null) setState(() => _selectedImage = File(x.path));
//   }

//   void _showPicker() {
//     showModalBottomSheet(
//       context: context,
//       builder:
//           (_) => SafeArea(
//             child: Wrap(
//               children: [
//                 ListTile(
//                   leading: const Icon(Icons.photo_library),
//                   title: Text(
//                     'Choose from Gallery',
//                     style: AppTextStyle.bodyLarge,
//                   ),
//                   onTap: () {
//                     Navigator.pop(context);
//                     _pick(ImageSource.gallery);
//                   },
//                 ),
//                 ListTile(
//                   leading: const Icon(Icons.camera_alt),
//                   title: Text('Take a Photo', style: AppTextStyle.bodyLarge),
//                   onTap: () {
//                     Navigator.pop(context);
//                     _pick(ImageSource.camera);
//                   },
//                 ),
//               ],
//             ),
//           ),
//     );
//   }

//   Widget _buildTextField(
//     String label,
//     TextEditingController controller, {
//     bool isPassword = false,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(label, style: AppTextStyle.h2),
//         const SizedBox(height: 5),
//         TextField(
//           style: AppTextStyle.bodyLarge,
//           controller: controller,
//           obscureText: isPassword,
//           decoration: InputDecoration(
//             filled: true,
//             fillColor: Colors.white,
//             contentPadding: const EdgeInsets.symmetric(
//               vertical: 12,
//               horizontal: 15,
//             ),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: BorderSide.none,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios_new, color: AppColors.primary),
//           onPressed: () {
//             // final String? imagePath = _selectedImage?.path;
//             Navigator.pop(context);
//           },
//         ),

//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context, {
//                 'imagePath': _selectedImage?.path,
//                 'username': _usernameController.text,
//                 'address': _addressController.text,
//               });
//             },
//             child: Text(
//               "Save",
//               style: AppTextStyle.h2_3.copyWith(color: AppColors.primary),
//             ),
//           ),
//         ],
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//           child: Column(
//             children: [
//               Center(
//                 child: Stack(
//                   children: [
//                     CircleAvatar(
//                       radius: 55,
//                       backgroundColor: AppColors.secondary,
//                       backgroundImage:
//                           _selectedImage != null
//                               ? FileImage(_selectedImage!)
//                               : const AssetImage("assets/profile.png")
//                                   as ImageProvider,
//                     ),
//                     Positioned(
//                       bottom: 2,
//                       right: 2,
//                       child: InkWell(
//                         onTap: _showPicker,
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             shape: BoxShape.circle,
//                             border: Border.all(
//                               color: AppColors.secondary,
//                               width: 2,
//                             ),
//                           ),
//                           padding: const EdgeInsets.all(6),
//                           child: const Icon(
//                             Icons.edit,
//                             size: 16,
//                             color: AppColors.secondary,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 30),

//               _buildTextField("Username", _usernameController),
//               const SizedBox(height: 15),

//               _buildTextField("Email", _emailController),
//               const SizedBox(height: 15),

//               _buildTextField("Phone Number", _phoneController),
//               const SizedBox(height: 15),

//               _buildTextField(
//                 "New Password",
//                 _newPasswordController,
//                 isPassword: true,
//               ),
//               const SizedBox(height: 15),

//               _buildTextField("Address", _addressController),
//               const SizedBox(height: 15),

//               // TextButton(
//               //   onPressed: () {
//               //     Navigator.push(
//               //       context,
//               //       MaterialPageRoute(builder: (context) => SignInScreen()),
//               //     );
//               //   },
//               //   child: Text('LogOut'),
//               // ),
//               Obx(() {
//                 return ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.primary,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     minimumSize: const Size(double.infinity, 45),
//                   ),
//                   onPressed:
//                       _loginController.isLoading.value
//                           ? null
//                           : () async {
//                             await _loginController.logout();
//                           },
//                   child:
//                       _loginController.isLoading.value
//                           ? const CircularProgressIndicator(
//                             color: Colors.white,
//                             strokeWidth: 2,
//                           )
//                           : const Text('Logout'),
//                 );
//               }),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/login_controller.dart';
import 'package:flutter_application_1/controllers/user_controller.dart';
import 'package:flutter_application_1/model/user_model.dart';
import 'package:flutter_application_1/utils/app_colortheme.dart';
import 'package:flutter_application_1/utils/app_textstyle.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_application_1/service/dio.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final LoginController _loginController = Get.put(LoginController());
  final UserController _userController = Get.find<UserController>();

  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _addressController = TextEditingController();

  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  void _loadUserInfo() {
    final user = _userController.currentUser.value;
    if (user != null) {
      _usernameController.text = user.name;
      _emailController.text = user.email ?? "";
      _phoneController.text = user.phone ?? "";
      _addressController.text = user.address ?? "";
    }
  }

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

  Future<void> _saveProfile() async {
    final user = _userController.currentUser.value;
    if (user == null) return;

    final updatedUser = UserModel(
      id: user.id,
      name: _usernameController.text,
      email: _emailController.text,
      phone: _phoneController.text,
      address: _addressController.text,
      profileImageUrl: user.profileImageUrl,
      totalScore: user.totalScore,
    );

    await _userController.updateUser(updatedUser);

    Navigator.pop(context, {
      'imagePath': _selectedImage?.path,
      'username': _usernameController.text,
      'address': _addressController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = _userController.currentUser.value;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: AppColors.primary),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: _saveProfile,
            child: Text(
              "Save",
              style: AppTextStyle.h2_3.copyWith(color: AppColors.primary),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Obx(() {
          if (_userController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
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
                                : (user?.profileImageUrl != null
                                    ? NetworkImage(
                                      '${DioService.baseUrl}/${user!.profileImageUrl!}',
                                    )
                                    : const AssetImage("images/violet.jpg")
                                        as ImageProvider),
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

                Obx(() {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: const Size(double.infinity, 45),
                    ),
                    onPressed:
                        _loginController.isLoading.value
                            ? null
                            : () async {
                              await _loginController.logout();
                            },
                    child:
                        _loginController.isLoading.value
                            ? const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            )
                            : const Text('Logout'),
                  );
                }),
              ],
            ),
          );
        }),
      ),
    );
  }
}
