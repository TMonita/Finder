import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/post_item_screen.dart';
import 'package:flutter_application_1/Screens/chat_screen.dart';
import 'package:flutter_application_1/Screens/home_screen.dart';
import 'package:flutter_application_1/Screens/profile_screen.dart';
import 'package:flutter_application_1/controllers/navigation_controller.dart';
import 'package:flutter_application_1/Screens/item_status.dart';
import 'package:flutter_application_1/widget/custom_bottom_navbar.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NavigationController navigationController = Get.put(
      NavigationController(),
    );

    return Scaffold(
      // backgroundColor: Color(0xFFF5F5F5),
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 200),
        child: Obx(
          () => IndexedStack(
            key: ValueKey(navigationController.currentIndex.value),
            index: navigationController.currentIndex.value,
            children: [
              Homescreen(),
              // Testpage(),
              // UpdateScreen(),
              UpdateScreen(),
              PostItemScreen(),
              ChatScreen(),
              ProfilScreen(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavbar(),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/Screens/chat_screen.dart';
// import 'package:flutter_application_1/Screens/home_screen.dart';
// import 'package:flutter_application_1/Screens/item_status.dart';
// import 'package:flutter_application_1/Screens/post_item_screen.dart';
// import 'package:flutter_application_1/Screens/profile_screen.dart';
// import 'package:flutter_application_1/widget/custom_bottom_navbar.dart';

// class MainScreen extends StatefulWidget {
//   const MainScreen({super.key});

//   @override
//   _MainScreenState createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen> {
//   int _currentIndex = 0;

//   late final List<Widget> _screens = [
//     Homescreen(),
//     UpdateScreen(),
//     PostItemScreen(),
//     ChatScreen(),
//     ProfilScreen(),
//   ];

//   void _onNavTap(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: IndexedStack(index: _currentIndex, children: _screens),
//       bottomNavigationBar: CustomBottomNavbar(
//         currentIndex: _currentIndex,
//         onTap: _onNavTap,
//       ),
//     );
//   }
// }
