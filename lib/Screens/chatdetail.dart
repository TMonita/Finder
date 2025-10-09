import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/main_screen.dart';
import 'package:flutter_application_1/controllers/navigation_controller.dart';
import 'package:flutter_application_1/utils/app_colortheme.dart';
import 'package:flutter_application_1/utils/app_textstyle.dart';
import 'package:get/instance_manager.dart';
import 'package:intl/intl.dart';

class Chatdetail extends StatefulWidget {
  const Chatdetail({super.key});

  @override
  State<Chatdetail> createState() => _ChatdetailState();
}

class _ChatdetailState extends State<Chatdetail> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [
    {
      "sender": "other",
      "text":
          "Hi, I found a phone on the bus stop bench at RUPP today. It’s got a lock screen photo of a dog. Is that yours?",
      "time": "10:20",
    },
    {
      "sender": "user",
      "text":
          "Hi! Yes, that’s my phone! I lost it at the RUPP bus stop today. The dog photo is mine. Do you still have it?",
      "time": "10:20",
    },
    {"sender": "other", "text": "It’s still with me", "time": "10:25"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [buildAppbar(), buildChatDetail()]),
      ),
    );
  }

  Widget buildAppbar() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              // Get.find<NavigationController>().changeIndex(3);
              // Navigator.pop(context);

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => MainScreen()),
                (route) => false,
              );

              Get.find<NavigationController>().changeIndex(3);
            },

            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          ),
          const CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage('images/violet.jpg'),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Tho Violet', style: AppTextStyle.h3),
              Text(
                'Online',
                style: AppTextStyle.bodySmall.copyWith(
                  color: AppColors.secondary,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildChatDetail() {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                final isUser = msg['sender'] == 'user';
                return isUser
                    ? _buildSentMessage(msg['text']!, msg['time']!)
                    : _buildReceivedMessage(msg['text']!, msg['time']!);
              },
            ),
          ),

          SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: "Type here...",
                        hintStyle: AppTextStyle.hintText,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send, color: AppColors.secondary),
                    onPressed: () {
                      if (_controller.text.trim().isNotEmpty) {
                        setState(() {
                          _messages.add({
                            "sender": "user",
                            "text": _controller.text.trim(),
                            "time": DateFormat('HH:mm').format(DateTime.now()),
                          });
                          _controller.clear();
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Received message bubble
  Widget _buildReceivedMessage(String text, String time) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(12),
        constraints: const BoxConstraints(maxWidth: 280),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(text, style: AppTextStyle.bodyLarge),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(time, style: AppTextStyle.bodySmall),
            ),
          ],
        ),
      ),
    );
  }

  // Sent message bubble
  Widget _buildSentMessage(String text, String time) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(12),
        constraints: const BoxConstraints(maxWidth: 280),
        decoration: BoxDecoration(
          color: AppColors.tertiary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(text, style: AppTextStyle.bodyLarge),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(time, style: AppTextStyle.bodySmall),
            ),
          ],
        ),
      ),
    );
  }
}
