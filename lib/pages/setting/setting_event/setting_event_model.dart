import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'setting_event_widget.dart' show SettingEventWidget;
import 'package:flutter/material.dart';

class SettingEventModel extends FlutterFlowModel<SettingEventWidget> {
  ///  Local state fields for this page.

  int? statusCode;

  String? statusMessage;

  String? statusDescription;

  String? startDateTime;

  String? endDateTime;

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

  int? responseEventId;

  String? responseEventDocRefPath;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Stores action output result for [Firestore Query - Query a collection] action in SettingEvent widget.
  EventsRecord? dataEvent;
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
  // State field(s) for frequencyAmount widget.
  FocusNode? frequencyAmountFocusNode;
  TextEditingController? frequencyAmountTextController;
  String? Function(BuildContext, String?)?
      frequencyAmountTextControllerValidator;
  String? _frequencyAmountTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter an age for the patient.';
    }

    return null;
  }

  // State field(s) for frequencyMinute widget.
  FocusNode? frequencyMinuteFocusNode;
  TextEditingController? frequencyMinuteTextController;
  String? Function(BuildContext, String?)?
      frequencyMinuteTextControllerValidator;
  DateTime? datePicked1;
  DateTime? datePicked2;
  bool isDataUploading_uploadData4p = false;
  List<FFUploadedFile> uploadedLocalFiles_uploadData4p = [];
  List<String> uploadedFileUrls_uploadData4p = [];

  // Stores action output result for [Backend Call - API (createEvent)] action in Button widget.
  ApiCallResponse? responseCreated;
  // Stores action output result for [Backend Call - API (updateEvent)] action in Button widget.
  ApiCallResponse? responseUpdated;

  @override
  void initState(BuildContext context) {
    eventNameTextControllerValidator = _eventNameTextControllerValidator;
    frequencyAmountTextControllerValidator =
        _frequencyAmountTextControllerValidator;
  }

  @override
  void dispose() {
    eventNameFocusNode?.dispose();
    eventNameTextController?.dispose();

    descriptionFocusNode?.dispose();
    descriptionTextController?.dispose();

    frequencyAmountFocusNode?.dispose();
    frequencyAmountTextController?.dispose();

    frequencyMinuteFocusNode?.dispose();
    frequencyMinuteTextController?.dispose();
  }
}
