import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'survey_widget.dart' show SurveyWidget;
import 'package:flutter/material.dart';

class SurveyModel extends FlutterFlowModel<SurveyWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for RatingBar widget.
  double? ratingBarValue1;
  // State field(s) for remark widget.
  FocusNode? remarkFocusNode;
  TextEditingController? remarkTextController;
  String? Function(BuildContext, String?)? remarkTextControllerValidator;
  // State field(s) for RatingBar widget.
  double? ratingBarValue2;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    remarkFocusNode?.dispose();
    remarkTextController?.dispose();
  }
}
