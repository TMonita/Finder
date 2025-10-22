import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/navigation_controller.dart';
import 'package:flutter_application_1/controllers/item_controller.dart';
import 'package:flutter_application_1/controllers/user_controller.dart';
import 'package:flutter_application_1/utils/app_textstyle.dart';
import 'package:flutter_application_1/widget/confirm_message_dialog.dart';
import 'package:get/instance_manager.dart';
import 'package:flutter_application_1/model/allitems_model.dart';
import 'package:timeago/timeago.dart' as timeago;

class ItemDetailpage extends StatefulWidget {
  final AllItemsModel item;

  const ItemDetailpage({super.key, required this.item});

  @override
  State<ItemDetailpage> createState() => _ItemDetailpageState();
}

class _ItemDetailpageState extends State<ItemDetailpage> {
  final userController = Get.find<UserController>();
  final productController = Get.find<ItemsController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: ListView(children: [buildAppbar(), buildDetail()])),
      bottomNavigationBar: buildBtn(),
    );
  }

  Widget buildAppbar() {
    String title =
        widget.item.type == "FOUND"
            ? "Found Item Details"
            : "Lost Item Details";

    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF274C77)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        Expanded(
          child: Center(
            child: Text(
              title,
              style: AppTextStyle.h1.copyWith(color: const Color(0xFF274C77)),
            ),
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.share, color: Color(0xFF274C77)),
        ),
      ],
    );
  }

  Widget buildDetail() {
    final item = widget.item;

    return Container(
      padding: const EdgeInsets.all(8.0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child:
                item.imageUrl != null && item.imageUrl!.isNotEmpty
                    ? Image.network(
                      item.imageUrl!,
                      fit: BoxFit.cover,
                      height: 320,
                      width: double.infinity,
                    )
                    : Image.asset(
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
                  item.categoryName ?? 'Unknown Category',
                  style: AppTextStyle.body2ndLarge.copyWith(
                    color: const Color(0xFF6096BA),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  item.description ?? 'No description provided',
                  style: AppTextStyle.bodyLarge,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Opacity(
                      opacity: 0.8,
                      child: Icon(Icons.watch_later_outlined, size: 12),
                    ),
                    const SizedBox(width: 4),
                    // Text(item.timeLostAt ?? '',
                    Text(
                      item.timeLostAt != null && item.timeLostAt!.isNotEmpty
                          ? timeago.format(DateTime.parse(item.timeLostAt!))
                          : '',
                      style: AppTextStyle.bodySmall,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Opacity(
                      opacity: 0.8,
                      child: Icon(Icons.pin_drop_outlined, size: 12),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      item.location ?? 'Unknown location',
                      style: AppTextStyle.bodySmall,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Get.find<NavigationController>().changeIndex(4);
                    Navigator.pop(context);
                  },
                  child: Text(
                    // 'Add post by ${item.userId ?? "Unknown"}',
                    'Add post by ${Get.find<UserController>().getUserName(item.userId)}',
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
