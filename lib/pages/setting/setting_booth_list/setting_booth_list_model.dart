import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'setting_booth_list_widget.dart' show SettingBoothListWidget;
import 'package:flutter/material.dart';

class SettingBoothListModel extends FlutterFlowModel<SettingBoothListWidget> {
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

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
