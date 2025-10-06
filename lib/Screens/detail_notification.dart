import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/app_textstyle.dart';

class DetailNotification extends StatefulWidget {
  const DetailNotification({super.key});

  @override
  State<DetailNotification> createState() => _DetailNotificationState();
}

class _DetailNotificationState extends State<DetailNotification>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Notification"),
      //   bottom: TabBar(
      //     controller: _tabController,
      //     isScrollable: true,
      //     tabs: const [
      //       Tab(text: "All"),
      //       Tab(text: "Lost Items"),
      //       Tab(text: "Found Items"),
      //       Tab(text: "Status Updates"),
      //     ],
      //   ),
      // ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        titleSpacing: 0,
        title: Text(
          'Notification',
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
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(text: "All"),
            Tab(text: "Lost Items"),
            Tab(text: "Found Items"),
            Tab(text: "Status Updates"),
          ],
          labelStyle: AppTextStyle.bodyLarge,
        ),
      ),

      body: TabBarView(
        controller: _tabController,
        children: [
          buildAllTab(),
          Center(child: Text("Lost Items here", style: AppTextStyle.h2)),
          Center(child: Text("Found Items here")),
          Center(child: Text("Status Updates here")),
        ],
      ),
    );
  }

  Widget buildAllTab() {
    return ListView(
      padding: const EdgeInsets.all(12),

      children: [
        _buildCard(
          icon: Icons.account_balance_wallet,
          title: "Wallet Found",
          status: "Status",
          statusColor: Colors.green,
          subtitle: "Location: Building A, Floor 2\nTime: 2 hours ago",
          actions: [
            _buildActionButton("View Details"),
            _buildActionButton("Mark Claimed"),
          ],
        ),
        const SizedBox(height: 12),
        _buildCard(
          icon: Icons.smartphone,
          title: "Phone Lost",
          status: "Pending",
          statusColor: Colors.orange,
          subtitle: "Last seen: Cafeteria\nTime: 1 day ago",
          actions: [_buildActionButton("View Details")],
        ),
        const SizedBox(height: 12),
        _buildCard(
          icon: Icons.access_time,
          title: "Reminder",
          subtitle:
              "You reported a lost item 7 days ago.\nCheck if it has been found.",
          actions: [_buildActionButton("Check Items")],
        ),
      ],
    );
  }

  Widget _buildCard({
    required IconData icon,
    required String title,
    String? status,
    Color? statusColor,
    required String subtitle,
    required List<Widget> actions,
  }) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 32),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (status != null)
                        Text(
                          status,
                          style: TextStyle(
                            color: statusColor ?? Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(subtitle, style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 8),
            Row(
              children:
                  actions
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: e,
                        ),
                      )
                      .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(String text) {
    return OutlinedButton(onPressed: () {}, child: Text(text));
  }
}
