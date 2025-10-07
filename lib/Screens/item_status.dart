import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/app_textstyle.dart';
import 'package:flutter_application_1/widget/confirm_reunited_dialog.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({super.key});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  String _status = "Awaiting for confirmation";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          children: [Appbar(), BodyContext()],
        ),
      ),
    );
  }

  Widget Appbar() {
    return Center(
      child: Text(
        'Item Status',
        style: AppTextStyle.h1.copyWith(color: const Color(0xFF274C77)),
      ),
    );
  }

  Widget BodyContext() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          // Item Card
          Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      "images/charger.png", // replace with your image
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "Electronic",
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "2 hours ago",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          "I found this charger at school campus...",
                          style: TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: const [
                            Icon(
                              Icons.location_on,
                              size: 14,
                              color: Colors.grey,
                            ),
                            SizedBox(width: 4),
                            Text(
                              "Limkokwing University",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 30),

          RadioListTile<String>(
            value: "Awaiting for confirmation",
            groupValue: _status,
            onChanged: (value) {
              setState(() {
                _status = value!;
              });
            },
            activeColor: Colors.blueGrey,
            title: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                "Awaiting for confirmation",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          RadioListTile<String>(
            value: "In chat with owner",
            groupValue: _status,
            onChanged: (value) {
              setState(() {
                _status = value!;
              });
            },
            activeColor: Colors.lightBlue,
            title: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.lightBlue,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                "In chat with owner",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          RadioListTile<String>(
            value: "Item has been found/reunited",
            groupValue: _status,
            onChanged: (value) {
              setState(() {
                _status = value!;
              });

              if (value == "Item has been found/reunited") {
                showDialog(
                  context: context,
                  builder: (context) => ConfirmReunitedDialog(),
                );
              }
              ;
            },
            activeColor: Colors.grey,
            title: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                "Item has been found/reunited",
                style: TextStyle(color: Colors.black54),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
