import '/flutter_flow/flutter_flow_util.dart';
import 'emoji_rating_component_widget.dart' show EmojiRatingComponentWidget;
import 'package:flutter/material.dart';

class EmojiRatingComponentModel
    extends FlutterFlowModel<EmojiRatingComponentWidget> {
  ///  Local state fields for this component.

  String score = '0';

  ///  State fields for stateful widgets in this component.

  // State field(s) for remark widget.
  FocusNode? remarkFocusNode;
  TextEditingController? remarkTextController;
  String? Function(BuildContext, String?)? remarkTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    remarkFocusNode?.dispose();
    remarkTextController?.dispose();
  }
}
