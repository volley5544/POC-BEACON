// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DataListStruct extends FFFirebaseStruct {
  DataListStruct({
    List<int>? boothIdList,
    List<String>? boothNameList,
    List<String>? totalParticipantsList,
    List<String>? colors,
    List<int>? indexSeq,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _boothIdList = boothIdList,
        _boothNameList = boothNameList,
        _totalParticipantsList = totalParticipantsList,
        _colors = colors,
        _indexSeq = indexSeq,
        super(firestoreUtilData);

  // "booth_id_list" field.
  List<int>? _boothIdList;
  List<int> get boothIdList => _boothIdList ?? const [];
  set boothIdList(List<int>? val) => _boothIdList = val;

  void updateBoothIdList(Function(List<int>) updateFn) {
    updateFn(_boothIdList ??= []);
  }

  bool hasBoothIdList() => _boothIdList != null;

  // "booth_name_list" field.
  List<String>? _boothNameList;
  List<String> get boothNameList => _boothNameList ?? const [];
  set boothNameList(List<String>? val) => _boothNameList = val;

  void updateBoothNameList(Function(List<String>) updateFn) {
    updateFn(_boothNameList ??= []);
  }

  bool hasBoothNameList() => _boothNameList != null;

  // "total_participants_list" field.
  List<String>? _totalParticipantsList;
  List<String> get totalParticipantsList => _totalParticipantsList ?? const [];
  set totalParticipantsList(List<String>? val) => _totalParticipantsList = val;

  void updateTotalParticipantsList(Function(List<String>) updateFn) {
    updateFn(_totalParticipantsList ??= []);
  }

  bool hasTotalParticipantsList() => _totalParticipantsList != null;

  // "colors" field.
  List<String>? _colors;
  List<String> get colors => _colors ?? const [];
  set colors(List<String>? val) => _colors = val;

  void updateColors(Function(List<String>) updateFn) {
    updateFn(_colors ??= []);
  }

  bool hasColors() => _colors != null;

  // "index_seq" field.
  List<int>? _indexSeq;
  List<int> get indexSeq => _indexSeq ?? const [];
  set indexSeq(List<int>? val) => _indexSeq = val;

  void updateIndexSeq(Function(List<int>) updateFn) {
    updateFn(_indexSeq ??= []);
  }

  bool hasIndexSeq() => _indexSeq != null;

  static DataListStruct fromMap(Map<String, dynamic> data) => DataListStruct(
        boothIdList: getDataList(data['booth_id_list']),
        boothNameList: getDataList(data['booth_name_list']),
        totalParticipantsList: getDataList(data['total_participants_list']),
        colors: getDataList(data['colors']),
        indexSeq: getDataList(data['index_seq']),
      );

  static DataListStruct? maybeFromMap(dynamic data) =>
      data is Map ? DataListStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'booth_id_list': _boothIdList,
        'booth_name_list': _boothNameList,
        'total_participants_list': _totalParticipantsList,
        'colors': _colors,
        'index_seq': _indexSeq,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'booth_id_list': serializeParam(
          _boothIdList,
          ParamType.int,
          isList: true,
        ),
        'booth_name_list': serializeParam(
          _boothNameList,
          ParamType.String,
          isList: true,
        ),
        'total_participants_list': serializeParam(
          _totalParticipantsList,
          ParamType.String,
          isList: true,
        ),
        'colors': serializeParam(
          _colors,
          ParamType.String,
          isList: true,
        ),
        'index_seq': serializeParam(
          _indexSeq,
          ParamType.int,
          isList: true,
        ),
      }.withoutNulls;

  static DataListStruct fromSerializableMap(Map<String, dynamic> data) =>
      DataListStruct(
        boothIdList: deserializeParam<int>(
          data['booth_id_list'],
          ParamType.int,
          true,
        ),
        boothNameList: deserializeParam<String>(
          data['booth_name_list'],
          ParamType.String,
          true,
        ),
        totalParticipantsList: deserializeParam<String>(
          data['total_participants_list'],
          ParamType.String,
          true,
        ),
        colors: deserializeParam<String>(
          data['colors'],
          ParamType.String,
          true,
        ),
        indexSeq: deserializeParam<int>(
          data['index_seq'],
          ParamType.int,
          true,
        ),
      );

  @override
  String toString() => 'DataListStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is DataListStruct &&
        listEquality.equals(boothIdList, other.boothIdList) &&
        listEquality.equals(boothNameList, other.boothNameList) &&
        listEquality.equals(
            totalParticipantsList, other.totalParticipantsList) &&
        listEquality.equals(colors, other.colors) &&
        listEquality.equals(indexSeq, other.indexSeq);
  }

  @override
  int get hashCode => const ListEquality().hash(
      [boothIdList, boothNameList, totalParticipantsList, colors, indexSeq]);
}

DataListStruct createDataListStruct({
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    DataListStruct(
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

DataListStruct? updateDataListStruct(
  DataListStruct? dataList, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    dataList
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addDataListStructData(
  Map<String, dynamic> firestoreData,
  DataListStruct? dataList,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (dataList == null) {
    return;
  }
  if (dataList.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && dataList.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final dataListData = getDataListFirestoreData(dataList, forFieldValue);
  final nestedData = dataListData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = dataList.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getDataListFirestoreData(
  DataListStruct? dataList, [
  bool forFieldValue = false,
]) {
  if (dataList == null) {
    return {};
  }
  final firestoreData = mapToFirestore(dataList.toMap());

  // Add any Firestore field values
  dataList.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getDataListListFirestoreData(
  List<DataListStruct>? dataLists,
) =>
    dataLists?.map((e) => getDataListFirestoreData(e, true)).toList() ?? [];
