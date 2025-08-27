import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'home_pagexxxx_widget.dart' show HomePagexxxxWidget;
import 'package:flutter/material.dart';

class HomePagexxxxModel extends FlutterFlowModel<HomePagexxxxWidget> {
  ///  Local state fields for this page.

  List<EventDataModelStruct> eventDataList = [];
  void addToEventDataList(EventDataModelStruct item) => eventDataList.add(item);
  void removeFromEventDataList(EventDataModelStruct item) =>
      eventDataList.remove(item);
  void removeAtIndexFromEventDataList(int index) =>
      eventDataList.removeAt(index);
  void insertAtIndexInEventDataList(int index, EventDataModelStruct item) =>
      eventDataList.insert(index, item);
  void updateEventDataListAtIndex(
          int index, Function(EventDataModelStruct) updateFn) =>
      eventDataList[index] = updateFn(eventDataList[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - checkInternetConnection] action in Button widget.
  bool? hasConnection;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
