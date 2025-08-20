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

Future getBeaconDistanceAction(
  BuildContext context,
  Future Function()? setStateAction,
) async {
  // Add your function code here!
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
      FFAppState().beaconDistanceList =
          nearest.map((e) => e.accuracy.toStringAsFixed(2)).toList();
      FFAppState().beaconIdList = nearest.map((e) => e.proximityUUID).toList();
      FFAppState().beaconNameList = nearest.map((e) => e.macAddress).toList();
      safeSetState(() {});
    }
  });
}
