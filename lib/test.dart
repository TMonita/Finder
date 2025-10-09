import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Order Tracking',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const OrderTrackingPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// API Service
class TrackingService {
  static const String baseUrl = 'https://your-api.com/api';

  // Fetch tracking information
  static Future<OrderTrackingData> fetchTrackingInfo(String orderId) async {
    // API call implementation
    await Future.delayed(const Duration(seconds: 1));
    return _getMockData(orderId);
  }

  // User confirms an action (delivery received, issue reported, etc.)
  static Future<bool> confirmAction(
    String orderId,
    String actionType, {
    String? notes,
    String? imageUrl,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/orders/$orderId/confirm'),
        headers: {
          'Authorization': 'Bearer YOUR_TOKEN',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'action_type':
              actionType, // 'delivery_received', 'report_issue', etc.
          'timestamp': DateTime.now().toIso8601String(),
          'notes': notes,
          'image_url': imageUrl,
        }),
      );

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  // Mock data for demo
  static OrderTrackingData _getMockData(String orderId) {
    return OrderTrackingData(
      orderNumber: orderId,
      status: 'Out for Delivery',
      estimatedDelivery: 'Today',
      itemCount: 3,
      trackingSteps: [
        TrackingStep(
          title: 'Order Placed',
          description: 'We have received your order',
          timestamp: DateTime(2025, 10, 6, 10, 30),
          isCompleted: true,
          requiresConfirmation: false,
        ),
        TrackingStep(
          title: 'Order Confirmed',
          description: 'Your order has been confirmed',
          timestamp: DateTime(2025, 10, 6, 11, 0),
          isCompleted: true,
          requiresConfirmation: false,
        ),
        TrackingStep(
          title: 'Shipped',
          description: 'Your order is on the way',
          timestamp: DateTime(2025, 10, 8, 8, 15),
          isCompleted: true,
          requiresConfirmation: false,
        ),
        TrackingStep(
          title: 'Out for Delivery',
          description: 'Your order will arrive soon',
          timestamp: DateTime(2025, 10, 8, 14, 30),
          isCompleted: true,
          requiresConfirmation: false,
        ),
        TrackingStep(
          title: 'Delivered',
          description: 'Confirm that you received your order',
          timestamp: null,
          isCompleted: false,
          requiresConfirmation: true, // User needs to confirm
          actionType: 'delivery_received',
        ),
      ],
      address: DeliveryAddress(
        name: 'John Doe',
        street: '123 Main Street, Apt 4B',
        city: 'New York',
        state: 'NY',
        zip: '10001',
        country: 'United States',
      ),
    );
  }
}

// Data Models
class OrderTrackingData {
  final String orderNumber;
  final String status;
  final String estimatedDelivery;
  final int itemCount;
  final List<TrackingStep> trackingSteps;
  final DeliveryAddress address;

  OrderTrackingData({
    required this.orderNumber,
    required this.status,
    required this.estimatedDelivery,
    required this.itemCount,
    required this.trackingSteps,
    required this.address,
  });
}

class TrackingStep {
  final String title;
  final String description;
  final DateTime? timestamp;
  final bool isCompleted;
  final bool requiresConfirmation;
  final String? actionType;

  TrackingStep({
    required this.title,
    required this.description,
    this.timestamp,
    required this.isCompleted,
    this.requiresConfirmation = false,
    this.actionType,
  });

  String get formattedDate {
    if (timestamp == null) return '';
    return '${_getMonthName(timestamp!.month)} ${timestamp!.day}, ${timestamp!.year} - ${_formatTime(timestamp!)}';
  }

  String _getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }

  String _formatTime(DateTime time) {
    final hour =
        time.hour > 12 ? time.hour - 12 : (time.hour == 0 ? 12 : time.hour);
    final period = time.hour >= 12 ? 'PM' : 'AM';
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute $period';
  }
}

class DeliveryAddress {
  final String name;
  final String street;
  final String city;
  final String state;
  final String zip;
  final String country;

