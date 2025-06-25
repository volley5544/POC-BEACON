// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:async';

// import 'package:flutter_beacon/flutter_beacon.dart';
import 'package:permission_handler/permission_handler.dart';

Future<bool> scanBLEBeaconAction() async {
  // Add your function code here!
  // try {
  //   await flutterBeacon.initializeScanning;

  //   await Permission.bluetooth.request();
  //   await Permission.bluetoothScan.request();
  //   await Permission.bluetoothConnect.request();
  //   await Permission.locationWhenInUse.request();

  //   if (!await Permission.locationWhenInUse.isGranted) {
  //     return false;
  //   }

  //   final targetUUID = 'fda50693-a4e2-4fb1-afcf-c6eb07647826';
  //   final targetMajor = 2;
  //   final targetMinor = 1;

  //   final regions = <Region>[
  //     Region(identifier: 'wildcard'),
  //   ];

  //   final completer = Completer<bool>();

  //   StreamSubscription<RangingResult>? subscription;

  //   subscription = flutterBeacon.ranging(regions).listen((result) {
  //     for (var beacon in result.beacons) {
  //       if (beacon.proximityUUID.toLowerCase() == targetUUID &&
  //           beacon.major == targetMajor &&
  //           beacon.minor == targetMinor) {
  //         subscription?.cancel();
  //         if (!completer.isCompleted) completer.complete(true);
  //         return;
  //       }
  //     }
  //   });

  //   Future.delayed(Duration(seconds: 5)).then((_) {
  //     subscription?.cancel();
  //     if (!completer.isCompleted) completer.complete(false);
  //   });

  //   return await completer.future;
  // } catch (e) {
  //   return false;
  // }
  return false;
}
