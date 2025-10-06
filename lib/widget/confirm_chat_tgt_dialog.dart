import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/app_textstyle.dart';

class ConfirmChatTogetherDialog extends StatelessWidget {
  const ConfirmChatTogetherDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: Stack(
        children: [
          CartDialog(),
          Positioned(
            top: 0,
            right: 0,
            child: OutlinedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.close_rounded,
                size: 28,
                color: Color(0xFF274C77),
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide.none,
                padding: EdgeInsets.all(8),
                shape: CircleBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CartDialog extends StatelessWidget {
  const CartDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisSize: MainAxisSize.min,

          children: [
            Image.asset('images/chat_two_people.png', width: 72),
            SizedBox(height: 24),

            Text(
              'Are you in chat with finder?',
              style: AppTextStyle.h3,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),

            Text(
              'Click confirm if you are in chat',
              style: AppTextStyle.bodySmall,
            ),
            SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 45,

              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Confirm',
                  style: AppTextStyle.h3.copyWith(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF6096BA),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
