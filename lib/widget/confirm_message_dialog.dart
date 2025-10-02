import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/app_textstyle.dart';

class ConfirmMessageDialog extends StatelessWidget {
  const ConfirmMessageDialog({super.key});

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
                // backgroundColor: Colors.redAccent,
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
        decoration: BoxDecoration(
          // color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/chat.png', width: 72),
            SizedBox(height: 24),

            Text(
              'Now you can chat with finder directly to clarify your belonging',
              style: AppTextStyle.h3,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),

            Text(
              'The belongings now is in progress of to reunion with the owner',
              style: AppTextStyle.bodySmall,
            ),
            SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 45,

              child: ElevatedButton(
                onPressed: () {},
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
