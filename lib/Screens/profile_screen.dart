import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/edit_profile_screen.dart';
import 'package:flutter_application_1/Screens/my_reports_detail.dart';
import 'package:flutter_application_1/Screens/view_all_badges.dart';
import 'package:flutter_application_1/controllers/badge_controller.dart';
import 'package:flutter_application_1/controllers/item_controller.dart';
import 'package:flutter_application_1/controllers/myreport_controller.dart';
import 'package:flutter_application_1/controllers/user_controller.dart';
import 'package:flutter_application_1/model/belonging_model.dart';
import 'package:flutter_application_1/model/user_model.dart';
import 'package:flutter_application_1/service/dio.dart';
import 'package:flutter_application_1/utils/app_textstyle.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_application_1/widget/row_belonging_card.dart';
import 'package:get/get.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({super.key});

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  final BadgeController badgeController = Get.find<BadgeController>();
  final UserController userController = Get.put(UserController());
  final ItemsController itemsController = Get.put(ItemsController());
  final MyReportController myReportController = Get.put(MyReportController());
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  String _username = "Tho Violet";
  String _address = "Phnom Penh";
  String? _imagePath;

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: SafeArea(
  //       child: ListView(
  //         padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),

  //         children: [
  //           SizedBox(height: 20),
  //           buildStaticProfile(),
  //           buildBadges(),
  //           buildText(),
  //           buildMyReport(),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  @override
  void initState() {
    logUserID();
    super.initState();
    // _loadUserData();
  }

  dynamic logUserID() async {
    final userid = await _storage.read(key: "user_id");
    print('user_id$userid');
    if (userid != null) {
      await myReportController.fetchMyReports(int.parse(userid));
    } else {
      print('⚠️ No user_id found in storage');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          if (userController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          final user = userController.currentUser.value;
          if (user == null) {
            return const Center(child: Text("No user data found"));
            // return buildStaticProfile();
          }

          return ListView(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            children: [
              const SizedBox(height: 20),
              buildProfile(context, user),
              buildBadges(),
              buildText(),
              buildMyReport(),
            ],
          );
        }),
      ),
    );
  }

  Widget buildStaticProfile() {
    return Column(
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage:
                  _imagePath != null
                      ? FileImage(File(_imagePath!))
                      : AssetImage('images/violet.jpg') as ImageProvider,
            ),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(_username, style: AppTextStyle.h2_3),
                    IconButton(
                      onPressed: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProfileScreen(),
                          ),
                        );
                        if (result != null && result is Map<String, dynamic>) {
                          setState(() {
                            if (result['imagePath'] != null) {
                              _imagePath = result['imagePath'];
                            }
                            _username = result['username'] ?? _username;
                            _address = result['address'] ?? _address;
                          });
                        }
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => EditProfileScreen(),
                        //   ),
                        // );
                      },

                      icon: Icon(Icons.edit, size: 15),
                    ),
                  ],
                ),
                Text(_address, style: AppTextStyle.bodyLarge),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget buildProfile(BuildContext context, UserModel user) {
    return Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage:
              user.profileImageUrl != null
                  ? NetworkImage(
                    '${DioService.baseUrl}/${user.profileImageUrl!}',
                  )
                  : const AssetImage('images/violet.jpg') as ImageProvider,
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(user.name, style: AppTextStyle.h2_3),
                IconButton(
                  icon: const Icon(Icons.edit, size: 15),
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfileScreen(),
                      ),
                    );
                    if (result != null) {
                      userController.fetchCurrentUser();
                    }
                  },
                ),
              ],
            ),
            Text(
              user.address ?? 'No address provided',
              style: AppTextStyle.bodyLarge,
            ),
          ],
        ),
      ],
    );
  }

  // Widget buildProfile(BuildContext context, user) {
  //   return Row(
  //     children: [
  //       CircleAvatar(
  //         radius: 30,
  //         backgroundImage:
  //             user.profileImageUrl != null
  //                 ? NetworkImage(
  //                   '${DioService.baseUrl}/${user.profileImageUrl!}',
  //                 )
  //                 : const AssetImage('images/violet.jpg') as ImageProvider,
  //       ),
  //       const SizedBox(width: 20),
  //       Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Row(
  //             children: [
  //               Text(user.name, style: AppTextStyle.h2_3),
  //               IconButton(
  //                 icon: const Icon(Icons.edit, size: 15),
  //                 onPressed: () async {
  //                   final result = await Navigator.push(
  //                     context,
  //                     MaterialPageRoute(
  //                       builder: (context) => EditProfileScreen(),
  //                     ),
  //                   );

  //                   // If profile updated, refresh GetX controller
  //                   if (result != null) {
  //                     userController.fetchCurrentUser();
  //                   }
  //                 },
  //               ),
  //             ],
  //           ),
  //           Text(
  //             user.address ?? 'No address provided',
  //             style: AppTextStyle.bodyLarge,
  //           ),
  //         ],
  //       ),
  //     ],
  //   );
  // }

  // Widget buildBadges() {
  //   return Container(
  //     child: Column(
  //       children: [
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: Text('Your Badges', style: AppTextStyle.h3),
  //             ),
  //             Row(
  //               children: [
  //                 Text('View All', style: AppTextStyle.bodyMedium),
  //                 IconButton(
  //                   onPressed: () {
  //                     Navigator.push(
  //                       context,
  //                       MaterialPageRoute(
  //                         builder: (context) => ViewAllBadges(),
  //                       ),
  //                     );
  //                   },
  //                   icon: Icon(Icons.arrow_forward_ios_rounded, size: 10),
  //                 ),
  //               ],
  //             ),
  //           ],
  //         ),
  //         SizedBox(height: 20),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //           children: [
  //             Column(
  //               children: [
  //                 // CircleAvatar(
  //                 //   radius: 40,
  //                 //   backgroundImage: AssetImage('images/violet.jpg'),
  //                 // ),
  //                 Stack(
  //                   children: [
  //                     SizedBox(
  //                       height: 60,
  //                       child: Image.asset('images/community_helper.png'),
  //                     ),
  //                   ],
  //                 ),
  //                 Text(
  //                   'Community\nHelper',
  //                   style: AppTextStyle.bodyMedium,
  //                   textAlign: TextAlign.center,
  //                 ),
  //               ],
  //             ),
  //             Column(
  //               children: [
  //                 // CircleAvatar(
  //                 //   radius: 40,
  //                 //   backgroundImage: AssetImage('images/violet.jpg'),
  //                 // ),
  //                 Stack(
  //                   children: [
  //                     SizedBox(
  //                       height: 60,
  //                       child: Image.asset('images/reunion_hero.png'),
  //                     ),
  //                   ],
  //                 ),
  //                 Text(
  //                   'Reunion\nHero',
  //                   style: AppTextStyle.bodyMedium,
  //                   textAlign: TextAlign.center,
  //                 ),
  //               ],
  //             ),
  //             Column(
  //               children: [
  //                 // CircleAvatar(
  //                 //   radius: 40,
  //                 //   backgroundImage: AssetImage('images/violet.jpg'),
  //                 // ),
  //                 Stack(
  //                   children: [
  //                     SizedBox(
  //                       height: 60,
  //                       child: Image.asset('images/Medallions.png'),
  //                     ),
  //                   ],
  //                 ),
  //                 Text(
  //                   'Recovery\nChampion',
  //                   style: AppTextStyle.bodyMedium,
  //                   textAlign: TextAlign.center,
  //                 ),
  //               ],
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget buildBadges() {
    return Obx(() {
      // if (badgeController.isLoading.value) {
      //   return const Center(child: CircularProgressIndicator());
      // }

      // If no unlocked badges
      if (badgeController.unlockedBadgeIds.isEmpty) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Your Badges', style: AppTextStyle.h3),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  'No badges yet',
                  style: AppTextStyle.bodyMedium.copyWith(
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        );
      }

      // Show badges if available
      final unlockedBadges =
          badgeController.badges
              .where((badge) => badgeController.isUnlocked(badge))
              .toList();

      return Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Your Badges', style: AppTextStyle.h3),
                ),
                Row(
                  children: [
                    Text('View All', style: AppTextStyle.bodyMedium),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewAllBadges(),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 10,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children:
                    unlockedBadges.map((badge) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 60,
                              child: Image.network(
                                '${DioService.baseUrl}/${badge.iconUrl}',
                                errorBuilder:
                                    (context, error, stackTrace) =>
                                        const Icon(Icons.error),
                              ),
                            ),
                            Text(
                              badge.name,
                              style: AppTextStyle.bodyMedium,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    }).toList(),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget buildText() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('My Report', style: AppTextStyle.h3),
            Row(
              children: [
                Text('View All', style: AppTextStyle.bodyMedium),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyReportsDetail(),
                      ),
                    );
                  },
                  icon: Icon(Icons.arrow_forward_ios_rounded, size: 10),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget buildMyReport() {
  //   return Container(
  //     // height: 800,
  //     child: GridView.builder(
  //       // padding: EdgeInsets.zero,
  //       shrinkWrap: true,
  //       physics: NeverScrollableScrollPhysics(),
  //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //         crossAxisCount: 1,
  //         childAspectRatio: (25 / 10),
  //       ),
  //       scrollDirection: Axis.vertical,
  //       itemCount: belongingList.length,
  //       itemBuilder: (context, index) {
  //         BelongingModel belonging = belongingList[index];
  //         return RowBelongingCard(
  //           belonging: itemsController.itemList[index],
  //           showButtons: false,
  //         );
  //       },
  //     ),
  //   );
  // }
  //   Widget buildMyReport() {
  //     if (myReportController.isLoading.value) {
  //       return const Center(child: CircularProgressIndicator());
  //     }

  //     if (myReportController.errorMessage.isNotEmpty) {
  //       return Center(child: Text(myReportController.errorMessage.value));
  //     }

  //     if (myReportController.myReports.isEmpty) {
  //       return const Center(child: Text('No reports found.'));
  //     }

  //     return Container(
  //       child: GridView.builder(
  //         shrinkWrap: true,
  //         physics: NeverScrollableScrollPhysics(),
  //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //           crossAxisCount: 1,
  //           childAspectRatio: (25 / 10),
  //         ),
  //         // itemCount: belongingList.length,
  //         itemCount: myReportController.myReports.length,
  //         itemBuilder: (context, index) {
  //           // BelongingModel belonging = belongingList[index];
  //           return RowBelongingCard(
  //             belonging: myReportController.myReports[index],
  //             showButtons: false,
  //           );
  //         },
  //       ),
  //     );
  //   }
  // }

  Widget buildMyReport() {
    return Obx(() {
      if (myReportController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (myReportController.errorMessage.isNotEmpty) {
        return Center(child: Text(myReportController.errorMessage.value));
      }

      if (myReportController.myReports.isEmpty) {
        return const Center(child: Text('No reports found.'));
      }

      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: (25 / 10),
        ),
        itemCount: myReportController.myReports.length,
        itemBuilder: (context, index) {
          return RowBelongingCard(
            belonging: myReportController.myReports[index],
            showButtons: false,
          );
        },
      );
    });
  }
}
