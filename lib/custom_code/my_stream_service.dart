import 'dart:async';
import 'package:dchs_flutter_beacon/dchs_flutter_beacon.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MyStreamService {
  static final MyStreamService _instance = MyStreamService._internal();
  factory MyStreamService() => _instance;
  MyStreamService._internal();

  StreamSubscription<RangingResult>? _streamRanging;

  void startListening(Stream<RangingResult> myStream) {
    _streamRanging ??= myStream.listen((result) async {
      print('in ranging.listen');
      if (result.beacons.isNotEmpty) {
        result.beacons.sort((a, b) => a.accuracy.compareTo(b.accuracy));
        final nearest = result.beacons;
        FFAppState().beaconDistanceList =
            nearest.map((e) => e.accuracy.toStringAsFixed(2)).toList();
        FFAppState().beaconIdList =
            nearest.map((e) => e.proximityUUID).toList();
        // FFAppState().beaconNameList = nearest.map((e) => e.macAddress).toList();
        //safeSetState((){});
      }
      // handle data
    });
  }

  void stopListening() {
    _streamRanging?.cancel();
    _streamRanging = null;
  }
}
