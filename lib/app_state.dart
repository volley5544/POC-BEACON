import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _token = prefs.getString('ff_token') ?? _token;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

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

  String _token = '';
  String get token => _token;
  set token(String value) {
    _token = value;
    prefs.setString('ff_token', value);
  }

  String _rolesName = '';
  String get rolesName => _rolesName;
  set rolesName(String value) {
    _rolesName = value;
  }

  String _rolesDescription = '';
  String get rolesDescription => _rolesDescription;
  set rolesDescription(String value) {
    _rolesDescription = value;
  }

  int _rolesID = 0;
  int get rolesID => _rolesID;
  set rolesID(int value) {
    _rolesID = value;
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
