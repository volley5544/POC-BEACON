import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/instant_timer.dart';
import '/custom_code/my_stream_service.dart';
import '/index.dart';
import 'booth_list_widget.dart' show BoothListWidget;
import 'package:flutter/material.dart';

class BoothListModel extends FlutterFlowModel<BoothListWidget> {
  ///  Local state fields for this page.

  int? colorOne;

  int? colorTwo;

  int? colorThree;

  int? colorLast;

  MyStreamService? myStreamService;

  ///  State fields for stateful widgets in this page.

  InstantTimer? instantTimer;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    instantTimer?.cancel();
  }
}
