// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!

Future<void> setupFirebaseMessaging() async {
  final analytics = FirebaseAnalytics.instance;
  final messaging = FirebaseMessaging.instance;
  final user = FirebaseAuth.instance.currentUser;
  final uid = user?.uid ?? 'unknown';

  // ✅ foreground: เมื่อแอปเปิดอยู่และได้รับ noti
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    print("📩 Notification received: ${message.notification?.title}");
    FFAppState().firebaseMessage =
        "Notification received: ${message.notification?.title}";

    await analytics.logEvent(
      name: 'notification_received',
      parameters: {
        'notification_id': message.messageId ?? '',
        'title': message.notification?.title ?? '',
        'body': message.notification?.body ?? '',
        'sent_time': FieldValue.serverTimestamp(),
        'uid': uid,
      },
    );
  });

  // ✅ เมื่อผู้ใช้แตะ notification เปิดแอป
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
    print("📬 Notification opened by user: ${message.notification?.title}");
    FFAppState().firebaseMessage =
        "Notification opened by user: ${message.notification?.title}";

    await analytics.logEvent(
      name: 'notification_opened',
      parameters: {
        'notification_id': message.messageId ?? '',
        'title': message.notification?.title ?? '',
        'body': message.notification?.body ?? '',
        'uid': uid,
        'click_action': message.data['click_action'] ?? '',
      },
    );
  });
}
