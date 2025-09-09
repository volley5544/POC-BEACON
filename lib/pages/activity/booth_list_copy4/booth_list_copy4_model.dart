import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'booth_list_copy4_widget.dart' show BoothListCopy4Widget;
import 'package:flutter/material.dart';

class BoothListCopy4Model extends FlutterFlowModel<BoothListCopy4Widget> {
  ///  Local state fields for this page.

  int? colorOne;

  int? colorTwo;

  int? colorThree;

  int? colorLast;

  List<PaticipantDataModelStruct> paticipantDataList = [];
  void addToPaticipantDataList(PaticipantDataModelStruct item) =>
      paticipantDataList.add(item);
  void removeFromPaticipantDataList(PaticipantDataModelStruct item) =>
      paticipantDataList.remove(item);
  void removeAtIndexFromPaticipantDataList(int index) =>
      paticipantDataList.removeAt(index);
  void insertAtIndexInPaticipantDataList(
          int index, PaticipantDataModelStruct item) =>
      paticipantDataList.insert(index, item);
  void updatePaticipantDataListAtIndex(
          int index, Function(PaticipantDataModelStruct) updateFn) =>
      paticipantDataList[index] = updateFn(paticipantDataList[index]);

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
