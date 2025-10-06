import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/belonging_model.dart';
import 'package:flutter_application_1/utils/app_textstyle.dart';
import 'package:flutter_application_1/widget/row_belonging_card.dart';

class MyReportsDetail extends StatefulWidget {
  const MyReportsDetail({super.key});

  @override
  State<MyReportsDetail> createState() => _MyReportsDetailState();
}

class _MyReportsDetailState extends State<MyReportsDetail>
    with SingleTickerProviderStateMixin {
  late TabController _reportTabController;

  @override
  void initState() {
    super.initState();
    _reportTabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        titleSpacing: 0,
        title: Text(
          'All reports',
          style: AppTextStyle.h1.copyWith(color: Color(0xFF274C77)),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Color(0xFF274C77),
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        bottom: TabBar(
          controller: _reportTabController,
          isScrollable: true,
          tabs: const [
            Tab(text: "All"),
            Tab(text: "Pending"),
            Tab(text: "In Progress"),
            Tab(text: "Founded"),
          ],
          labelStyle: AppTextStyle.bodyLarge,
        ),
      ),

      // body: SafeArea(child: buildbody()),
      body: TabBarView(
        controller: _reportTabController,
        children: [
          ListView(children: [builAllTap()]),
          Center(
            child: Text(
              "Pending here",
              style: AppTextStyle.h2_2.copyWith(color: Colors.black45),
            ),
          ),
          Center(
            child: Text(
              "In Progress here",
              style: AppTextStyle.h2_2.copyWith(color: Colors.black45),
            ),
          ),
          Center(
            child: Text(
              "Items Founded here",
              style: AppTextStyle.h2_2.copyWith(color: Colors.black45),
            ),
          ),
        ],
      ),
    );
  }

  // Widget buildAllTab() {
  //   return ListView(
  //     padding: const EdgeInsets.all(12),

  //     children: [
  //       _buildCard(
  //         icon: Icons.account_balance_wallet,
  //         title: "Wallet Found",
  //         status: "Status",
  //         statusColor: Colors.green,
  //         subtitle: "Location: Building A, Floor 2\nTime: 2 hours ago",
  //         actions: [
  //           _buildActionButton("View Details"),
  //           _buildActionButton("Mark Claimed"),
  //         ],
  //       ),
  //       const SizedBox(height: 12),
  //       _buildCard(
  //         icon: Icons.smartphone,
  //         title: "Phone Lost",
  //         status: "Pending",
  //         statusColor: Colors.orange,
  //         subtitle: "Last seen: Cafeteria\nTime: 1 day ago",
  //         actions: [_buildActionButton("View Details")],
  //       ),
  //       const SizedBox(height: 12),
  //       _buildCard(
  //         icon: Icons.access_time,
  //         title: "Reminder",
  //         subtitle:
  //             "You reported a lost item 7 days ago.\nCheck if it has been found.",
  //         actions: [_buildActionButton("Check Items")],
  //       ),
  //     ],
  //   );
  // }

  // Widget _buildCard({
  //   required IconData icon,
  //   required String title,
  //   String? status,
  //   Color? statusColor,
  //   required String subtitle,
  //   required List<Widget> actions,
  // }) {
  //   return Card(
  //     color: Colors.white,
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  //     elevation: 2,
  //     child: Padding(
  //       padding: const EdgeInsets.all(12),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Row(
  //             children: [
  //               Icon(icon, size: 32),
  //               const SizedBox(width: 10),
  //               Expanded(
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text(
  //                       title,
  //                       style: const TextStyle(
  //                         fontSize: 16,
  //                         fontWeight: FontWeight.bold,
  //                       ),
  //                     ),
  //                     if (status != null)
  //                       Text(
  //                         status,
  //                         style: TextStyle(
  //                           color: statusColor ?? Colors.black,
  //                           fontWeight: FontWeight.w500,
  //                         ),
  //                       ),
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           ),
  //           const SizedBox(height: 8),
  //           Text(subtitle, style: const TextStyle(fontSize: 14)),
  //           const SizedBox(height: 8),
  //           Row(
  //             children:
  //                 actions
  //                     .map(
  //                       (e) => Padding(
  //                         padding: const EdgeInsets.only(right: 8),
  //                         child: e,
  //                       ),
  //                     )
  //                     .toList(),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget builAllTap() {
    return Container(
      // height: 800,
      child: GridView.builder(
        // padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: (25 / 10),
          // crossAxisSpacing: 12,
          // mainAxisSpacing: 12,
        ),
        scrollDirection: Axis.vertical,
        itemCount: belongingList.length,
        itemBuilder: (context, index) {
          BelongingModel belonging = belongingList[index];
          return RowBelonginCard(belonging: belonging);
        },
      ),
    );
  }

  Widget _buildActionButton(String text) {
    return OutlinedButton(onPressed: () {}, child: Text(text));
  }
}
