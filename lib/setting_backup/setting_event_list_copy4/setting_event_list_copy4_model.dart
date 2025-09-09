import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'setting_event_list_copy4_widget.dart' show SettingEventListCopy4Widget;
import 'package:flutter/material.dart';

class SettingEventListCopy4Model
    extends FlutterFlowModel<SettingEventListCopy4Widget> {
  ///  Local state fields for this page.

  List<String> uploadImageTemp = [];
  void addToUploadImageTemp(String item) => uploadImageTemp.add(item);
  void removeFromUploadImageTemp(String item) => uploadImageTemp.remove(item);
  void removeAtIndexFromUploadImageTemp(int index) =>
      uploadImageTemp.removeAt(index);
  void insertAtIndexInUploadImageTemp(int index, String item) =>
      uploadImageTemp.insert(index, item);
  void updateUploadImageTempAtIndex(int index, Function(String) updateFn) =>
      uploadImageTemp[index] = updateFn(uploadImageTemp[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in SettingEventListCopy4 widget.
  List<EventsRecord>? dataEvent;
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  DateTime? datePicked1;
  // State field(s) for eventName widget.
  String? eventNameValue;
  FormFieldController<String>? eventNameValueController;
  DateTime? datePicked2;
  DateTime? datePicked3;
  // Stores action output result for [Backend Call - API (summarizeDashboard)] action in Button widget.
  ApiCallResponse? apiResultw4l;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tabBarController?.dispose();
  }
}
