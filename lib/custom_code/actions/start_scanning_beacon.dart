// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:dchs_flutter_beacon/dchs_flutter_beacon.dart';

Future startScanningBeacon(BuildContext context) async {
  // Add your function code here!
  WidgetsFlutterBinding.ensureInitialized();
  await flutterBeacon.initializeScanning;

  StreamSubscription<RangingResult>? _streamRanging;
  bool _alertShown = false;

  final regions = <Region>[
    Region(identifier: 'any'),
  ];

  _streamRanging =
      flutterBeacon.ranging(regions).listen((RangingResult result) {
    if (result.beacons.isNotEmpty && !_alertShown) {
      _alertShown = true;

      // หาตัวที่ใกล้ที่สุด (accuracy ต่ำสุด)
      result.beacons.sort((a, b) => a.accuracy.compareTo(b.accuracy));
      final nearest = result.beacons.first;

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
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  });
}
