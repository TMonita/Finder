import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/belonging_model.dart';

// class BelongingCard extends StatelessWidget {
//   final BelongingModel belonging;
//   const BelongingCard({super.key, required this.belonging});

//   @override
//   Widget build(BuildContext context) {
//     return Container(height: 100, child: Card(child: Text(belonging.category)));
//   }
// }
class BelongingCardLostPage extends StatefulWidget {
  final BelongingModel belonging;
  const BelongingCardLostPage({super.key, required this.belonging});

  @override
  State<BelongingCardLostPage> createState() => _BelongingCardState();
}

class _BelongingCardState extends State<BelongingCardLostPage> {
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
          SizedBox(
            height: 220,
            // width: 180,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadiusDirectional.circular(10.0),
              child: Image.asset(widget.belonging.image, fit: BoxFit.cover),
            ),
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
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.belonging.time,
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.black87,
                      ),
                      // maxLines: 3,
                      // overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                Text(
                  widget.belonging.description,
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                  // maxLines: 3,
                  // overflow: TextOverflow.ellipsis,
                ),

                Row(
                  children: [
                    Icon(Icons.pin_drop_outlined, size: 12),
                    Text(
                      widget.belonging.location,
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.black87,
                      ),
                      // maxLines: 3,
                      // overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
