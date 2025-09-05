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
import '/custom_code/my_stream_service.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:background_location/background_location.dart';

Future beaconBackgroundServiceAction() async {
  // Add your function code here!
  await getBackgroundLocation();
}

Future getBackgroundLocation() async {
  // Add your function code here!
  LatLng outputLocation = LatLng(0, 0);
  final service = MyStreamService();
  await BackgroundLocation.startLocationService();
  await BackgroundLocation().getCurrentLocation().then((location) async {
    print('${location.latitude}');
    outputLocation = LatLng(location.latitude!, location.longitude!);
    final regions = <Region>[
      Region(identifier: 'any'),
    ];

    service.startListening(
        flutterBeacon.ranging(regions)); // stays alive across all pages
    service.listenUserNotification();
    service.listenEventWithBooths();
  });
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
