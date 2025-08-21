import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/instant_timer.dart';
import '/index.dart';
import 'booth_list_widget.dart' show BoothListWidget;
import 'package:flutter/material.dart';

class BoothListModel extends FlutterFlowModel<BoothListWidget> {
  ///  State fields for stateful widgets in this page.

  InstantTimer? instantTimer;
  InstantTimer? instantTimer2;
  // Stores action output result for [Custom Action - checkPermissionsBeacon] action in Button widget.
  bool? buttonCheckPermissionBeaconOutput;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    instantTimer?.cancel();
    instantTimer2?.cancel();
  }
}
