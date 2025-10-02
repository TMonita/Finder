import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/belonging_model.dart';
import 'package:flutter_application_1/utils/app_textstyle.dart';
import 'package:flutter_application_1/widget/row_belonging_card.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({super.key});

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(height: 20),
            buildProfile(),
            buildBadges(),
            buildText(),
            buildMyReport(),
          ],
        ),
      ),
    );
  }

  Widget buildProfile() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('images/violet.jpg'),
              ),
              SizedBox(width: 20),
              Column(children: [Text("Tho Violet", style: AppTextStyle.h2)]),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildBadges() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Your Badges', style: AppTextStyle.h3),
                Text('View All'),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('images/violet.jpg'),
                    ),
                    Text(
                      'Community\nHelper',
                      style: TextStyle(fontSize: 10),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('images/violet.jpg'),
                    ),
                    Text(
                      'Reunion\nHero',
                      style: TextStyle(fontSize: 10),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('images/violet.jpg'),
                    ),
                    Text(
                      'Recovery\nChampion',
                      style: TextStyle(fontSize: 10),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget buildMyReport() {
  //   return Container(
  //     child: Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: Column(
  //         children: [
  //           PostItem(
  //             bImages: 'images/charger.png',

  //             bCategory: 'Electronic',
  //             bDescription: 'I found this charger at school campus...',
  //             bLocation: 'Limkokwing University',
  //             bTime: '2 hours ago',
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget buildText() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text('My Report'), Text('View All')],
        ),
      ),
    );
  }

  Widget buildMyReport() {
    return Container(
      // height: 800,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          // padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: (30 / 10),
            // crossAxisSpacing: 12,
            // mainAxisSpacing: 12,
          ),
          scrollDirection: Axis.vertical,
          itemCount: belongingList.length,
          itemBuilder: (context, index) {
            BelongingModel belonging = belongingList[index];
            return RowBelonginCard(belonging: belonging);
          },
        ),
      ),
    );
  }

  ///
}
