import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'setting_event_copy3_widget.dart' show SettingEventCopy3Widget;
import 'package:flutter/material.dart';

class SettingEventCopy3Model extends FlutterFlowModel<SettingEventCopy3Widget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
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
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  EventsRecord? maxEventId;

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
