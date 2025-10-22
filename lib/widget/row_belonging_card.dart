import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/allitems_model.dart';
import 'package:flutter_application_1/utils/app_textstyle.dart';
import 'package:timeago/timeago.dart' as timeago;

class RowBelongingCard extends StatefulWidget {
  final bool showButtons;
  final AllItemsModel belonging;

  RowBelongingCard({
    super.key,
    required this.belonging,
    this.showButtons = true,
  });

  @override
  State<RowBelongingCard> createState() => _RowBelongingCardState();
}

class _RowBelongingCardState extends State<RowBelongingCard> {
  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase().trim()) {
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
    String formattedTime = '';
    if (item.timeLostAt != null && item.timeLostAt!.isNotEmpty) {
      try {
        final dateTime = DateTime.parse(item.timeLostAt!);
        formattedTime = timeago.format(dateTime);
      } catch (e) {
        formattedTime = item.timeLostAt!;
      }
    }

    print(
      'Category: ${item.categoryName}, Description: ${item.description}, '
      'Location: ${item.location}, Time: ${item.timeLostAt}, Status: ${item.status}',
    );

    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child:
                      item.imageUrl != null && item.imageUrl!.isNotEmpty
                          ? Image.network(
                            item.imageUrl!,
                            fit: BoxFit.cover,
                            height: 100,
                            width: 100,
                            errorBuilder:
                                (context, error, stackTrace) => const Icon(
                                  Icons.image_not_supported,
                                  size: 80,
                                ),
                          )
                          : Image.asset(
                            'images/charger.png',
                            fit: BoxFit.cover,
                            height: 100,
                            width: double.infinity,
                          ),
                ),

                const SizedBox(width: 20),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Row(
                            children: [
                              Text(
                                item.categoryName ?? 'Unknown',
                                style: AppTextStyle.h3.copyWith(
                                  color: const Color(0xFF6096BA),
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: _getStatusColor(item.status),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                item.status ?? 'N/A',
                                style: AppTextStyle.bodyMedium.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      Text(formattedTime, style: AppTextStyle.bodySmall),

                      const SizedBox(height: 5),

                      Text(
                        item.description ?? 'No description available.',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.bodyLarge,
                      ),

                      const SizedBox(height: 6),

                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 16,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              item.location ?? 'Unknown location',
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
            SizedBox(height: 5),
            if (widget.showButtons)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        shadowColor: Colors.black,
                        elevation: 4,
                        side: const BorderSide(color: Colors.black54, width: 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                      ),
                      onPressed: () {},
                      child: Text("Cancel", style: AppTextStyle.bodyMedium),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF274C77),
                        foregroundColor: Colors.white,
                        shadowColor: Colors.black,
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                      ),
                      onPressed: () {},
                      child: Text("Confirm", style: AppTextStyle.bodyMedium),
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
