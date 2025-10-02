import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/navigation_controller.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';

class CustomBottomNavbar extends StatelessWidget {
  const CustomBottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    final NavigationController navigationController =
        Get.find<NavigationController>();

    return Obx(
      () => BottomNavigationBar(
        currentIndex: navigationController.currentIndex.value,
        onTap: (value) => navigationController.changeIndex(value),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        // currentIndex: currentIndex,
        // onTap: onTap,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        selectedItemColor: const Color(0xFF274C77),
        unselectedItemColor: const Color(0xFF274C77).withOpacity(0.5),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, size: 28),
            label: 'Home',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.update), label: 'Update'),
          BottomNavigationBarItem(
            icon: Icon(Icons.add, size: 36),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_outlined, size: 28),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// class CustomBottomNavbar extends StatelessWidget {
//   final int currentIndex;
//   final ValueChanged<int> onTap;

//   const CustomBottomNavbar({
//     Key? key,
//     required this.currentIndex,
//     required this.onTap,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       currentIndex: currentIndex,
//       onTap: onTap,
//       type: BottomNavigationBarType.fixed,
//       backgroundColor: Colors.white,
//       showSelectedLabels: true,
//       showUnselectedLabels: false,
//       selectedItemColor: const Color(0xFF274C77),
//       unselectedItemColor: const Color(0xFF274C77).withOpacity(0.5),
//       items: const [
//         BottomNavigationBarItem(
//           icon: Icon(Icons.home_outlined, size: 28),
//           label: 'Home',
//         ),
//         BottomNavigationBarItem(icon: Icon(Icons.update), label: 'Update'),
//         BottomNavigationBarItem(icon: Icon(Icons.add, size: 36), label: 'Add'),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.chat_bubble_outline),
//           label: 'Chat',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.person_outline_outlined, size: 28),
//           label: 'Profile',
//         ),
//       ],
//     );
//   }
// }
