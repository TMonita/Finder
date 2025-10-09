import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/app_colortheme.dart';
import 'package:flutter_application_1/utils/app_textstyle.dart';

class ViewAllBadges extends StatelessWidget {
  const ViewAllBadges({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.primary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Achievements',
          style: AppTextStyle.h1.copyWith(color: AppColors.primary),
        ),
      ),

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          children: [
            _buildSectionTitle('Personal Records'),
            const SizedBox(height: 10),
            _buildPersonalRecords(),
            const SizedBox(height: 25),
            _buildSectionTitle('Badges'),
            const SizedBox(height: 10),
            _buildAwards(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: AppTextStyle.h2.copyWith(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildPersonalRecords() {
    final List<Map<String, dynamic>> records = [
      {
        'icon': 'images/Medallions.png',
        'value': '82',
        'label': 'Community Helper',
        'date': 'Jul 23, 2025',
      },
      {
        'icon': 'images/Medallions.png',
        'value': '#13',
        'label': 'Reunion \nHero',
        'date': 'Jun 16, 2025',
      },
      {
        'icon': 'images/Medallions.png',
        'value': '629',
        'label': 'Recovery Champion',
        'date': 'Jun 3, 2025',
      },
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:
          records.map((r) {
            return Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.tertiary.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(r['icon'], height: 60),
                    const SizedBox(height: 6),
                    Text(
                      r['value'],
                      style: AppTextStyle.h1.copyWith(color: Colors.black),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      r['label'],
                      textAlign: TextAlign.center,
                      style: AppTextStyle.bodyLarge.copyWith(
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      r['date'],
                      style: AppTextStyle.bodyMedium.copyWith(
                        color: Colors.black26,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
    );
  }

  Widget _buildAwards(BuildContext context) {
    final List<Map<String, dynamic>> awards = [
      {
        'icon': 'images/Medallions.png',
        'value': '30',
        'label': 'Lost & Found Legend',
        'progress': '4 of 10',
        'description': 'You have a high number of successful reunions',
      },
      {
        'icon': 'images/Medallions.png',
        'value': '50',
        'label': 'Item Rescuer',
        'progress': '6 of 10',
        'description': 'frequently report found items.',
      },
      {
        'icon': 'images/Medallions.png',
        'value': '50',
        'label': 'Trust Builder',
        'progress': '4 of 5',
        'description': 'Encouraged others to keep helping.',
      },
      {
        'icon': 'images/Medallions.png',
        'value': '12500',
        'label': 'Neighborhood Star',
        'progress': '8 of 10',
        'description': 'You are incredible!',
      },
      {
        'icon': 'images/Medallions.png',
        'value': '5',
        'label': 'Kindness Keeper',
        'progress': '3 of 9',
        'description': 'You show exceptional kindness in helping others',
      },
      {
        'icon': 'images/Medallions.png',
        'value': '100',
        'label': 'Eco Connector',
        'progress': '5 of 10',
        'description': 'You completed 5 reunion! Amazing progress.',
      },
    ];

    return GridView.builder(
      itemCount: awards.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.8,
        crossAxisSpacing: 10,
        mainAxisSpacing: 20,
      ),
      itemBuilder: (context, index) {
        final item = awards[index];
        return GestureDetector(
          onTap: () {
            _showBadgeDetail(context, item);
          },
          child: Column(
            children: [
              Column(
                children: [
                  Image.asset(item['icon'], height: 70),
                  const SizedBox(height: 10),
                  Text(
                    item['value'].toString(),
                    style: AppTextStyle.h2.copyWith(color: Colors.black),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                item['label'],
                style: AppTextStyle.bodyMedium.copyWith(color: Colors.black),
                textAlign: TextAlign.center,
              ),
              Text(
                item['progress'],
                style: AppTextStyle.bodySmall.copyWith(color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }

  // --- Popup Badge Detail ---
  void _showBadgeDetail(BuildContext context, Map<String, dynamic> item) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          backgroundColor: AppColors.tertiary,
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 100,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(item['icon'], height: 100),
                const SizedBox(height: 10),
                Text(
                  item['value'],
                  style: AppTextStyle.h1.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 12),
                Text(
                  item['description'],
                  textAlign: TextAlign.center,
                  style: AppTextStyle.bodyLarge.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 12),
                Text(
                  'Jul 23, 2025',
                  style: AppTextStyle.bodySmall.copyWith(color: Colors.white70),
                ),
                const SizedBox(height: 20),
                Text(
                  'You have reunion ${item['value']} items!',
                  textAlign: TextAlign.center,
                  style: AppTextStyle.bodyLarge.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
