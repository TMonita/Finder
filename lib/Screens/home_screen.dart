import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/detail_notification.dart';
import 'package:flutter_application_1/Screens/found_item_detail_screen.dart';
import 'package:flutter_application_1/Screens/lost_item_detail_screen.dart';
import 'package:flutter_application_1/model/belonging_model.dart';
import 'package:flutter_application_1/utils/app_textstyle.dart';
import 'package:flutter_application_1/widget/belonging_card.dart';
import 'package:flutter_application_1/widget/belonging_card_lost.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  bool showFound = true;
  String? selectedCategory;
  List<BelongingModel> filteredBelongingList = [];

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
  Widget buildFoundPage() {
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
          BelongingModel belonging = belongingList[index];
          return GestureDetector(
            onTap:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ItemDetailpage()),
                ),
            child: BelongingCard(belonging: belonging),
          );
        }, childCount: belongingList.length),
      ),
    );
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
