// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// @pragma('vm:entry-point')
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await NotificationService.instance.setupFlutterNotifications();
//   await NotificationService.instance.showNotification(message);
// }

// class NotificationService {
//   NotificationService._();
//   static final NotificationService instance = NotificationService._();

//   final _messaging = FirebaseMessaging.instance;
//   final _localNotifications = FlutterLocalNotificationsPlugin();
//   bool _isFlutterLocalNotificationsInitialized = false;

//   Future<void> initialize() async {
//     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

//     await _requestPermission();
//     await _setupMessageHandlers();
//     final token = await _messaging.getToken();
//     print('FCM Token: $token');
//   }

//   Future<void> _requestPermission() async {
//     final setting = await _messaging.requestPermission(
//       alert: true,
//       badge: true,
//       sound: true,
//       provisional: false,
//       announcement: false,
//       carPlay: false,
//       criticalAlert: false,
//     );
//     print('Permission status: ${setting.authorizationStatus}');
//   }

//   Future<void> setupFlutterNotifications() async {
//     if (_isFlutterLocalNotificationsInitialized) {
//       return;
//     }
//     const channel = AndroidNotificationChannel(
//       'high_importance_channel',
//       'High Importance Notifications',
//       description: 'This channel is used for important notifications',
//       importance: Importance.high,
//     );

//     await _localNotifications
//         .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin
//         >()
//         ?.createNotificationChannel(channel);

//     const initializationSettingsAndriod = AndroidInitializationSettings(
//       '@mipmap/ic_laucher',
//     );

//     final initializationSettingsDrawin = DarwinInitializationSettings(
//       onDidReceiveLocalNotification: (id, title, body, payload) async {},
//     );

//     final initailizationSettings = InitializationSettings(
//       android: initializationSettingsAndriod,
//       iOS: initializationSettingsDrawin,
//     );

//     await _localNotifications.initialize(
//       initailizationSettings,
//       onDidReceiveBackgroundNotificationResponse: (details) {},
//     );
//     _isFlutterLocalNotificationsInitialized = true;
//   }

//   Future<void> showNotification(RemoteMessage message) async {
//     RemoteNotification? notification = message.notification;
//     AndroidNotification? andriod = message.notification?.android;
//     if (notification != null && andriod != null) {
//       await _localNotifications.show(
//         notification.hashCode,
//         notification.title,
//         notification.body,
//         NotificationDetails(
//           android: AndroidNotificationDetails(
//             'high_importance_channle',
//             'Hign Importance Notifications',
//             channelDescription:
//                 'This channel is used for importanct notifications.',
//             importance: Importance.high,
//             priority: Priority.high,
//             icon: '@mipmap/ic_launcher',
//           ),
//           iOS: const DarwinNotificationDetails(
//             presentAlert: true,
//             presentBanner: true,
//             presentSound: true,
//           ),
//         ),
//         payload: message.data.toString(),
//       );
//     }
//   }

//   Future<void> _setupMessageHandlers() async {
//     FirebaseMessaging.onMessage.listen((message) {
//       showNotification(message);
//     });
//     FirebaseMessaging.onMessageOpenedApp.listen(_handleBackgroundMessage);
//   }

//   void _handleBackgroundMessage(RemoteMessage message) {
//     if (message.data['type'] == 'chat') {}
//   }
// }
