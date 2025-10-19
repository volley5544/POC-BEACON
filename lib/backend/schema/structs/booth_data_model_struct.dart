// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class BoothDataModelStruct extends FFFirebaseStruct {
  BoothDataModelStruct({
    String? id,
    int? boothId,
    String? boothName,
    String? description,
    double? notificationDistance,
    String? associatedEventId,
    String? createdAt,
    String? createdBy,
    int? isActive,
    String? updatedAt,
    String? updatedBy,
    int? eventId,
    String? status,
    List<ImagesStruct>? images,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        _boothId = boothId,
        _boothName = boothName,
        _description = description,
        _notificationDistance = notificationDistance,
        _associatedEventId = associatedEventId,
        _createdAt = createdAt,
        _createdBy = createdBy,
        _isActive = isActive,
        _updatedAt = updatedAt,
        _updatedBy = updatedBy,
        _eventId = eventId,
        _status = status,
        _images = images,
        super(firestoreUtilData);

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

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

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  set description(String? val) => _description = val;

  bool hasDescription() => _description != null;

  // "notification_distance" field.
  double? _notificationDistance;
  double get notificationDistance => _notificationDistance ?? 0.0;
  set notificationDistance(double? val) => _notificationDistance = val;

  void incrementNotificationDistance(double amount) =>
      notificationDistance = notificationDistance + amount;

  bool hasNotificationDistance() => _notificationDistance != null;

  // "associated_event_id" field.
  String? _associatedEventId;
  String get associatedEventId => _associatedEventId ?? '';
  set associatedEventId(String? val) => _associatedEventId = val;

  bool hasAssociatedEventId() => _associatedEventId != null;

  // "created_at" field.
  String? _createdAt;
  String get createdAt => _createdAt ?? '';
  set createdAt(String? val) => _createdAt = val;

  bool hasCreatedAt() => _createdAt != null;

  // "created_by" field.
  String? _createdBy;
  String get createdBy => _createdBy ?? '';
  set createdBy(String? val) => _createdBy = val;

  bool hasCreatedBy() => _createdBy != null;

  // "is_active" field.
  int? _isActive;
  int get isActive => _isActive ?? 0;
  set isActive(int? val) => _isActive = val;

  void incrementIsActive(int amount) => isActive = isActive + amount;

  bool hasIsActive() => _isActive != null;

  // "updated_at" field.
  String? _updatedAt;
  String get updatedAt => _updatedAt ?? '';
  set updatedAt(String? val) => _updatedAt = val;

  bool hasUpdatedAt() => _updatedAt != null;

  // "updated_by" field.
  String? _updatedBy;
  String get updatedBy => _updatedBy ?? '';
  set updatedBy(String? val) => _updatedBy = val;

  bool hasUpdatedBy() => _updatedBy != null;

  // "event_id" field.
  int? _eventId;
  int get eventId => _eventId ?? 0;
  set eventId(int? val) => _eventId = val;

  void incrementEventId(int amount) => eventId = eventId + amount;

  bool hasEventId() => _eventId != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  set status(String? val) => _status = val;

  bool hasStatus() => _status != null;

  // "images" field.
  List<ImagesStruct>? _images;
  List<ImagesStruct> get images => _images ?? const [];
  set images(List<ImagesStruct>? val) => _images = val;

  void updateImages(Function(List<ImagesStruct>) updateFn) {
    updateFn(_images ??= []);
  }

  bool hasImages() => _images != null;

  static BoothDataModelStruct fromMap(Map<String, dynamic> data) =>
      BoothDataModelStruct(
        id: data['id'] as String?,
        boothId: castToType<int>(data['booth_id']),
        boothName: data['booth_name'] as String?,
        description: data['description'] as String?,
        notificationDistance: castToType<double>(data['notification_distance']),
        associatedEventId: data['associated_event_id'] as String?,
        createdAt: data['created_at'] as String?,
        createdBy: data['created_by'] as String?,
        isActive: castToType<int>(data['is_active']),
        updatedAt: data['updated_at'] as String?,
        updatedBy: data['updated_by'] as String?,
        eventId: castToType<int>(data['event_id']),
        status: data['status'] as String?,
        images: getStructList(
          data['images'],
          ImagesStruct.fromMap,
        ),
      );

  static BoothDataModelStruct? maybeFromMap(dynamic data) => data is Map
      ? BoothDataModelStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'booth_id': _boothId,
        'booth_name': _boothName,
        'description': _description,
        'notification_distance': _notificationDistance,
        'associated_event_id': _associatedEventId,
        'created_at': _createdAt,
        'created_by': _createdBy,
        'is_active': _isActive,
        'updated_at': _updatedAt,
        'updated_by': _updatedBy,
        'event_id': _eventId,
        'status': _status,
        'images': _images?.map((e) => e.toMap()).toList(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
        'booth_id': serializeParam(
          _boothId,
          ParamType.int,
        ),
        'booth_name': serializeParam(
          _boothName,
          ParamType.String,
        ),
        'description': serializeParam(
          _description,
          ParamType.String,
        ),
        'notification_distance': serializeParam(
          _notificationDistance,
          ParamType.double,
        ),
        'associated_event_id': serializeParam(
          _associatedEventId,
          ParamType.String,
        ),
        'created_at': serializeParam(
          _createdAt,
          ParamType.String,
        ),
        'created_by': serializeParam(
          _createdBy,
          ParamType.String,
        ),
        'is_active': serializeParam(
          _isActive,
          ParamType.int,
        ),
        'updated_at': serializeParam(
          _updatedAt,
          ParamType.String,
        ),
        'updated_by': serializeParam(
          _updatedBy,
          ParamType.String,
        ),
        'event_id': serializeParam(
          _eventId,
          ParamType.int,
        ),
        'status': serializeParam(
          _status,
          ParamType.String,
        ),
        'images': serializeParam(
          _images,
          ParamType.DataStruct,
          isList: true,
        ),
      }.withoutNulls;

  static BoothDataModelStruct fromSerializableMap(Map<String, dynamic> data) =>
      BoothDataModelStruct(
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
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
        description: deserializeParam(
          data['description'],
          ParamType.String,
          false,
        ),
        notificationDistance: deserializeParam(
          data['notification_distance'],
          ParamType.double,
          false,
        ),
        associatedEventId: deserializeParam(
          data['associated_event_id'],
          ParamType.String,
          false,
        ),
        createdAt: deserializeParam(
          data['created_at'],
          ParamType.String,
          false,
        ),
        createdBy: deserializeParam(
          data['created_by'],
          ParamType.String,
          false,
        ),
        isActive: deserializeParam(
          data['is_active'],
          ParamType.int,
          false,
        ),
        updatedAt: deserializeParam(
          data['updated_at'],
          ParamType.String,
          false,
        ),
        updatedBy: deserializeParam(
          data['updated_by'],
          ParamType.String,
          false,
        ),
        eventId: deserializeParam(
          data['event_id'],
          ParamType.int,
          false,
        ),
        status: deserializeParam(
          data['status'],
          ParamType.String,
          false,
        ),
        images: deserializeStructParam<ImagesStruct>(
          data['images'],
          ParamType.DataStruct,
          true,
          structBuilder: ImagesStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'BoothDataModelStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is BoothDataModelStruct &&
        id == other.id &&
        boothId == other.boothId &&
        boothName == other.boothName &&
        description == other.description &&
        notificationDistance == other.notificationDistance &&
        associatedEventId == other.associatedEventId &&
        createdAt == other.createdAt &&
        createdBy == other.createdBy &&
        isActive == other.isActive &&
        updatedAt == other.updatedAt &&
        updatedBy == other.updatedBy &&
        eventId == other.eventId &&
        status == other.status &&
        listEquality.equals(images, other.images);
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        boothId,
        boothName,
        description,
        notificationDistance,
        associatedEventId,
        createdAt,
        createdBy,
        isActive,
        updatedAt,
        updatedBy,
        eventId,
        status,
        images
      ]);
}

BoothDataModelStruct createBoothDataModelStruct({
  String? id,
  int? boothId,
  String? boothName,
  String? description,
  double? notificationDistance,
  String? associatedEventId,
  String? createdAt,
  String? createdBy,
  int? isActive,
  String? updatedAt,
  String? updatedBy,
  int? eventId,
  String? status,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    BoothDataModelStruct(
      id: id,
      boothId: boothId,
      boothName: boothName,
      description: description,
      notificationDistance: notificationDistance,
      associatedEventId: associatedEventId,
      createdAt: createdAt,
      createdBy: createdBy,
      isActive: isActive,
      updatedAt: updatedAt,
      updatedBy: updatedBy,
      eventId: eventId,
      status: status,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

BoothDataModelStruct? updateBoothDataModelStruct(
  BoothDataModelStruct? boothDataModel, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    boothDataModel
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addBoothDataModelStructData(
  Map<String, dynamic> firestoreData,
  BoothDataModelStruct? boothDataModel,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (boothDataModel == null) {
    return;
  }
  if (boothDataModel.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && boothDataModel.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final boothDataModelData =
      getBoothDataModelFirestoreData(boothDataModel, forFieldValue);
  final nestedData =
      boothDataModelData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = boothDataModel.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getBoothDataModelFirestoreData(
  BoothDataModelStruct? boothDataModel, [
  bool forFieldValue = false,
]) {
  if (boothDataModel == null) {
    return {};
  }
  final firestoreData = mapToFirestore(boothDataModel.toMap());

  // Add any Firestore field values
  boothDataModel.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getBoothDataModelListFirestoreData(
  List<BoothDataModelStruct>? boothDataModels,
) =>
    boothDataModels
        ?.map((e) => getBoothDataModelFirestoreData(e, true))
        .toList() ??
    [];
