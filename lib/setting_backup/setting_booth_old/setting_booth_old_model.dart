import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'setting_booth_old_widget.dart' show SettingBoothOldWidget;
import 'package:flutter/material.dart';

class SettingBoothOldModel extends FlutterFlowModel<SettingBoothOldWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Stores action output result for [Firestore Query - Query a collection] action in SettingBoothOld widget.
  BoothsRecord? queryBooth;
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
  // Stores action output result for [Backend Call - API (createBooths)] action in Button widget.
  ApiCallResponse? responseCreated;
  // Stores action output result for [Backend Call - API (updateBooths)] action in Button widget.
  ApiCallResponse? responseUpdated;

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