  DeliveryAddress({
    required this.name,
    required this.street,
    required this.city,
    required this.state,
    required this.zip,
    required this.country,
  });

  @override
  String toString() {
    return '$name\n$street\n$city, $state $zip\n$country';
  }
}

class OrderTrackingPage extends StatefulWidget {
  const OrderTrackingPage({Key? key}) : super(key: key);

  @override
  State<OrderTrackingPage> createState() => _OrderTrackingPageState();
}

class _OrderTrackingPageState extends State<OrderTrackingPage> {
  late Future<OrderTrackingData> trackingData;
  final String orderId = "ORD-2024-10089";
  bool isSubmitting = false;

  @override
  void initState() {
    super.initState();
    trackingData = TrackingService.fetchTrackingInfo(orderId);
  }

  void _refreshTracking() {
    setState(() {
      trackingData = TrackingService.fetchTrackingInfo(orderId);
    });
  }

  // Show confirmation dialog for delivery
  Future<void> _showConfirmDeliveryDialog() async {
    final TextEditingController notesController = TextEditingController();

    final confirmed = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Confirm Delivery'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Have you received your order in good condition?'),
                const SizedBox(height: 16),
                TextField(
                  controller: notesController,
                  decoration: const InputDecoration(
                    labelText: 'Additional notes (optional)',
                    border: OutlineInputBorder(),
                    hintText: 'e.g., Left at front door',
                  ),
                  maxLines: 3,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Confirm Delivery'),
              ),
            ],
          ),
    );

    if (confirmed == true) {
      await _handleConfirmAction(
        'delivery_received',
        notes: notesController.text,
      );
    }
  }

  // Show dialog to report an issue
  Future<void> _showReportIssueDialog() async {
    final TextEditingController issueController = TextEditingController();
    String? selectedIssue;

    final issues = [
      'Package damaged',
      'Item missing',
      'Wrong item received',
      'Package not received',
      'Other',
    ];

    final reported = await showDialog<bool>(
      context: context,
      builder:
          (context) => StatefulBuilder(
            builder:
                (context, setDialogState) => AlertDialog(
                  title: const Text('Report an Issue'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('What\'s the problem?'),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Select issue',
                        ),
                        items:
                            issues.map((issue) {
                              return DropdownMenuItem(
                                value: issue,
                                child: Text(issue),
                              );
                            }).toList(),
                        onChanged: (value) {
                          setDialogState(() {
                            selectedIssue = value;
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: issueController,
                        decoration: const InputDecoration(
                          labelText: 'Describe the issue',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 4,
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed:
                          selectedIssue != null
                              ? () => Navigator.pop(context, true)
                              : null,
                      child: const Text('Submit Report'),
                    ),
                  ],
                ),
          ),
    );

    if (reported == true && selectedIssue != null) {
      await _handleConfirmAction(
        'report_issue',
        notes: '$selectedIssue: ${issueController.text}',
      );
    }
  }

  // Handle action confirmation
  Future<void> _handleConfirmAction(String actionType, {String? notes}) async {
    setState(() {
      isSubmitting = true;
    });

    final success = await TrackingService.confirmAction(
      orderId,
      actionType,
      notes: notes,
    );

    setState(() {
      isSubmitting = false;
    });

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Confirmation submitted successfully!'),
          backgroundColor: Colors.green,
        ),
      );
      _refreshTracking();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to submit. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Track Order'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshTracking,
          ),
        ],
      ),
      body: FutureBuilder<OrderTrackingData>(
        future: trackingData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text('Error: ${snapshot.error}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _refreshTracking,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (!snapshot.hasData) {
            return const Center(child: Text('No tracking data available'));
          }

          final data = snapshot.data!;
          final currentStep = data.trackingSteps.lastIndexWhere(
            (step) => step.isCompleted,
          );

          // Check if next step requires user confirmation
          final nextStep =
              currentStep + 1 < data.trackingSteps.length
                  ? data.trackingSteps[currentStep + 1]
                  : null;

          return Stack(
            children: [
              RefreshIndicator(
                onRefresh: () async {
                  _refreshTracking();
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Order Summary Card
                      Container(
                        color: Colors.white,
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Order #${data.orderNumber}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${data.itemCount} Items',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.orange[50],
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    data.status,
                                    style: TextStyle(
                                      color: Colors.orange[700],
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Icon(
                                  Icons.local_shipping,
                                  color: Colors.grey[600],
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Estimated Delivery: ${data.estimatedDelivery}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[800],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Action Required Banner
                      if (nextStep?.requiresConfirmation == true)
                        Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.all(16),
                          color: Colors.blue[50],
                          child: Row(
                            children: [
                              Icon(
                                Icons.notification_important,
                                color: Colors.blue[700],
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Action Required',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue[900],
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Please confirm delivery when you receive your order',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.blue[800],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                      // Tracking Timeline
                      Container(
                        color: Colors.white,
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Tracking Details',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 24),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: data.trackingSteps.length,
                              itemBuilder: (context, index) {
                                return TrackingStepWidget(
                                  step: data.trackingSteps[index],
                                  isLast:
                                      index == data.trackingSteps.length - 1,
                                  isActive: index == currentStep,
                                  onConfirm:
                                      data
                                              .trackingSteps[index]
                                              .requiresConfirmation
                                          ? _showConfirmDeliveryDialog
                                          : null,
                                );
                              },
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Delivery Address
                      Container(
                        color: Colors.white,
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Delivery Address',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              data.address.toString(),
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Action Buttons
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            if (nextStep?.requiresConfirmation == true)
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  onPressed: _showConfirmDeliveryDialog,
                                  icon: const Icon(Icons.check_circle),
                                  label: const Text('Confirm Delivery'),
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                    ),
                                    backgroundColor: Colors.green,
                                    foregroundColor: Colors.white,
                                  ),
                                ),
                              ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton.icon(
                                onPressed: _showReportIssueDialog,
                                icon: const Icon(Icons.report_problem),
                                label: const Text('Report an Issue'),
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  side: const BorderSide(color: Colors.red),
                                  foregroundColor: Colors.red,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.support_agent),
                                label: const Text('Contact Support'),
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  side: BorderSide(color: Colors.blue[700]!),
                                  foregroundColor: Colors.blue[700],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (isSubmitting)
                Container(
                  color: Colors.black26,
                  child: const Center(child: CircularProgressIndicator()),
                ),
            ],
          );
        },
      ),
    );
  }
}

class TrackingStepWidget extends StatelessWidget {
  final TrackingStep step;
  final bool isLast;
  final bool isActive;
  final VoidCallback? onConfirm;

  const TrackingStepWidget({
    Key? key,
    required this.step,
    required this.isLast,
    required this.isActive,
    this.onConfirm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline indicator
          Column(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      step.isCompleted
                          ? Colors.green
                          : isActive
                          ? Colors.blue
                          : Colors.grey[300],
                  border: Border.all(
                    color:
                        step.isCompleted
                            ? Colors.green
                            : isActive
                            ? Colors.blue
                            : Colors.grey[300]!,
                    width: 2,
                  ),
                ),
                child:
                    step.isCompleted
                        ? const Icon(Icons.check, color: Colors.white, size: 16)
                        : null,
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: step.isCompleted ? Colors.green : Colors.grey[300],
                    margin: const EdgeInsets.symmetric(vertical: 4),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color:
                          step.isCompleted || isActive
                              ? Colors.black87
                              : Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    step.description,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  if (step.formattedDate.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      step.formattedDate,
                      style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                    ),
                  ],
                  if (step.requiresConfirmation &&
                      !step.isCompleted &&
                      onConfirm != null) ...[
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: onConfirm,
                      icon: const Icon(Icons.check, size: 18),
                      label: const Text('Confirm'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
