import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/utils/app_textstyle.dart';

class CustomSearch extends StatelessWidget {
  const CustomSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: TextField(
        style: AppTextStyle.bodyLight,
        decoration: InputDecoration(
          hintText: 'Search for item, pet or family member',
          prefixIcon: Icon(Icons.search),
          suffixIcon: Icon(Icons.tune),
          fillColor: Color(0xFFFFFFFF),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}
