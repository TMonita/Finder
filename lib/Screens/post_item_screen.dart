import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/main_screen.dart';
import 'package:flutter_application_1/controllers/post_controller.dart';
import 'package:flutter_application_1/utils/app_textstyle.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class PostItemScreen extends StatefulWidget {
  const PostItemScreen({super.key});
  @override
  State<PostItemScreen> createState() => _PostItemScreenState();
}

class _PostItemScreenState extends State<PostItemScreen> {
  final PostController postController = Get.put(PostController());
  String belongingType = "Lost";
  File? _image;
  final ImagePicker _picker = ImagePicker();
  String? selectedCategory;

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          children: [
            buildAppBar(),
            const SizedBox(height: 20),
            buildCategoryDropdown(),
            const SizedBox(height: 20),
            buildPostTypeSelector(),
            const SizedBox(height: 20),
            buildTextField(
              "Description",
              "Describe important information like color, feature, etc.",
              maxLines: 3,
            ),
            buildTextField("Location", "Where the item was found"),
            buildPhonenumberField("Phone Number", "Enter Your Phone Number"),
            const SizedBox(height: 20),
            buildImagePicker(),
            const SizedBox(height: 30),
            buildContinueButton(context),
          ],
        ),
      ),
    );
  }

  Widget buildAppBar() {
    return Center(
      child: Text(
        'Post Items',
        style: AppTextStyle.h1.copyWith(color: Color(0xFF274C77)),
      ),
    );
  }

  Widget buildCategoryDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Category", style: AppTextStyle.h2),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              hint: const Text("Select a category"),
              dropdownColor: Colors.white,
              borderRadius: BorderRadius.circular(10),
              style: AppTextStyle.h2.copyWith(
                color: Colors.black.withOpacity(0.8),
              ),
              value: selectedCategory,
              onChanged: (value) {
                setState(() {
                  selectedCategory = value;
                });
              },
              items: const [
                DropdownMenuItem(
                  value: "Electronic",
                  child: Text("Electronic"),
                ),
                DropdownMenuItem(value: "Jewelry", child: Text("Jewelry")),
                DropdownMenuItem(value: "Document", child: Text("Document")),
                DropdownMenuItem(value: "Key", child: Text("Key")),
                DropdownMenuItem(value: "Bag", child: Text("Bag")),
                DropdownMenuItem(value: "Pet", child: Text("Pet")),
                DropdownMenuItem(value: "Person", child: Text("Person")),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildPostTypeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Post Type", style: AppTextStyle.h2),
        const SizedBox(height: 8),
        Row(
          children: [
            buildPostTypeButton("Lost", const Color(0xFF6096BA)),
            const SizedBox(width: 12),
            buildPostTypeButton("Found", const Color(0xFF6096BA)),
          ],
        ),
      ],
    );
  }

  Widget buildPostTypeButton(String type, Color color) {
    final bool isSelected = belongingType == type;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => belongingType = type),
        child: Container(
          height: 45,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? color : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? Color(0xFF6096BA) : Colors.white,
            ),
            boxShadow: [
              if (isSelected)
                BoxShadow(
                  color: color.withOpacity(0.4),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
            ],
          ),
          child: Text(
            type,
            style: AppTextStyle.bodyLarge.copyWith(
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPhonenumberField(String label, String hint, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTextStyle.h2),
          const SizedBox(height: 8),
          TextField(
            maxLines: maxLines,
            keyboardType: TextInputType.number, // numeric keyboard
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly, // allow only numbers
            ],
            decoration: InputDecoration(
              hintText: hint,
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              hintStyle: AppTextStyle.bodyLarge,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.white),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextField(String label, String hint, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTextStyle.h2),
          const SizedBox(height: 8),
          TextField(
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: hint,
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              hintStyle: AppTextStyle.bodyLarge,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.white),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildImagePicker() {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child:
            _image == null
                ? const Center(
                  child: Icon(
                    Icons.image_outlined,
                    size: 50,
                    color: Colors.grey,
                  ),
                )
                : ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    _image!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
      ),
    );
  }

  Widget buildContinueButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        // onPressed: () {
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(builder: (context) => const MainScreen()),
        //   );
        // },

        //updates
        onPressed: () async {
          await postController.createReport(
            type: belongingType,
            title: "I found kernh leo",
            timeLostAt: "2025-10-15T17:45:00.000",
            description:
                "I found a black leather wallet near AEON Mall Phnom Penh parking lot. It contains some cash and cards. Please describe the contents to claim it.",
            location: "Phnom Penh, Cambodia",
            imageUrl:
                'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.thecatvet.ae%2F&psig=AOvVaw0CxpggihubPqKvxn4RhdRu&ust=1761092817130000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCJiGlZGEtJADFQAAAAAdAAAAABAE',
            userId: 7,
            categoryId: 3,
          );
          if (postController.isSuccess.value) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MainScreen()),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF274C77),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          elevation: 0,
        ),
        child: Text(
          'Continue',
          style: AppTextStyle.h2_2.copyWith(
            color: Colors.white,
            // fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
