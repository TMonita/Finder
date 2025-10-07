import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/belonging_model.dart';
import 'package:flutter_application_1/utils/app_textstyle.dart';

class RowBelonginCard extends StatelessWidget {
  final BelongingModel belonging;
  const RowBelonginCard({required this.belonging});
  Color _getStatusColor(String status) {
    switch (status.toLowerCase().trim()) {
      case 'pending':
        return Color(0xFF274C77).withOpacity(0.8);
      case 'in progress':
        return Color(0xFF6096BA).withOpacity(0.8);
      case 'founded':
      case 'discovered':
      case 'found':
        return Color(0xFFA3CEF1).withOpacity(0.8);
      default:
        return Colors.black26;
    }
  }

  @override
  Widget build(BuildContext context) {
    print(
      'Category: ${belonging.category}, Description: ${belonging.description}, Location: ${belonging.location}, Time: ${belonging.time}, Status: ${belonging.status}',
    );

    return Card(
      color: Colors.white,
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
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Row(
                        children: [
                          Text(
                            belonging.category,
                            style: AppTextStyle.h3.copyWith(
                              color: Color(0xFF6096BA),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          alignment: Alignment.topRight,
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            //color based on status
                            color: _getStatusColor(belonging.status),

                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            belonging.status,
                            style: AppTextStyle.bodyMedium.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(belonging.time, style: AppTextStyle.bodySmall),

                  const SizedBox(height: 5),

                  // Description
                  Text(
                    belonging.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.bodyLarge,
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
                          style: AppTextStyle.bodySmall,
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
