import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'q_r_code_widget.dart' show QRCodeWidget;
import 'package:flutter/material.dart';

class QRCodeModel extends FlutterFlowModel<QRCodeWidget> {
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
  // Stores action output result for [Backend Call - Read Document] action in QRCode widget.
  EventsRecord? dataEvent;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
