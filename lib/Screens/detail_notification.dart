import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/found_item_detail_screen.dart';
import 'package:flutter_application_1/utils/app_textstyle.dart';
import 'package:flutter_application_1/widget/confirm_message_dialog.dart';

class DetailNotification extends StatefulWidget {
  const DetailNotification({super.key});

  @override
  State<DetailNotification> createState() => _DetailNotificationState();
}

class _DetailNotificationState extends State<DetailNotification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      ),
      body: SafeArea(
        child: ListView(
          children: [
            buildOwnertoFinderNotification(),
            buildFindertoOwnerNotification(),
          ],
        ),
      ),
    );
  }

  Widget buildOwnertoFinderNotification() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Someone wants to chat with you to reunite their lost belongings!",
                      style: AppTextStyle.h4,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              // Padding(
              //   padding: const EdgeInsets.only(left: 45),
              //   child: Row(
              //     children: [
              //       CircleAvatar(
              //         radius: 20,
              //         backgroundImage: AssetImage('images/violet.jpg'),
              //       ),
              //       SizedBox(width: 5),
              //       Row(children: [Text("Tho Violet", style: AppTextStyle.h2)]),
              //     ],
              //   ),
              // ),
              // SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ItemDetailpage()),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset('images/charger.png', height: 220),
                ),
              ),
              Text(
                'I found this charger at school campus...',
                style: AppTextStyle.bodyLarge,
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      shadowColor: Colors.black,
                      elevation: 4,
                      side: const BorderSide(color: Colors.black, width: 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                    ),
                    onPressed: () {},
                    child: const Text("Cancel"),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF274C77),
                      foregroundColor: Colors.white,
                      shadowColor: Colors.black,
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => ConfirmMessageDialog(),
                      );
                    },
                    child: const Text("Approve"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFindertoOwnerNotification() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  // Image.asset('images/electronic.png', height: 30),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "You received a message from a finder.",
                      style: AppTextStyle.h4,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),

              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ItemDetailpage()),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset('images/charger.png', height: 220),
                ),
              ),
              Text(
                'I found this charger at school campus...',
                style: AppTextStyle.bodyLarge,
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      shadowColor: Colors.black,
                      elevation: 4,
                      side: const BorderSide(color: Colors.black, width: 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                    ),
                    onPressed: () {},
                    child: const Text("Cancel"),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF274C77),
                      foregroundColor: Colors.white,
                      shadowColor: Colors.black,
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => ConfirmMessageDialog(),
                      );
                    },
                    child: const Text("Approve"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
