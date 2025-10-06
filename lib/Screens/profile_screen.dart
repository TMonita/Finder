import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/my_reports_detail.dart';
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
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),

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
    return Column(
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage('images/violet.jpg'),
            ),
            SizedBox(width: 20),
            Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text("Tho Violet", style: AppTextStyle.h2_3),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.edit, size: 15),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text("Phnom Penh", style: AppTextStyle.bodyLarge),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget buildBadges() {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Your Badges', style: AppTextStyle.h3),
              ),
              Row(
                children: [
                  Text('View All', style: AppTextStyle.body2ndMedium),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_forward_ios_rounded, size: 10),
                  ),
                ],
              ),
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
    );
  }

  Widget buildText() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('My Report', style: AppTextStyle.h3),
            Row(
              children: [
                Text('View All', style: AppTextStyle.body2ndMedium),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyReportsDetail(),
                      ),
                    );
                  },
                  icon: Icon(Icons.arrow_forward_ios_rounded, size: 10),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMyReport() {
    return Container(
      // height: 800,
      child: GridView.builder(
        // padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: (25 / 10),
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
    );
  }

  ///
}
