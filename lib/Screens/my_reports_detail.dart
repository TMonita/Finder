import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/belonging_model.dart';
import 'package:flutter_application_1/utils/app_textstyle.dart';
import 'package:flutter_application_1/widget/all_reports_belonging.dart';

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
          labelColor: Color(0xFF274C77),
          unselectedLabelColor: Colors.black,
          indicatorColor: Color(0xFF274C77),
          tabs: const [
            Tab(text: "All"),
            Tab(text: "Pending"),
            Tab(text: "In Progress"),
            Tab(text: "Founded"),
          ],
          labelStyle: AppTextStyle.bodyLarge,
        ),
      ),
      body: TabBarView(
        controller: _reportTabController,
        children: [
          ListView(children: [buildTab(belongingList)]),
          ListView(
            children: [
              buildTab(
                belongingList
                    .where(
                      (item) => item.status.toLowerCase().trim() == 'pending',
                    )
                    .toList(),
              ),
            ],
          ),
          ListView(
            children: [
              buildTab(
                belongingList
                    .where(
                      (item) =>
                          item.status.toLowerCase().trim() == 'in progress',
                    )
                    .toList(),
              ),
            ],
          ),
          ListView(
            children: [
              buildTab(
                belongingList
                    .where(
                      (item) =>
                          item.status.toLowerCase().trim() == 'founded' ||
                          item.status.toLowerCase().trim() == 'found' ||
                          item.status.toLowerCase().trim() == 'discovered',
                    )
                    .toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildTab(List<BelongingModel> items) {
    return Column(
      children: [
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: (25 / 13),
          ),
          scrollDirection: Axis.vertical,
          itemCount: items.length,
          itemBuilder: (context, index) {
            BelongingModel belonging = items[index];
            return AllReportBelonginCard(belonging: belonging);
          },
        ),
      ],
    );
  }

  // Widget _buildActionButton(String text) {
  //   return OutlinedButton(onPressed: () {}, child: Text(text));
  // }
}
