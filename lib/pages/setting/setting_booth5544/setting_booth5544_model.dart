import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'setting_booth5544_widget.dart' show SettingBooth5544Widget;
import 'package:flutter/material.dart';

class SettingBooth5544Model extends FlutterFlowModel<SettingBooth5544Widget> {
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

  List<FFUploadedFile> uploadImageLocalTemp = [];
  void addToUploadImageLocalTemp(FFUploadedFile item) =>
      uploadImageLocalTemp.add(item);
  void removeFromUploadImageLocalTemp(FFUploadedFile item) =>
      uploadImageLocalTemp.remove(item);
  void removeAtIndexFromUploadImageLocalTemp(int index) =>
      uploadImageLocalTemp.removeAt(index);
  void insertAtIndexInUploadImageLocalTemp(int index, FFUploadedFile item) =>
      uploadImageLocalTemp.insert(index, item);
  void updateUploadImageLocalTempAtIndex(
          int index, Function(FFUploadedFile) updateFn) =>
      uploadImageLocalTemp[index] = updateFn(uploadImageLocalTemp[index]);

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Stores action output result for [Backend Call - Read Document] action in SettingBooth5544 widget.
  BoothsRecord? queryBoothAction;
  // State field(s) for eventName widget.
  FocusNode? eventNameFocusNode;
  TextEditingController? eventNameTextController;
  String? Function(BuildContext, String?)? eventNameTextControllerValidator;
  String? _eventNameTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter the patients full name.';
    }

    return null;
  }

  // State field(s) for description widget.
  FocusNode? descriptionFocusNode;
  TextEditingController? descriptionTextController;
  String? Function(BuildContext, String?)? descriptionTextControllerValidator;
  // State field(s) for Distance widget.
  FocusNode? distanceFocusNode;
  TextEditingController? distanceTextController;
  String? Function(BuildContext, String?)? distanceTextControllerValidator;
  String? _distanceTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter an age for the patient.';
    }

    return null;
  }

  // State field(s) for Switch widget.
  bool? switchValue;
  bool isDataUploading_uploadBoothImageAction = false;
  List<FFUploadedFile> uploadedLocalFiles_uploadBoothImageAction = [];

  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  BoothsRecord? queryLastestBoothAction;
  // Stores action output result for [Custom Action - uploadMultipleFileFirebaseStorage] action in Button widget.
  List<String>? uploadImageListToStorageOutput;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  BoothsRecord? createBoothDocOutput;

  @override
  void initState(BuildContext context) {
    eventNameTextControllerValidator = _eventNameTextControllerValidator;
    distanceTextControllerValidator = _distanceTextControllerValidator;
  }

  @override
  void dispose() {
    eventNameFocusNode?.dispose();
    eventNameTextController?.dispose();

    descriptionFocusNode?.dispose();
    descriptionTextController?.dispose();

    distanceFocusNode?.dispose();
    distanceTextController?.dispose();
  }
}
