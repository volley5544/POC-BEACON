import '/flutter_flow/flutter_flow_util.dart';
import 'onboarding05_widget.dart' show Onboarding05Widget;
import 'package:flutter/material.dart';

class Onboarding05Model extends FlutterFlowModel<Onboarding05Widget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
