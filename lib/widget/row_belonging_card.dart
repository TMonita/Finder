import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/belonging_model.dart';

class RowBelonginCard extends StatelessWidget {
  //  final String bImages;
  // final String bCategory;
  // final String bDescription;
  // final String bLocation;
  // final String bTime;
  // final double? bSize;

  // const BelongingCard({
  //   super.key,
  //   required this.bImages,
  //   required this.bCategory,
  //   required this.bDescription,
  //   required this.bLocation,
  //   required this.bTime,
  //   this.bSize,
  // });
  final BelongingModel belonging;
  const RowBelonginCard({required this.belonging});

  @override
  Widget build(BuildContext context) {
    print(
      'Category: ${belonging.category}, Description: ${belonging.description}, Location: ${belonging.location}, Time: ${belonging.time}',
    );
    return Card(
      color: Color(0xFFD9D9D9),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                belonging.image,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category + time
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        belonging.category,
                        style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        belonging.time,
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),

                  // Description
                  Text(
                    belonging.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 6),

                  // Location
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 16,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          belonging.location,
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 13,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
