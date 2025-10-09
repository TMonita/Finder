import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/chatdetail.dart';
import 'package:flutter_application_1/utils/app_textstyle.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),

          children: [
            buildAppbar(),
            SizedBox(height: 20),
            buildChatState(),
            SizedBox(height: 10),
            buildSecondChatState(),
            SizedBox(height: 10),
            buildThirdChatState(),
          ],
        ),
      ),
    );
  }

  Widget buildAppbar() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Chats',
            style: AppTextStyle.h1.copyWith(color: Color(0xFF274C77)),
          ),
          Icon(Icons.search_rounded, size: 30, color: Color(0xFF274C77)),
        ],
      ),
    );
  }

  Widget buildChatState() {
    return GestureDetector(
      onTap:
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Chatdetail()),
          ),
      child: Container(
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage('images/charger.png'),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Tho Violet',
                        // style: TextStyle(fontWeight: FontWeight.bold),
                        style: AppTextStyle.h3,
                      ),
                      Spacer(),
                      Text('10:20PM', style: AppTextStyle.bodySmall),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Hi, I found a phone on the bus stop bench at...',
                    style: AppTextStyle.body3rdLarge,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSecondChatState() {
    return Container(
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage('images/charger.png'),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Tep Veha', style: AppTextStyle.h3),
                    Spacer(),
                    Text('10:20PM', style: AppTextStyle.bodySmall),
                  ],
                ),
                SizedBox(height: 10),

                Text(
                  'Hey, I came across a watch in the paking lot...',
                  style: AppTextStyle.body3rdLarge,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildThirdChatState() {
    return Container(
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage('images/charger.png'),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Vesot Sela', style: AppTextStyle.h3),
                    Spacer(),
                    Text('13:30PM', style: AppTextStyle.bodySmall),
                  ],
                ),
                SizedBox(height: 10),

                Text(
                  'Hey Vy, I saw your post about a phone found...',
                  style: AppTextStyle.body3rdLarge,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///
}
