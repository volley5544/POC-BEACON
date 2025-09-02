import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'event_selection_widget.dart' show EventSelectionWidget;
import 'package:flutter/material.dart';

class EventSelectionModel extends FlutterFlowModel<EventSelectionWidget> {
  ///  Local state fields for this page.

  DateTime? datetimeCurrent;

  DateTime? datetimeCurrentEnd;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in EventSelection widget.
  List<RegisterRecord>? dataRegister;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
