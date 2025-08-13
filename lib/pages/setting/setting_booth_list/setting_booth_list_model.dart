import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'setting_booth_list_widget.dart' show SettingBoothListWidget;
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class SettingBoothListModel extends FlutterFlowModel<SettingBoothListWidget> {
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

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (getAllBooths)] action in SettingBoothList widget.
  ApiCallResponse? apiResultoee;
  // Stores action output result for [Firestore Query - Query a collection] action in SettingBoothList widget.
  EventsRecord? dataEvent;
  // State field(s) for ListView widget.

  PagingController<DocumentSnapshot?, EventsRecord>? listViewPagingController;
  Query? listViewPagingQuery;
  List<StreamSubscription?> listViewStreamSubscriptions = [];

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    listViewStreamSubscriptions.forEach((s) => s?.cancel());
    listViewPagingController?.dispose();
  }

  /// Additional helper methods.
  PagingController<DocumentSnapshot?, EventsRecord> setListViewController(
    Query query, {
    DocumentReference<Object?>? parent,
  }) {
    listViewPagingController ??= _createListViewController(query, parent);
    if (listViewPagingQuery != query) {
      listViewPagingQuery = query;
      listViewPagingController?.refresh();
    }
    return listViewPagingController!;
  }

  PagingController<DocumentSnapshot?, EventsRecord> _createListViewController(
    Query query,
    DocumentReference<Object?>? parent,
  ) {
    final controller =
        PagingController<DocumentSnapshot?, EventsRecord>(firstPageKey: null);
    return controller
      ..addPageRequestListener(
        (nextPageMarker) => queryEventsRecordPage(
          queryBuilder: (_) => listViewPagingQuery ??= query,
          nextPageMarker: nextPageMarker,
          streamSubscriptions: listViewStreamSubscriptions,
          controller: controller,
          pageSize: 25,
          isStream: true,
        ),
      );
  }
}
