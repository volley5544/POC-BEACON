import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/instant_timer.dart';
import '/index.dart';
import 'booth_detail_widget.dart' show BoothDetailWidget;
import 'package:flutter/material.dart';

class BoothDetailModel extends FlutterFlowModel<BoothDetailWidget> {
  ///  Local state fields for this page.

  int? counterActivity = 1;

  bool isComplete = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in BoothDetail widget.
  UserActivitiesRecord? dataActivity;
  // Stores action output result for [Firestore Query - Query a collection] action in BoothDetail widget.
  BoothsRecord? dataBooth;
  // Stores action output result for [Firestore Query - Query a collection] action in BoothDetail widget.
  EventsRecord? dataEvent;
  InstantTimer? instantTimer;
  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  // Stores action output result for [Firestore Query - Query a collection] action in ButtonSubmit widget.
  int? countRows;
  // Stores action output result for [Backend Call - Create Document] action in ButtonSubmit widget.
  UserActivityRecord? saveActivity;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    instantTimer?.cancel();
  }
}
