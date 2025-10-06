import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/main_screen.dart';
import 'package:flutter_application_1/utils/app_textstyle.dart';
import 'package:image_picker/image_picker.dart';

class PostItemScreen extends StatefulWidget {
  const PostItemScreen({super.key});

  @override
  State<PostItemScreen> createState() => _PostItemScreenState();
}

class _PostItemScreenState extends State<PostItemScreen> {
  String belongingType = "Lost";
  File? _image;
  final ImagePicker _picker = ImagePicker();

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
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          children: [buildAppBar(), const SizedBox(height: 20), postDetails()],
        ),
      ),
    );
  }

  // AppBar Row
  Widget buildAppBar() {
    return Center(child: Text('Post Items', style: AppTextStyle.h1));
  }

  Widget postDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Lost/Found belonging",
          style: AppTextStyle.h2,
          // style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),

        Row(
          children: [
            Radio<String>(
              value: "Lost",
              groupValue: belongingType,
              onChanged: (value) {
                setState(() {
                  belongingType = value!;
                });
              },
            ),
            const Text("Lost"),
            const SizedBox(width: 20),
            Radio<String>(
              value: "Found",
              groupValue: belongingType,
              onChanged: (value) {
                setState(() {
                  belongingType = value!;
                });
              },
            ),
            const Text("Found"),
          ],
        ),
        const SizedBox(height: 16),

        buildTextField("Add items description.."),
        buildTextField("Add items category"),
        buildTextField("Enter location"),
        buildTextField("Found date & Time"),
        buildTextField("Contact Information"),

        const SizedBox(height: 20),

        GestureDetector(
          onTap: _pickImage,
          child: Container(
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, style: BorderStyle.solid),
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
                        // width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
          ),
        ),

        //btn submit
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: SizedBox(
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
              ),
              child: Text('Submit', style: TextStyle(color: Colors.white)),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildTextField(String hint) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        decoration: InputDecoration(
          hintText: hint,
          border: const UnderlineInputBorder(),
        ),
      ),
    );
  }
}
