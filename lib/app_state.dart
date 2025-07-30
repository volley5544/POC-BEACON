import 'package:flutter/material.dart';
import 'flutter_flow/request_manager.dart';
import '/backend/backend.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {}

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  List<String> _listStringTemp = [
    'Hello World1',
    'Hello World2',
    'Hello World3',
    'Hello World4',
    'Hello World5'
  ];
  List<String> get listStringTemp => _listStringTemp;
  set listStringTemp(List<String> value) {
    _listStringTemp = value;
  }

  void addToListStringTemp(String value) {
    listStringTemp.add(value);
  }

  void removeFromListStringTemp(String value) {
    listStringTemp.remove(value);
  }

  void removeAtIndexFromListStringTemp(int index) {
    listStringTemp.removeAt(index);
  }

  void updateListStringTempAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    listStringTemp[index] = updateFn(_listStringTemp[index]);
  }

  void insertAtIndexInListStringTemp(int index, String value) {
    listStringTemp.insert(index, value);
  }

  final _getEventByIdManager = StreamRequestManager<EventsRecord>();
  Stream<EventsRecord> getEventById({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Stream<EventsRecord> Function() requestFn,
  }) =>
      _getEventByIdManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearGetEventByIdCache() => _getEventByIdManager.clear();
  void clearGetEventByIdCacheKey(String? uniqueKey) =>
      _getEventByIdManager.clearRequest(uniqueKey);
}
