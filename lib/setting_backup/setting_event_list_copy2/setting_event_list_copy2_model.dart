import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'setting_event_list_copy2_widget.dart' show SettingEventListCopy2Widget;
import 'package:flutter/material.dart';

class SettingEventListCopy2Model
    extends FlutterFlowModel<SettingEventListCopy2Widget> {
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

  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // State field(s) for DropDown widget.
  String? dropDownValue1;
  FormFieldController<String>? dropDownValueController1;
  // State field(s) for DropDown widget.
  String? dropDownValue2;
  FormFieldController<String>? dropDownValueController2;
  // State field(s) for DropDown widget.
  String? dropDownValue3;
  FormFieldController<String>? dropDownValueController3;
  // State field(s) for DropDown widget.
  String? dropDownValue4;
  FormFieldController<String>? dropDownValueController4;
  bool isDataUploading_uploadData4ps = false;
  List<FFUploadedFile> uploadedLocalFiles_uploadData4ps = [];
  List<String> uploadedFileUrls_uploadData4ps = [];

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tabBarController?.dispose();
  }
}
