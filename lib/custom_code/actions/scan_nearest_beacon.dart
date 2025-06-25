// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// import 'package:flutter_beacon/flutter_beacon.dart';
// import 'package:permission_handler/permission_handler.dart';

Future<String> scanNearestBeacon() async {
  return '';
  // Add your function code here!
  // try {
  //   // เริ่มต้นการสแกน beacon
  //   final regions = <Region>[
  //     Region(identifier: 'any'), // ไม่ระบุ UUID
  //   ];

  //   // ตรวจสอบว่าพร้อมใช้งาน
  //   await flutterBeacon.initializeScanning;

  //   // เริ่มสแกน แล้วรอจนเจอ beacon อย่างน้อย 1 ตัว
  //   final result = await flutterBeacon
  //       .ranging(regions)
  //       .firstWhere((r) => r.beacons.isNotEmpty);

  //   // เรียงลำดับตามความใกล้ (accuracy น้อยสุด)
  //   result.beacons.sort((a, b) => a.accuracy.compareTo(b.accuracy));
  //   final nearest = result.beacons.first;

  //   // คืนค่าข้อมูล beacon ที่ใกล้ที่สุด
  //   return 'UUID: ${nearest.proximityUUID}\nMajor: ${nearest.major}\nMinor: ${nearest.minor}\nDistance: ${nearest.accuracy.toStringAsFixed(2)} m';
  // } catch (e) {
  //   return '❌ ไม่สามารถสแกน beacon ได้: $e';
  // }
}
