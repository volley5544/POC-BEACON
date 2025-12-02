import 'package:flutter/material.dart';
import '/backend/backend.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

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
    _safeInit(() {
      _userDocRef = prefs.getString('ff_userDocRef')?.ref ?? _userDocRef;
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

  int _rolesID = 1;
  int get rolesID => _rolesID;
  set rolesID(int value) {
    _rolesID = value;
  }

  List<BeaconDataModelStruct> _foundBeaconList = [
    BeaconDataModelStruct.fromSerializableMap(jsonDecode(
        '{\"beaconId\":\"Hello World\",\"beaconName\":\"Hello World\",\"distance\":\"Hello World\"}'))
  ];
  List<BeaconDataModelStruct> get foundBeaconList => _foundBeaconList;
  set foundBeaconList(List<BeaconDataModelStruct> value) {
    _foundBeaconList = value;
  }

  void addToFoundBeaconList(BeaconDataModelStruct value) {
    foundBeaconList.add(value);
  }

  void removeFromFoundBeaconList(BeaconDataModelStruct value) {
    foundBeaconList.remove(value);
  }

  void removeAtIndexFromFoundBeaconList(int index) {
    foundBeaconList.removeAt(index);
  }

  void updateFoundBeaconListAtIndex(
    int index,
    BeaconDataModelStruct Function(BeaconDataModelStruct) updateFn,
  ) {
    foundBeaconList[index] = updateFn(_foundBeaconList[index]);
  }

  void insertAtIndexInFoundBeaconList(int index, BeaconDataModelStruct value) {
    foundBeaconList.insert(index, value);
  }

  List<String> _beaconIdList = [];
  List<String> get beaconIdList => _beaconIdList;
  set beaconIdList(List<String> value) {
    _beaconIdList = value;
  }

  void addToBeaconIdList(String value) {
    beaconIdList.add(value);
  }

  void removeFromBeaconIdList(String value) {
    beaconIdList.remove(value);
  }

  void removeAtIndexFromBeaconIdList(int index) {
    beaconIdList.removeAt(index);
  }

  void updateBeaconIdListAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    beaconIdList[index] = updateFn(_beaconIdList[index]);
  }

  void insertAtIndexInBeaconIdList(int index, String value) {
    beaconIdList.insert(index, value);
  }

  List<String> _beaconNameList = [];
  List<String> get beaconNameList => _beaconNameList;
  set beaconNameList(List<String> value) {
    _beaconNameList = value;
  }

  void addToBeaconNameList(String value) {
    beaconNameList.add(value);
  }

  void removeFromBeaconNameList(String value) {
    beaconNameList.remove(value);
  }

  void removeAtIndexFromBeaconNameList(int index) {
    beaconNameList.removeAt(index);
  }

  void updateBeaconNameListAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    beaconNameList[index] = updateFn(_beaconNameList[index]);
  }

  void insertAtIndexInBeaconNameList(int index, String value) {
    beaconNameList.insert(index, value);
  }

  List<String> _beaconDistanceList = [];
  List<String> get beaconDistanceList => _beaconDistanceList;
  set beaconDistanceList(List<String> value) {
    _beaconDistanceList = value;
  }

  void addToBeaconDistanceList(String value) {
    beaconDistanceList.add(value);
  }

  void removeFromBeaconDistanceList(String value) {
    beaconDistanceList.remove(value);
  }

  void removeAtIndexFromBeaconDistanceList(int index) {
    beaconDistanceList.removeAt(index);
  }

  void updateBeaconDistanceListAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    beaconDistanceList[index] = updateFn(_beaconDistanceList[index]);
  }

  void insertAtIndexInBeaconDistanceList(int index, String value) {
    beaconDistanceList.insert(index, value);
  }

  DocumentReference? _userDocRef;
  DocumentReference? get userDocRef => _userDocRef;
  set userDocRef(DocumentReference? value) {
    _userDocRef = value;
    value != null
        ? prefs.setString('ff_userDocRef', value.path)
        : prefs.remove('ff_userDocRef');
  }

  String _url = 'pocbeacon://pocbeacon.com/';
  String get url => _url;
  set url(String value) {
    _url = value;
  }

  bool _isInApp = false;
  bool get isInApp => _isInApp;
  set isInApp(bool value) {
    _isInApp = value;
  }

  String _firebaseMessage = '';
  String get firebaseMessage => _firebaseMessage;
  set firebaseMessage(String value) {
    _firebaseMessage = value;
  }

  List<String> _beaconRssiList = [];
  List<String> get beaconRssiList => _beaconRssiList;
  set beaconRssiList(List<String> value) {
    _beaconRssiList = value;
  }

  void addToBeaconRssiList(String value) {
    beaconRssiList.add(value);
  }

  void removeFromBeaconRssiList(String value) {
    beaconRssiList.remove(value);
  }

  void removeAtIndexFromBeaconRssiList(int index) {
    beaconRssiList.removeAt(index);
  }

  void updateBeaconRssiListAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    beaconRssiList[index] = updateFn(_beaconRssiList[index]);
  }

  void insertAtIndexInBeaconRssiList(int index, String value) {
    beaconRssiList.insert(index, value);
  }

  double _DeviceDistance = 0.0;
  double get DeviceDistance => _DeviceDistance;
  set DeviceDistance(double value) {
    _DeviceDistance = value;
  }

  bool _isLogging = false;
  bool get isLogging => _isLogging;
  set isLogging(bool value) {
    _isLogging = value;
  }

  int _DeviceMinute = 0;
  int get DeviceMinute => _DeviceMinute;
  set DeviceMinute(int value) {
    _DeviceMinute = value;
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
