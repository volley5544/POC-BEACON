import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/instant_timer.dart';
import '/index.dart';
import 'booth_list_copy2_widget.dart' show BoothListCopy2Widget;
import 'package:flutter/material.dart';

class BoothListCopy2Model extends FlutterFlowModel<BoothListCopy2Widget> {
  ///  State fields for stateful widgets in this page.

  InstantTimer? instantTimer;
  // Stores action output result for [Custom Action - checkPermissionsBeacon] action in Button widget.
  bool? buttonCheckPermissionBeaconOutput;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    instantTimer?.cancel();
  }
}
