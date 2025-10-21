// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/model/belonging_model.dart';
// import 'package:flutter_application_1/utils/app_textstyle.dart';

// class BelongingCard extends StatefulWidget {
//   final BelongingModel belonging;
//   const BelongingCard({super.key, required this.belonging});

//   @override
//   State<BelongingCard> createState() => _BelongingCardState();
// }

// class _BelongingCardState extends State<BelongingCard> {
//   Color _getStatusColor(String status) {
//     switch (status.toLowerCase().trim()) {
//       case 'pending':
//         return Color(0xFF274C77).withOpacity(0.8);
//       case 'in progress':
//         return Color(0xFF6096BA).withOpacity(0.8);
//       case 'founded':
//       case 'discovered':
//       case 'found':
//         return Color(0xFFA3CEF1).withOpacity(0.8);
//       default:
//         return Colors.black26;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     print(
//       'Category: ${widget.belonging.category}, Description: ${widget.belonging.description}, Location: ${widget.belonging.location}, Time: ${widget.belonging.time}, Status: ${widget.belonging.status}',
//     );
//     return Container(
//       width: MediaQuery.of(context).size.width / 2,
//       decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
//       child: Column(
//         children: [
//           Stack(
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadiusDirectional.circular(10.0),
//                 child: Image.asset(
//                   widget.belonging.image,
//                   fit: BoxFit.cover,
//                   height: 220,
//                 ),
//               ),
//               Positioned(
//                 right: 8,
//                 top: 8,
//                 child: Container(
//                   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                   decoration: BoxDecoration(
//                     color: _getStatusColor(widget.belonging.status),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Text(
//                     widget.belonging.status,
//                     style: AppTextStyle.bodyMedium.copyWith(
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),

//           Padding(
//             padding: const EdgeInsets.all(4.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       widget.belonging.category,
//                       style: AppTextStyle.body2ndLarge.copyWith(
//                         color: Color(0xFF6096BA),
//                       ),
//                     ),
//                     Text(widget.belonging.time, style: AppTextStyle.bodyLight),
//                   ],
//                 ),
//                 Text(
//                   widget.belonging.description,
//                   style: AppTextStyle.bodyLarge,
//                 ),

//                 Opacity(
//                   opacity: 0.8,
//                   child: Row(
//                     children: [
//                       Icon(Icons.pin_drop_outlined, size: 12),
//                       Text(
//                         widget.belonging.location,
//                         style: AppTextStyle.bodySmall,
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

//*new updated //
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/allitems_model.dart';
import 'package:flutter_application_1/utils/app_textstyle.dart';

class BelongingCard extends StatefulWidget {
  // final AllItemsModel belonging;
  final AllItemsModel belonging;
  const BelongingCard({super.key, required this.belonging});

  @override
  State<BelongingCard> createState() => _BelongingCardState();
}

class _BelongingCardState extends State<BelongingCard> {
  Color _getStatusColor(String status) {
    switch (status.toLowerCase().trim()) {
      case 'pending':
        return const Color(0xFF274C77).withOpacity(0.8);
      case 'in progress':
        return const Color(0xFF6096BA).withOpacity(0.8);
      case 'founded':
      case 'discovered':
      case 'found':
        return const Color(0xFFA3CEF1).withOpacity(0.8);
      default:
        return Colors.black26;
    }
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.belonging;

    print(
      'Category: ${item.categoryId}, Description: ${item.description}, '
      'Location: ${item.location}, Time: ${item.timeLostAt}, Status: ${item.type}',
    );

    return Container(
      width: MediaQuery.of(context).size.width / 2,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadiusDirectional.circular(10.0),
                child:
                    item.imageUrl != null && item.imageUrl!.isNotEmpty
                        ? Image.network(
                          item.imageUrl!,
                          fit: BoxFit.cover,
                          height: 220,
                          width: double.infinity,
                          errorBuilder:
                              (context, error, stackTrace) => const Icon(
                                Icons.image_not_supported,
                                size: 80,
                              ),
                        )
                        : Image.asset(
                          'images/charger.png',
                          fit: BoxFit.cover,
                          height: 220,
                          width: double.infinity,
                        ),
              ),
              if (item.type != null)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: _getStatusColor(item.type!),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      item.type!,
                      style: AppTextStyle.bodyMedium.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),

          // === Text Section ===
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Category ${item.categoryId ?? '-'}',
                        style: AppTextStyle.body2ndLarge.copyWith(
                          color: const Color(0xFF6096BA),
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      item.timeLostAt ?? '',
                      style: AppTextStyle.bodyLight,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                // ðŸ‘‡ Description: limit to 2 lines
                Text(
                  item.description ?? '',
                  style: AppTextStyle.bodyMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Opacity(
                  opacity: 0.8,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.pin_drop_outlined, size: 12),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          item.location ?? '',
                          style: AppTextStyle.bodySmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
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
