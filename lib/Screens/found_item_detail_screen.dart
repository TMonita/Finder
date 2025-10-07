import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/navigation_controller.dart';
import 'package:flutter_application_1/utils/app_textstyle.dart';
import 'package:flutter_application_1/widget/confirm_message_dialog.dart';
import 'package:get/instance_manager.dart';

class ItemDetailpage extends StatefulWidget {
  const ItemDetailpage({super.key});

  @override
  State<ItemDetailpage> createState() => _ItemDetailpageState();
}

class _ItemDetailpageState extends State<ItemDetailpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: ListView(children: [buildAppbar(), buildDetail()])),
      bottomNavigationBar: buildBtn(),
    );
  }

  Widget buildAppbar() {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF274C77)),
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => MainScreen()),
            // );
            Navigator.pop(context);
          },
        ),
        Expanded(
          child: Center(
            child: Text(
              'Found Item',
              // style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              style: AppTextStyle.h1.copyWith(color: Color(0xFF274C77)),
            ),
          ),
        ),

        IconButton(
          onPressed: () {},
          icon: Icon(Icons.share, color: Color(0xFF274C77)),
        ),
      ],
    );
  }

  Widget buildDetail() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.asset(
              'images/charger.png',
              fit: BoxFit.cover,
              height: 320,
              width: double.infinity,
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Electronic",
                  style: AppTextStyle.body2ndLarge.copyWith(
                    color: Color(0xFF6096BA),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "I found this charger at school campus and now it still here with me",
                  style: AppTextStyle.bodyLarge,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Opacity(
                      opacity: 0.8,
                      child: Icon(Icons.watch_later_outlined, size: 12),
                    ),
                    SizedBox(width: 4),
                    Text('2 hours ago', style: AppTextStyle.bodySmall),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Opacity(
                      opacity: 0.8,
                      child: Icon(Icons.pin_drop_outlined, size: 12),
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Limkokwing University',
                      style: AppTextStyle.bodySmall,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => ProfilScreen()),
                    // );
                    // Get.find<NavigationController>().currentIndex.value = 4;
                    Get.find<NavigationController>().changeIndex(4);
                    Navigator.pop(context);
                  },

                  child: Text(
                    'Add post by Tho Violet',
                    style: AppTextStyle.bodyLarge.copyWith(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBtn() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min, // keeps buttons compact
        children: [
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.call, size: 30, color: Color(0xFF274C77)),
              label: Text(
                'Call',
                style: AppTextStyle.h2_2.copyWith(color: Color(0xFF274C77)),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFE7ECEF),
              ),
            ),
          ),
          SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => ConfirmMessageDialog(),
                );
              },

              icon: Icon(
                Icons.messenger_outline_rounded,
                size: 30,
                color: Colors.white,
              ),
              label: Text(
                'Message in the app',
                style: AppTextStyle.h2_2.copyWith(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF274C77),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
