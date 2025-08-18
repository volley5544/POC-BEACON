import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'booth_detail_widget.dart' show BoothDetailWidget;
import 'package:flutter/material.dart';

class BoothDetailModel extends FlutterFlowModel<BoothDetailWidget> {
  ///  Local state fields for this page.

  int? counterActivity = 1;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in BoothDetail widget.
  BoothsRecord? dataBooth;
  // Stores action output result for [Firestore Query - Query a collection] action in BoothDetail widget.
  UserActivitiesRecord? dataActivity;
  // Stores action output result for [Firestore Query - Query a collection] action in BoothDetail widget.
  EventsRecord? dataEvent;
  // Stores action output result for [Firestore Query - Query a collection] action in ButtonSubmit widget.
  int? countRows;
  // Stores action output result for [Backend Call - Create Document] action in ButtonSubmit widget.
  UserActivitiesRecord? saveActivity;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
