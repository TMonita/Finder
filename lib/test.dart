import 'package:flutter/material.dart';

class FoundLostPage extends StatefulWidget {
  const FoundLostPage({super.key});

  @override
  State<FoundLostPage> createState() => _FoundLostPageState();
}

class _FoundLostPageState extends State<FoundLostPage> {
  bool showFound = true; // toggle between found and lost

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Navigation (Found / Lost)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        showFound = true;
                      });
                    },
                    child: Text(
                      "Found",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: showFound ? Colors.black : Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        showFound = false;
                      });
                    },
                    child: Text(
                      "Lost",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: !showFound ? Colors.black : Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Body section changes
            Expanded(child: showFound ? _buildFoundPage() : _buildLostPage()),
          ],
        ),
      ),
    );
  }

  Widget _buildFoundPage() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _itemCard("I found this charger at school campus...", "Electronic"),
        _itemCard("I found a wallet near the cafeteria...", "Accessory"),
      ],
    );
  }

  Widget _buildLostPage() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _itemCard("I lost my student ID card near library...", "ID Card"),
        _itemCard("Lost a black backpack yesterday...", "Bag"),
      ],
    );
  }

  Widget _itemCard(String description, String category) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              category,
              style: const TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(description),
            const SizedBox(height: 5),
            Row(
              children: const [
                Icon(Icons.location_on, size: 16, color: Colors.grey),
                SizedBox(width: 5),
                Text(
                  "Limkokwing University",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
