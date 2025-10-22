import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/detail_notification.dart';
import 'package:flutter_application_1/Screens/found_item_detail_screen.dart';
import 'package:flutter_application_1/controllers/filter_controller.dart';
import 'package:flutter_application_1/controllers/product_controller.dart';
import 'package:flutter_application_1/model/belonging_model.dart';
import 'package:flutter_application_1/utils/app_textstyle.dart';
import 'package:flutter_application_1/widget/belonging_card.dart';
import 'package:flutter_application_1/widget/belonging_card_lost.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

class Homescreen extends StatefulWidget {
  Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  bool showFound = true;
  String? selectedCategory;
  List<BelongingModel> filteredBelongingList = [];
  final ProductController productController = Get.put(ProductController());
  final FilterController filterController = Get.put(FilterController());

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
              // onTap:
              //     () => Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => ItemDetailpage()),
              //     ),
              onTap:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ItemDetailpage(item: item),
                    ),
                  ),
              child: BelongingCard(belonging: item),
            );
          }, childCount: foundItems.length),
        ),
      );
    });
  }

  // SliverGrid for Lost items
  Widget buildLostPage() {
    return Obx(() {
      if (productController.isLoading.value) {
        return const SliverToBoxAdapter(
          child: Center(child: CircularProgressIndicator()),
        );
      }

      final foundItems =
          productController.itemList
              .where((item) => item.type == "LOST")
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
            crossAxisCount: 1,
            childAspectRatio: (220 / 170),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          delegate: SliverChildBuilderDelegate((context, index) {
            final item = foundItems[index];
            return GestureDetector(
              // onTap:
              //     () => Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => ItemDetailpage()),
              //     ),
              onTap:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ItemDetailpage(item: item),
                    ),
                  ),

              child: BelongingCardLostPage(belonging: item),
            );
          }, childCount: foundItems.length),
        ),
      );
    });
  }

  //new updated
  Widget _buildCategoryButton(String title) {
    return Obx(() {
      final isSelected = filterController.selectedCategory.value == title;

      return OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: isSelected ? const Color(0xFF6096BA) : Colors.grey,
          ),
          backgroundColor:
              isSelected
                  ? const Color(0xFF6096BA).withOpacity(0.2)
                  : Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        ),
        onPressed: () => filterController.selectCategory(title),
        child: Text(
          title,
          style: AppTextStyle.bodyLarge.copyWith(
            color: isSelected ? const Color(0xFF6096BA) : Colors.black,
          ),
        ),
      );
    });
  }

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

              // Obx(
              //   () =>
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

              // ),
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
                  filterController.applyFilters();
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
}
