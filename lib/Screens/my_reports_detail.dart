import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/item_controller.dart';
import 'package:flutter_application_1/controllers/myreport_controller.dart';
import 'package:flutter_application_1/widget/row_belonging_card.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/model/allitems_model.dart';
import 'package:flutter_application_1/utils/app_textstyle.dart';

class MyReportsDetail extends StatefulWidget {
  const MyReportsDetail({super.key});

  @override
  State<MyReportsDetail> createState() => _MyReportsDetailState();
}

class _MyReportsDetailState extends State<MyReportsDetail>
    with SingleTickerProviderStateMixin {
  late TabController _reportTabController;
  final ItemsController itemsController = Get.put(ItemsController());
  final MyReportController myReportController = Get.put(MyReportController());

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
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF274C77)),
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
      body: RefreshIndicator(
        onRefresh: () async => await itemsController.fetchAllItems(),
        child: TabBarView(
          controller: _reportTabController,
          children: [
            ListView(children: [buildTab('All')]),
            ListView(children: [buildTab('Pending')]),
            ListView(children: [buildTab('In Progress')]),
            ListView(children: [buildTab('Founded')]),
          ],
        ),
      ),
    );
  }

  Widget buildTab(String status) {
    // return Obx(() {
    //   if (itemsController.isLoading.value) {
    //     return const Center(child: CircularProgressIndicator());
    //   }

    //   if (itemsController.itemList.isEmpty) {
    //     return const Center(child: Text('No reports found'));
    //   }

    //   // Filter reports by status
    //   List<AllItemsModel> filteredItems;
    //   if (status == 'All') {
    //     filteredItems = itemsController.itemList;
    //   } else {
    //     filteredItems =
    //         itemsController.itemList
    //             .where(
    //               (item) =>
    //                   item.status?.toLowerCase().trim() ==
    //                       status.toLowerCase().trim() ||
    //                   (status == 'Founded' &&
    //                       [
    //                         'found',
    //                         'founded',
    //                         'discovered',
    //                       ].contains(item.status?.toLowerCase().trim())),
    //             )
    //             .toList();
    //   }

    //   return GridView.builder(
    //     shrinkWrap: true,
    //     physics: const NeverScrollableScrollPhysics(),
    //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //       crossAxisCount: 1,
    //       childAspectRatio: (25 / 12),
    //     ),
    //     itemCount: filteredItems.length,
    //     itemBuilder: (context, index) {
    //       final item = filteredItems[index];

    //       return RowBelongingCard(belonging: item);
    //     },
    //   );
    // });
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

      return ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: myReportController.myReports.length,
        itemBuilder: (context, index) {
          final report = myReportController.myReports[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: RowBelongingCard(belonging: report),
          );
        },
      );
    });
  }
}
