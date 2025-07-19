import '/flutter_flow/flutter_flow_util.dart';
import 'setting_event_widget.dart' show SettingEventWidget;
import 'package:flutter/material.dart';

class SettingEventModel extends FlutterFlowModel<SettingEventWidget> {
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
  // State field(s) for remindAmount widget.
  FocusNode? remindAmountFocusNode;
  TextEditingController? remindAmountTextController;
  String? Function(BuildContext, String?)? remindAmountTextControllerValidator;
  String? _remindAmountTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter an age for the patient.';
    }

    return null;
  }

  // State field(s) for periodTime widget.
  FocusNode? periodTimeFocusNode;
  TextEditingController? periodTimeTextController;
  String? Function(BuildContext, String?)? periodTimeTextControllerValidator;
  DateTime? datePicked1;
  DateTime? datePicked2;
  // State field(s) for Switch widget.
  bool? switchValue;

  @override
  void initState(BuildContext context) {
    eventNameTextControllerValidator = _eventNameTextControllerValidator;
    remindAmountTextControllerValidator = _remindAmountTextControllerValidator;
  }

  @override
  void dispose() {
    eventNameFocusNode?.dispose();
    eventNameTextController?.dispose();

    descriptionFocusNode?.dispose();
    descriptionTextController?.dispose();

    remindAmountFocusNode?.dispose();
    remindAmountTextController?.dispose();

    periodTimeFocusNode?.dispose();
    periodTimeTextController?.dispose();
  }
}
