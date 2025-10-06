import 'package:flutter/material.dart';

class ItemCardScreen extends StatelessWidget {
  const ItemCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 👇 Example data (you can replace with your actual data)
    final items = [
      {
        "image": "images/charger.png",
        "status": "Pending",
        "category": "Electronic",
        "description": "I found this charger at school campus...",
        "location": "Limkokwing University",
        "time": "2 hours ago",
      },
      {
        "image": "images/charger2.jpg",
        "status": "In Progress",
        "category": "Electronic",
        "description": "I found this charger at school campus...",
        "location": "Limkokwing University",
        "time": "2 hours ago",
      },
      {
        "image": "images/charger3.jpg",
        "status": "Discovered",
        "category": "Electronic",
        "description": "I found this charger at school campus...",
        "location": "Limkokwing University",
        "time": "2 hours ago",
      },
      {
        "image": "images/charger4.jpg",
        "status": "Pending",
        "category": "Electronic",
        "description": "I found this charger at the library...",
        "location": "Limkokwing University",
        "time": "4 hours ago",
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Item Status",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
          itemCount: items.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (context, index) {
            final item = items[index];
            return ItemCard(
              image: item["image"]!,
              status: item["status"]!,
              category: item["category"]!,
              description: item["description"]!,
              location: item["location"]!,
              time: item["time"]!,
            );
          },
        ),
      ),
    );
  }
}

class ItemCard extends StatelessWidget {
  final String image;
  final String status;
  final String category;
  final String description;
  final String location;
  final String time;

  const ItemCard({
    super.key,
    required this.image,
    required this.status,
    required this.category,
    required this.description,
    required this.location,
    required this.time,
  });

  Color getStatusColor() {
    switch (status.toLowerCase()) {
      case "pending":
        return const Color(0xFF5A84A8);
      case "in progress":
        return const Color(0xFF4BA3E3);
      case "discovered":
        return const Color(0xFF9EC9E3);
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color badgeColor = getStatusColor();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image + Status label
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: Image.asset(
                  image,
                  height: 140,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: badgeColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    status,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Details section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      category,
                      style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      time,
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.black87, fontSize: 13),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.grey, size: 16),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        location,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
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
