import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/detail_notification.dart';
import 'package:flutter_application_1/Screens/found_item_detail_screen.dart';
import 'package:flutter_application_1/Screens/lost_item_detail_screen.dart';
import 'package:flutter_application_1/controllers/product_controller.dart';
import 'package:flutter_application_1/model/belonging_model.dart';
import 'package:flutter_application_1/utils/app_textstyle.dart';
import 'package:flutter_application_1/widget/belonging_card.dart';
import 'package:flutter_application_1/widget/belonging_card_lost.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  bool showFound = true;
  String? selectedCategory;
  List<BelongingModel> filteredBelongingList = [];
  final ProductController productController = Get.put(ProductController());

  @override
  void initState() {
    super.initState();
    filteredBelongingList = belongingList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Header + Search
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 12,
                ),
                child: Column(
                  children: [
                    buildHeader(),
                    const SizedBox(height: 10),
                    buildSearch(),
                    // const SizedBox(height: 10),
                  ],
                ),
              ),
            ),

            // Found / Lost body
            showFound ? buildFoundPage() : buildLostPage(),
          ],
        ),
      ),
    );
  }

  Widget buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => setState(() => showFound = true),
          child: Text(
            'Found',

            style: AppTextStyle.headingWithColor(!showFound),
          ),
        ),
        const SizedBox(width: 20),
        GestureDetector(
          onTap: () => setState(() => showFound = false),
          child: Text('Lost', style: AppTextStyle.headingWithColor(showFound)),
        ),
        const Spacer(),

        IconButton(
          icon: Icon(
            Icons.notifications_none_rounded,
            size: 25,
            color: Color(0xFF274C77),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DetailNotification()),
            );
          },
        ),
      ],
    );
  }

  Widget buildSearch() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search for item, pet or family member',
              hintStyle: AppTextStyle.hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding: const EdgeInsets.all(8),
              prefixIcon: const Icon(
                Icons.search_rounded,
                color: Color(0xFF274C77),
              ),
              suffixIcon: IconButton(
                icon: Icon(Icons.tune_outlined),
                color: Color(0xFF274C77),
                onPressed: () {
                  _showFilterSheet(context);
                },
              ),
              filled: true,
              fillColor: Colors.white,
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // SliverGrid for Found items
  // Widget buildFoundPage() {
  //   return SliverPadding(
  //     padding: const EdgeInsets.all(12),
  //     sliver: SliverGrid(
  //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //         crossAxisCount: 2,
  //         childAspectRatio: (100 / 160),
  //         crossAxisSpacing: 12,
  //         mainAxisSpacing: 12,
  //       ),
  //       delegate: SliverChildBuilderDelegate((context, index) {
  //         BelongingModel belonging = belongingList[index];
  //         return GestureDetector(
  //           onTap:
  //               () => Navigator.push(
  //                 context,
  //                 MaterialPageRoute(builder: (context) => ItemDetailpage()),
  //               ),
  //           child: BelongingCard(belonging: belonging),
  //         );
  //       }, childCount: belongingList.length),
  //     ),
  //   );
  // }

  Widget buildFoundPage() {
    return Obx(() {
      if (productController.isLoading.value) {
        return const SliverToBoxAdapter(
          child: Center(child: CircularProgressIndicator()),
        );
      }

      final foundItems =
          productController.itemList
              .where((item) => item.type == "FOUND")
              .toList();

      if (foundItems.isEmpty) {
        return const SliverToBoxAdapter(
          child: Center(child: Text('No found items yet')),
        );
      }

      return SliverPadding(
        padding: const EdgeInsets.all(12),
        sliver: SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: (100 / 160),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          delegate: SliverChildBuilderDelegate((context, index) {
            final item = foundItems[index];
            return GestureDetector(
              onTap:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ItemDetailpage()),
                  ),
              child: BelongingCard(belonging: item), // <— using AllItemsModel
            );
          }, childCount: foundItems.length),
        ),
      );
    });
  }

  // SliverGrid for Lost items
  Widget buildLostPage() {
    return SliverPadding(
      padding: const EdgeInsets.all(12),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: (220 / 170),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        delegate: SliverChildBuilderDelegate((context, index) {
          BelongingModel belonging = belongingList[index];
          return GestureDetector(
            onTap:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LostItemDetailpage()),
                ),
            child: BelongingCardLostPage(belonging: belonging),
          );
        }, childCount: belongingList.length),
      ),
    );
  }
}

