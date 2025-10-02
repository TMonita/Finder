import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/belonging_model.dart';
import 'package:flutter_application_1/utils/app_textstyle.dart';

// class BelongingCard extends StatelessWidget {
//   final BelongingModel belonging;
//   const BelongingCard({super.key, required this.belonging});

//   @override
//   Widget build(BuildContext context) {
//     return Container(height: 100, child: Card(child: Text(belonging.category)));
//   }
// }
class BelongingCard extends StatefulWidget {
  final BelongingModel belonging;
  const BelongingCard({super.key, required this.belonging});

  @override
  State<BelongingCard> createState() => _BelongingCardState();
}

class _BelongingCardState extends State<BelongingCard> {
  @override
  Widget build(BuildContext context) {
    print(
      'Category: ${widget.belonging.category}, Description: ${widget.belonging.description}, Location: ${widget.belonging.location}, Time: ${widget.belonging.time}',
    );
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        // color: Colors.grey,
      ),
      child: Column(
        children: [
          Stack(
            // height: 220,
            // // width: 180,
            // width: double.infinity,
            // child:
            children: [
              ClipRRect(
                borderRadius: BorderRadiusDirectional.circular(10.0),
                child: Image.asset(
                  widget.belonging.image,
                  fit: BoxFit.cover,
                  height: 220,
                ),
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: Color(0xFF6096BA).withOpacity(0.8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Pending',
                    style: AppTextStyle.bodyMedium.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Text('hey'),
          // Text(widget.belonging.category),
          // Text(widget.belonging.description),
          // Text(widget.belonging.category),
          // Text(widget.belonging.category),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.belonging.category,
                      style: AppTextStyle.bodyMedium.copyWith(
                        color: Color(0xFF6096BA),
                      ),
                    ),
                    Text(widget.belonging.time, style: AppTextStyle.bodyLight),
                  ],
                ),
                Text(
                  widget.belonging.description,
                  style: AppTextStyle.body2ndMedium,
                ),

                Opacity(
                  opacity: 0.8,
                  child: Row(
                    children: [
                      Icon(Icons.pin_drop_outlined, size: 12),
                      Text(
                        widget.belonging.location,
                        style: AppTextStyle.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
