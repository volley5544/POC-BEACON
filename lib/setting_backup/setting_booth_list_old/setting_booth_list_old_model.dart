import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'setting_booth_list_old_widget.dart' show SettingBoothListOldWidget;
import 'package:flutter/material.dart';

class SettingBoothListOldModel
    extends FlutterFlowModel<SettingBoothListOldWidget> {
  ///  Local state fields for this page.

  List<String> boothName = [];
  void addToBoothName(String item) => boothName.add(item);
  void removeFromBoothName(String item) => boothName.remove(item);
  void removeAtIndexFromBoothName(int index) => boothName.removeAt(index);
  void insertAtIndexInBoothName(int index, String item) =>
      boothName.insert(index, item);
  void updateBoothNameAtIndex(int index, Function(String) updateFn) =>
      boothName[index] = updateFn(boothName[index]);

  List<String> boothDescription = [];
  void addToBoothDescription(String item) => boothDescription.add(item);
  void removeFromBoothDescription(String item) => boothDescription.remove(item);
  void removeAtIndexFromBoothDescription(int index) =>
      boothDescription.removeAt(index);
  void insertAtIndexInBoothDescription(int index, String item) =>
      boothDescription.insert(index, item);
  void updateBoothDescriptionAtIndex(int index, Function(String) updateFn) =>
      boothDescription[index] = updateFn(boothDescription[index]);

  List<int> notiDistance = [];
  void addToNotiDistance(int item) => notiDistance.add(item);
  void removeFromNotiDistance(int item) => notiDistance.remove(item);
  void removeAtIndexFromNotiDistance(int index) => notiDistance.removeAt(index);
  void insertAtIndexInNotiDistance(int index, int item) =>
      notiDistance.insert(index, item);
  void updateNotiDistanceAtIndex(int index, Function(int) updateFn) =>
      notiDistance[index] = updateFn(notiDistance[index]);

  List<String> imageBooth = [];
  void addToImageBooth(String item) => imageBooth.add(item);
  void removeFromImageBooth(String item) => imageBooth.remove(item);
  void removeAtIndexFromImageBooth(int index) => imageBooth.removeAt(index);
  void insertAtIndexInImageBooth(int index, String item) =>
      imageBooth.insert(index, item);
  void updateImageBoothAtIndex(int index, Function(String) updateFn) =>
      imageBooth[index] = updateFn(imageBooth[index]);

  String? eventName;

  List<int> boothId = [];
  void addToBoothId(int item) => boothId.add(item);
  void removeFromBoothId(int item) => boothId.remove(item);
  void removeAtIndexFromBoothId(int index) => boothId.removeAt(index);
  void insertAtIndexInBoothId(int index, int item) =>
      boothId.insert(index, item);
  void updateBoothIdAtIndex(int index, Function(int) updateFn) =>
      boothId[index] = updateFn(boothId[index]);

  List<String> boothDocRef = [];
  void addToBoothDocRef(String item) => boothDocRef.add(item);
  void removeFromBoothDocRef(String item) => boothDocRef.remove(item);
  void removeAtIndexFromBoothDocRef(int index) => boothDocRef.removeAt(index);
  void insertAtIndexInBoothDocRef(int index, String item) =>
      boothDocRef.insert(index, item);
  void updateBoothDocRefAtIndex(int index, Function(String) updateFn) =>
      boothDocRef[index] = updateFn(boothDocRef[index]);

  int? boothIdSelect;

  String? boothDocRefSelect;

  List<dynamic> responseData = [];
  void addToResponseData(dynamic item) => responseData.add(item);
  void removeFromResponseData(dynamic item) => responseData.remove(item);
  void removeAtIndexFromResponseData(int index) => responseData.removeAt(index);
  void insertAtIndexInResponseData(int index, dynamic item) =>
      responseData.insert(index, item);
  void updateResponseDataAtIndex(int index, Function(dynamic) updateFn) =>
      responseData[index] = updateFn(responseData[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (getAllBooths)] action in SettingBoothListOld widget.
  ApiCallResponse? apiResultoee;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