//filter
void _showFilterSheet(BuildContext context) {
  showModalBottomSheet(
    backgroundColor: Colors.white,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),

    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(10),

        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text("Filters", style: AppTextStyle.h3),
            ),
            const SizedBox(height: 20),

            Text("Categories", style: AppTextStyle.bodyLarge),

            const SizedBox(height: 20),

            // Categories buttons
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                _buildCategoryButton("Electronic"),
                _buildCategoryButton("Jewelry"),
                _buildCategoryButton("Document"),
                _buildCategoryButton("Key"),
                _buildCategoryButton("Bag"),
                _buildCategoryButton("Pet"),
                _buildCategoryButton("Person"),
              ],
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6096BA),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {
                Navigator.pop(context); // close bottom sheet
              },
              child: Text(
                "Apply",
                style: AppTextStyle.h2.copyWith(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      );
    },
  );
}

Widget _buildCategoryButton(String title) {
  return OutlinedButton(
    style: OutlinedButton.styleFrom(
      side: const BorderSide(color: Colors.grey),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      backgroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    ),

    onPressed: () {},
    child: Text(
      title,
      style: AppTextStyle.bodyLarge.copyWith(color: Colors.black),
    ),
  );
}

/* New Update, change ui*/
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/controllers/product_controller.dart';
// import 'package:flutter_application_1/model/postitems_model.dart';
// import 'package:get/get.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   final ProductController controller = Get.put(ProductController());

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Column(
//           children: [
//             // Tabs
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: TabBar(
//                       controller: _tabController,
//                       labelColor: Colors.black,
//                       unselectedLabelColor: Colors.grey,
//                       indicatorColor: Colors.blueAccent,
//                       tabs: const [Tab(text: 'Found'), Tab(text: 'Lost')],
//                     ),
//                   ),
//                   const Icon(Icons.notifications_none, color: Colors.black),
//                 ],
//               ),
//             ),

//             // Search bar
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
//               child: TextField(
//                 decoration: InputDecoration(
//                   hintText: 'Search for item, pet or family member',
//                   prefixIcon: const Icon(Icons.search),
//                   suffixIcon: const Icon(Icons.filter_list),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//               ),
//             ),

//             // Posts grid
//             Expanded(
//               child: TabBarView(
//                 controller: _tabController,
//                 children: [_buildPostGrid("FOUND"), _buildPostGrid("LOST")],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildPostGrid(String type) {
//     return Obx(() {
//       if (controller.isLoading.value) {
//         return const Center(child: CircularProgressIndicator());
//       }

//       final filtered =
//           controller.productList
//               .where((p) => p.type?.toUpperCase() == type)
//               .toList();

//       if (filtered.isEmpty) {
//         return const Center(child: Text('No posts found.'));
//       }

//       return GridView.builder(
//         padding: const EdgeInsets.all(16),
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           childAspectRatio: 0.68,
//           crossAxisSpacing: 16,
//           mainAxisSpacing: 16,
//         ),
//         itemCount: filtered.length,
//         itemBuilder: (context, index) {
//           final post = filtered[index];
//           return _buildPostCard(post);
//         },
//       );
//     });
//   }

//   Widget _buildPostCard(PostItemModel post) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.2),
//             blurRadius: 5,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Image with status badge
//           Stack(
//             children: [
//               ClipRRect(
//                 borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(12),
//                   topRight: Radius.circular(12),
//                 ),
//                 child: Image.network(
//                   post.imageUrl ??
//                       'https://storage.googleapis.com/finder-896b2.firebasestorage.app/images/5048bbb7-3e60-4364-803a-a0002439b23f-golden.webp',
//                   height: 130,
//                   width: double.infinity,
//                   fit: BoxFit.cover,
//                   errorBuilder:
//                       (_, __, ___) => Container(
//                         height: 130,
//                         color: Colors.grey.shade200,
//                         child: const Icon(Icons.image_not_supported),
//                       ),
//                 ),
//               ),
//               Positioned(
//                 top: 8,
//                 right: 8,
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 8,
//                     vertical: 4,
//                   ),
//                   decoration: BoxDecoration(
//                     color: Colors.blueAccent,
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: const Text(
//                     'Pending',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 12,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),

//           // Post details
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   post.title ?? 'Untitled',
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   style: const TextStyle(
//                     fontWeight: FontWeight.w600,
//                     fontSize: 14,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   post.description ?? '',
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                   style: const TextStyle(color: Colors.grey, fontSize: 12),
//                 ),
//                 const SizedBox(height: 6),
//                 Row(
//                   children: [
//                     const Icon(Icons.location_on, color: Colors.grey, size: 14),
//                     const SizedBox(width: 4),
//                     Expanded(
//                       child: Text(
//                         post.location ?? '',
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                         style: const TextStyle(
//                           fontSize: 12,
//                           color: Colors.grey,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
