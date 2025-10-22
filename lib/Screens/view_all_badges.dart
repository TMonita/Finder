import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/badge_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/utils/app_textstyle.dart';

class ViewAllBadges extends StatelessWidget {
  const ViewAllBadges({super.key});

  @override
  Widget build(BuildContext context) {
    final BadgeController controller = Get.put(BadgeController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        title: Text(
          'Achievements',
          style: AppTextStyle.h1.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),

      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.badges.isEmpty) {
            return const Center(child: Text('No badges available'));
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: GridView.builder(
              itemCount: controller.badges.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 20,
                crossAxisSpacing: 10,
                childAspectRatio: 0.85,
              ),
              itemBuilder: (context, index) {
                final badge = controller.badges[index];
                final isUnlocked = controller.isUnlocked(badge);

                return Opacity(
                  opacity: isUnlocked ? 1.0 : 0.3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          badge.iconUrl,
                          height: 70,
                          fit: BoxFit.contain,
                          errorBuilder:
                              (context, error, stackTrace) => const Icon(
                                Icons.broken_image,
                                size: 60,
                                color: Colors.grey,
                              ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        badge.name,
                        textAlign: TextAlign.center,
                        style: AppTextStyle.bodyLarge.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
