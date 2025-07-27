import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'setting_booth_widget.dart' show SettingBoothWidget;
import 'package:flutter/material.dart';

class SettingBoothModel extends FlutterFlowModel<SettingBoothWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for boothName widget.
  FocusNode? boothNameFocusNode;
  TextEditingController? boothNameTextController;
  String? Function(BuildContext, String?)? boothNameTextControllerValidator;
  String? _boothNameTextControllerValidator(BuildContext context, String? val) {
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

  // State field(s) for Switch widget.
  bool? switchValue;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  BoothsRecord? createBoothDoc;

  @override
  void initState(BuildContext context) {
    boothNameTextControllerValidator = _boothNameTextControllerValidator;
    remindAmountTextControllerValidator = _remindAmountTextControllerValidator;
  }

  @override
  void dispose() {
    boothNameFocusNode?.dispose();
    boothNameTextController?.dispose();

    descriptionFocusNode?.dispose();
    descriptionTextController?.dispose();

    remindAmountFocusNode?.dispose();
    remindAmountTextController?.dispose();
  }
}
