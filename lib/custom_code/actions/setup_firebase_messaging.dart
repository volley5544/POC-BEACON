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

// เก็บ ID ของ noti ที่เคย log แล้ว (ในหน่วยความจำ)
final Set<String> _loggedNotificationIds = {};

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
    final notificationId = message.messageId ?? '';

    // ✅ ตรวจสอบว่า messageId มีค่าไหม
    if (notificationId.isEmpty) {
      print("⚠️ messageId ว่าง — ข้ามการ log");
      return;
    }
    // ✅ ตรวจสอบว่าเคย log event นี้ไปแล้วหรือยัง
    if (_loggedNotificationIds.contains(notificationId)) {
      print("⚠️ ข้ามการ log ซ้ำของ notification_id: ${notificationId}");
      return; // ไม่ต้อง log ซ้ำ
    }

    // ✅ เพิ่มเข้าเซ็ต เพื่อกันไม่ให้ log ซ้ำใน session เดียวกัน
    _loggedNotificationIds.add(notificationId);

    // ✅ ดึง log ล่าสุดของผู้ใช้
    final latestLog = await getLatestProximityLog(uid);
    // final logId = latestLog['log_id'] ?? '';
    // final eventId = latestLog['event_id'] ?? 0;
    // final boothId = latestLog['booth_id'] ?? 0;

    final logId = message.data['log_id'] ?? latestLog['log_id'] ?? '';
    final eventId = message.data['event_id'] ?? latestLog['event_id'] ?? '';
    final boothId = message.data['booth_id'] ?? latestLog['booth_id'] ?? '';
    final sentFromServerTime = message.data['sent_from_server_time'] ?? '';

    print("🧩 xxxx log_id: $logId");
    print("🎟️ xxxx event_id: $eventId");
    print("🏕️ xxxx booth_id: $boothId");
    print("⏱️xxxx sent_from_server_time: $sentFromServerTime");

    await FirebaseAnalytics.instance.logEvent(
      name: 'notification_received_beacon',
      parameters: {
        'notification_id': message.messageId ?? '',
        'title': message.notification?.title ?? '',
        'body': message.notification?.body ?? '',
        'log_id': logId,
        'event_id': eventId,
        'booth_id': boothId,
        'sent_from_server_time': sentFromServerTime,
        'received_time': DateTime.now().millisecondsSinceEpoch,
        'detect_time': message.data['detect_time'] ?? '',
        'uid': uid,
      },
    );

    FFAppState().firebaseMessage =
    ""; //"""[onMessage] Logged notification_received_beacon , log_id : ${logId}";//"""Notification received: ${eventId}";
    print("✅ [onMessage] Logged notification_received_beacon successfully");
  });

  // ✅ เมื่อผู้ใช้แตะ notification เปิดแอป
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
    print("📬 Notification opened by user: ${message.notification?.title}");
    final notificationId = message.messageId ?? '';

    // ✅ ตรวจสอบว่า messageId มีค่าไหม
    if (notificationId.isEmpty) {
      print("⚠️ messageId ว่าง — ข้ามการ log");
      return;
    }
    // ✅ ตรวจสอบว่าเคย log event นี้ไปแล้วหรือยัง
    if (_loggedNotificationIds.contains(notificationId)) {
      print("⚠️ ข้ามการ log ซ้ำของ notification_id: ${notificationId}");
      return; // ไม่ต้อง log ซ้ำ
    }

    // ✅ เพิ่มเข้าเซ็ต เพื่อกันไม่ให้ log ซ้ำใน session เดียวกัน
    _loggedNotificationIds.add(notificationId);

    // ✅ ดึง log ล่าสุดของผู้ใช้
    final latestLog = await getLatestProximityLog(uid);
    // final logId = latestLog['log_id'] ?? '';
    // final eventId = latestLog['event_id'] ?? '';
    // final boothId = latestLog['booth_id'] ?? '';

    final logId = message.data['log_id'] ?? latestLog['log_id'] ?? '';
    final eventId = message.data['event_id'] ?? latestLog['event_id'] ?? '';
    final boothId = message.data['booth_id'] ?? latestLog['booth_id'] ?? '';
    final sentFromServerTime = message.data['sent_from_server_time'] ?? '';
    final receivedTime = message.data['received_time'] ?? '';

    print("🧩 yyyy log_id: $logId");
    print("🎟️ yyyy event_id: $eventId");
    print("🏕️ yyyy booth_id: $boothId");
    print("⏱️yyyy sent_from_server_time: $sentFromServerTime");
    print("📥 yyyy received_time (from payload): $receivedTime");

    await FirebaseAnalytics.instance.logEvent(
      name: 'notification_opened_beacon',
      parameters: {
        'notification_id': message.messageId ?? '',
        'title': message.notification?.title ?? '',
        'body': message.notification?.body ?? '',
        'log_id': logId,
        'event_id': eventId,
        'booth_id': boothId,
        'sent_from_server_time': sentFromServerTime,
        'received_time': receivedTime,
        'open_time': DateTime.now().millisecondsSinceEpoch,
        'uid': uid,
        'click_action': message.data['click_action'] ?? '',
        'detect_time': message.data['detect_time'] ?? '',
      },
    );
    FFAppState().firebaseMessage =
    ""; //"""[onMessageOpenedApp] Logged notification_opened_beacon , log_id : ${logId}";//"""Notification opened by user: ${eventId}";
    print(
        "✅ [onMessageOpenedApp] Logged notification_opened_beacon successfully");
  });
}

/// ✅ ดึง proximity_logs ล่าสุดของ user
Future<Map<String, dynamic>> getLatestProximityLog(String uid) async {
  try {
    print('📡 Fetching latest proximity log for UID: $uid');

    // 🔹 อ้างอิงไปที่ collection ของผู้ใช้
    final proximityCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('proximity_logs');

    // 🔹 ดึงข้อมูลล่าสุด
    final latestLog = await proximityCollection
        .where('uid', isEqualTo: uid)
        .orderBy('detect_timestamp', descending: true)
        .limit(1)
        .get();
    print('latestLog');
    print('🧾 Raw log data: ${latestLog.docs.first.data()}');

    // 🔹 ตัวแปรค่าเริ่มต้น
    String logId = '';
    int eventId = 0;
    int boothId = 0;

    // 🔹 ถ้ามีข้อมูล
    if (latestLog.docs.isNotEmpty) {
      final data = latestLog.docs.first.data();
      logId = data['log_id'] ?? '';
      eventId = data['event_id'] ?? 0;
      boothId = data['booth_id'] ?? 0;

      print("🧭 Latest proximity log found: $logId ($eventId / $boothId)");
    } else {
      print("⚠️ No proximity_logs found for uid: $uid");
    }

    // 🔹 คืนค่าออกไป
    return {
      'log_id': logId ?? '',
      'event_id': eventId,
      'booth_id': boothId,
    };
  } catch (e) {
    print("❌ Error fetching proximity log: $e");
    return {
      'log_id': '',
      'event_id': 0,
      'booth_id': 0,
    };
  }
}