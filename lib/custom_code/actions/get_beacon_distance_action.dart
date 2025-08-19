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

import 'package:dchs_flutter_beacon/dchs_flutter_beacon.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import 'dart:async';

Future<void> getBeaconDistanceAction(
  BuildContext context,
  String? currentUserDisplayName,
  DocumentReference? currentUserReference,
) async {
  // Add your function code here!
  // WidgetsFlutterBinding.ensureInitialized();
  await flutterBeacon.initializeScanning;

  StreamSubscription<RangingResult>? _streamRanging;
  // bool _alertShown = false;

  final regions = <Region>[
    Region(identifier: 'any'),
  ];
  print('Timer 5 sec');
  StreamSubscription<RangingResult>? streamRanging;
  streamRanging = flutterBeacon.ranging(regions).listen((result) {
    if (result.beacons.isNotEmpty) {
      result.beacons.sort((a, b) => a.accuracy.compareTo(b.accuracy));
      final nearest = result.beacons;
      FFAppState().beaconDistance = nearest.accuracy;

      /* niruemon.n comment ชั่วคราว 2035-06-05*/
      // triggerPushNotification(
      //   notificationTitle: 'Test Notification Title',
      //   notificationText:
      //       'เชิญคุณ ${currentUserDisplayName!} มาเล่นเกมที่ Booth01',
      //   notificationSound: 'default',
      //   userRefs: [currentUserReference!],
      //   initialPageName: 'scan_beacon',
      //   parameterData: {},
      // );

      // streamRanging?.cancel(); // หยุดหลังเจอ
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('📡 เจอ Beacon ใกล้ที่สุด'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('UUID: ${nearest.proximityUUID}'),
              Text('Major: ${nearest.major}'),
              Text('Minor: ${nearest.minor}'),
              Text('ระยะโดยประมาณ: ${nearest.accuracy.toStringAsFixed(2)} m'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  });
}
