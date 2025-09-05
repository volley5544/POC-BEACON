import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'setting_event_list_widget.dart' show SettingEventListWidget;
import 'package:flutter/material.dart';

class SettingEventListModel extends FlutterFlowModel<SettingEventListWidget> {
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

  List<double> tempPageState = [20.0, 40.0, 40.0];
  void addToTempPageState(double item) => tempPageState.add(item);
  void removeFromTempPageState(double item) => tempPageState.remove(item);
  void removeAtIndexFromTempPageState(int index) =>
      tempPageState.removeAt(index);
  void insertAtIndexInTempPageState(int index, double item) =>
      tempPageState.insert(index, item);
  void updateTempPageStateAtIndex(int index, Function(double) updateFn) =>
      tempPageState[index] = updateFn(tempPageState[index]);

  List<String> tempPageStateName = ['aaa', 'bbb', 'ccc'];
  void addToTempPageStateName(String item) => tempPageStateName.add(item);
  void removeFromTempPageStateName(String item) =>
      tempPageStateName.remove(item);
  void removeAtIndexFromTempPageStateName(int index) =>
      tempPageStateName.removeAt(index);
  void insertAtIndexInTempPageStateName(int index, String item) =>
      tempPageStateName.insert(index, item);
  void updateTempPageStateNameAtIndex(int index, Function(String) updateFn) =>
      tempPageStateName[index] = updateFn(tempPageStateName[index]);

  ///  State fields for stateful widgets in this page.

  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // State field(s) for eventName widget.
  String? eventNameValue;
  FormFieldController<String>? eventNameValueController;
  DateTime? datePicked1;
  DateTime? datePicked2;
  // Stores action output result for [Backend Call - API (summarizeDashboard)] action in Button widget.
  ApiCallResponse? apiResultw4l;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tabBarController?.dispose();
  }
}
