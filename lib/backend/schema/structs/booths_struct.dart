// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class BoothsStruct extends FFFirebaseStruct {
  BoothsStruct({
    int? boothId,
    String? boothName,
    String? totalParticipants,
    String? cssCode,
    double? participantPercentage,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _boothId = boothId,
        _boothName = boothName,
        _totalParticipants = totalParticipants,
        _cssCode = cssCode,
        _participantPercentage = participantPercentage,
        super(firestoreUtilData);

  // "booth_id" field.
  int? _boothId;
  int get boothId => _boothId ?? 0;
  set boothId(int? val) => _boothId = val;

  void incrementBoothId(int amount) => boothId = boothId + amount;

  bool hasBoothId() => _boothId != null;

  // "booth_name" field.
  String? _boothName;
  String get boothName => _boothName ?? '';
  set boothName(String? val) => _boothName = val;

  bool hasBoothName() => _boothName != null;

  // "total_participants" field.
  String? _totalParticipants;
  String get totalParticipants => _totalParticipants ?? '';
  set totalParticipants(String? val) => _totalParticipants = val;

  bool hasTotalParticipants() => _totalParticipants != null;

  // "css_code" field.
  String? _cssCode;
  String get cssCode => _cssCode ?? '';
  set cssCode(String? val) => _cssCode = val;

  bool hasCssCode() => _cssCode != null;

  // "participant_percentage" field.
  double? _participantPercentage;
  double get participantPercentage => _participantPercentage ?? 0.0;
  set participantPercentage(double? val) => _participantPercentage = val;

  void incrementParticipantPercentage(double amount) =>
      participantPercentage = participantPercentage + amount;

  bool hasParticipantPercentage() => _participantPercentage != null;

  static BoothsStruct fromMap(Map<String, dynamic> data) => BoothsStruct(
        boothId: castToType<int>(data['booth_id']),
        boothName: data['booth_name'] as String?,
        totalParticipants: data['total_participants'] as String?,
        cssCode: data['css_code'] as String?,
        participantPercentage:
            castToType<double>(data['participant_percentage']),
      );

  static BoothsStruct? maybeFromMap(dynamic data) =>
      data is Map ? BoothsStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'booth_id': _boothId,
        'booth_name': _boothName,
        'total_participants': _totalParticipants,
        'css_code': _cssCode,
        'participant_percentage': _participantPercentage,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'booth_id': serializeParam(
          _boothId,
          ParamType.int,
        ),
        'booth_name': serializeParam(
          _boothName,
          ParamType.String,
        ),
        'total_participants': serializeParam(
          _totalParticipants,
          ParamType.String,
        ),
        'css_code': serializeParam(
          _cssCode,
          ParamType.String,
        ),
        'participant_percentage': serializeParam(
          _participantPercentage,
          ParamType.double,
        ),
      }.withoutNulls;

  static BoothsStruct fromSerializableMap(Map<String, dynamic> data) =>
      BoothsStruct(
        boothId: deserializeParam(
          data['booth_id'],
          ParamType.int,
          false,
        ),
        boothName: deserializeParam(
          data['booth_name'],
          ParamType.String,
          false,
        ),
        totalParticipants: deserializeParam(
          data['total_participants'],
          ParamType.String,
          false,
        ),
        cssCode: deserializeParam(
          data['css_code'],
          ParamType.String,
          false,
        ),
        participantPercentage: deserializeParam(
          data['participant_percentage'],
          ParamType.double,
          false,
        ),
      );

  @override
  String toString() => 'BoothsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is BoothsStruct &&
        boothId == other.boothId &&
        boothName == other.boothName &&
        totalParticipants == other.totalParticipants &&
        cssCode == other.cssCode &&
        participantPercentage == other.participantPercentage;
  }

  @override
  int get hashCode => const ListEquality().hash(
      [boothId, boothName, totalParticipants, cssCode, participantPercentage]);
}

BoothsStruct createBoothsStruct({
  int? boothId,
  String? boothName,
  String? totalParticipants,
  String? cssCode,
  double? participantPercentage,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    BoothsStruct(
      boothId: boothId,
      boothName: boothName,
      totalParticipants: totalParticipants,
      cssCode: cssCode,
      participantPercentage: participantPercentage,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

BoothsStruct? updateBoothsStruct(
  BoothsStruct? booths, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    booths
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addBoothsStructData(
  Map<String, dynamic> firestoreData,
  BoothsStruct? booths,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (booths == null) {
    return;
  }
  if (booths.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && booths.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final boothsData = getBoothsFirestoreData(booths, forFieldValue);
  final nestedData = boothsData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = booths.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getBoothsFirestoreData(
  BoothsStruct? booths, [
  bool forFieldValue = false,
]) {
  if (booths == null) {
    return {};
  }
  final firestoreData = mapToFirestore(booths.toMap());

  // Add any Firestore field values
  booths.firestoreUtilData.fieldValues.forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getBoothsListFirestoreData(
  List<BoothsStruct>? boothss,
) =>
    boothss?.map((e) => getBoothsFirestoreData(e, true)).toList() ?? [];
