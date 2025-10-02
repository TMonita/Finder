import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/chat_screen.dart';
import 'package:flutter_application_1/Screens/main_screen.dart';
import 'package:flutter_application_1/Screens/profile_screen.dart';

class LostItemDetailpage extends StatefulWidget {
  const LostItemDetailpage({super.key});

  @override
  State<LostItemDetailpage> createState() => _LostItemDetailpageState();
}

class _LostItemDetailpageState extends State<LostItemDetailpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: ListView(children: [buildAppbar(), buildDetail()])),
      bottomNavigationBar: buildBtn(),
    );
  }

  Widget buildAppbar() {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MainScreen()),
            );
          },
        ),
        const Expanded(
          child: Center(
            child: Text(
              'Lost Item',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),

        IconButton(
          onPressed: () {},
          icon: Icon(Icons.share, color: Color(0xFF274C77)),
        ),
      ],
    );
  }

  Widget buildDetail() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.asset(
              'images/charger.png',
              fit: BoxFit.cover,
              height: 320,
              width: double.infinity,
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Electronic",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  "I found this charger at school campus and now it still here with me",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.watch_later_outlined, size: 12),
                    SizedBox(width: 4),
                    Text(
                      '2 hours ago',
                      style: TextStyle(fontSize: 10, color: Colors.black87),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.pin_drop_outlined, size: 12),
                    SizedBox(width: 4),
                    Text(
                      'Limkokwing University',
                      style: TextStyle(fontSize: 10, color: Colors.black87),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfilScreen()),
                    );
                  },
                  child: Text(
                    'Add post by Tho Violet',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBtn() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min, // keeps buttons compact
        children: [
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.call, size: 30, color: Color(0xFF274C77)),
              label: Text(
                'Call',
                style: TextStyle(color: Color(0xFF274C77), fontSize: 20),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFE7ECEF),
              ),
            ),
          ),
          SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatScreen()),
                );
              },
              icon: Icon(
                Icons.messenger_outline_rounded,
                size: 30,
                color: Colors.white,
              ),
              label: Text(
                'Message in the app',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF274C77),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
