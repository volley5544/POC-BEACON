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
// import 'package:flutter_background_service/flutter_background_service.dart';

Future beaconBackgroundServiceAction() async {
  // Add your function code here!
  if (!kIsWeb) {
    final regions = <Region>[
      Region(identifier: 'any'),
    ];
    final service = MyStreamService();
    service.startListening(
        flutterBeacon.ranging(regions)); // stays alive across all pages
    service.listenUserNotification();
    service.listenEventWithBooths();
  } else {
    final service = MyStreamService();
    service.listenUserNotification();
  }
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
