// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class EventDataModelStruct extends FFFirebaseStruct {
  EventDataModelStruct({
    int? eventId,
    String? eventName,
    String? description,
    String? createdBy,
    int? isActive,
    String? uploadedBy,
    int? notificationFrequencyAmount,
    int? notificationFrequencyMinute,
    List<String>? eventImageList,
    DateTime? startDatetime,
    DateTime? endDatetime,
    DateTime? uploadedAt,
    DateTime? createdAt,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _eventId = eventId,
        _eventName = eventName,
        _description = description,
        _createdBy = createdBy,
        _isActive = isActive,
        _uploadedBy = uploadedBy,
        _notificationFrequencyAmount = notificationFrequencyAmount,
        _notificationFrequencyMinute = notificationFrequencyMinute,
        _eventImageList = eventImageList,
        _startDatetime = startDatetime,
        _endDatetime = endDatetime,
        _uploadedAt = uploadedAt,
        _createdAt = createdAt,
        super(firestoreUtilData);

  // "event_id" field.
  int? _eventId;
  int get eventId => _eventId ?? 0;
  set eventId(int? val) => _eventId = val;

  void incrementEventId(int amount) => eventId = eventId + amount;

  bool hasEventId() => _eventId != null;

  // "event_name" field.
  String? _eventName;
  String get eventName => _eventName ?? '';
  set eventName(String? val) => _eventName = val;

  bool hasEventName() => _eventName != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  set description(String? val) => _description = val;

  bool hasDescription() => _description != null;

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

  // "uploaded_by" field.
  String? _uploadedBy;
  String get uploadedBy => _uploadedBy ?? '';
  set uploadedBy(String? val) => _uploadedBy = val;

  bool hasUploadedBy() => _uploadedBy != null;

  // "notification_frequency_amount" field.
  int? _notificationFrequencyAmount;
  int get notificationFrequencyAmount => _notificationFrequencyAmount ?? 0;
  set notificationFrequencyAmount(int? val) =>
      _notificationFrequencyAmount = val;

  void incrementNotificationFrequencyAmount(int amount) =>
      notificationFrequencyAmount = notificationFrequencyAmount + amount;

  bool hasNotificationFrequencyAmount() => _notificationFrequencyAmount != null;

  // "notification_frequency_minute" field.
  int? _notificationFrequencyMinute;
  int get notificationFrequencyMinute => _notificationFrequencyMinute ?? 0;
  set notificationFrequencyMinute(int? val) =>
      _notificationFrequencyMinute = val;

  void incrementNotificationFrequencyMinute(int amount) =>
      notificationFrequencyMinute = notificationFrequencyMinute + amount;

  bool hasNotificationFrequencyMinute() => _notificationFrequencyMinute != null;

  // "event_image_list" field.
  List<String>? _eventImageList;
  List<String> get eventImageList => _eventImageList ?? const [];
  set eventImageList(List<String>? val) => _eventImageList = val;

  void updateEventImageList(Function(List<String>) updateFn) {
    updateFn(_eventImageList ??= []);
  }

  bool hasEventImageList() => _eventImageList != null;

  // "start_datetime" field.
  DateTime? _startDatetime;
  DateTime? get startDatetime => _startDatetime;
  set startDatetime(DateTime? val) => _startDatetime = val;

  bool hasStartDatetime() => _startDatetime != null;

  // "end_datetime" field.
  DateTime? _endDatetime;
  DateTime? get endDatetime => _endDatetime;
  set endDatetime(DateTime? val) => _endDatetime = val;

  bool hasEndDatetime() => _endDatetime != null;

  // "uploaded_at" field.
  DateTime? _uploadedAt;
  DateTime? get uploadedAt => _uploadedAt;
  set uploadedAt(DateTime? val) => _uploadedAt = val;

  bool hasUploadedAt() => _uploadedAt != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  set createdAt(DateTime? val) => _createdAt = val;

  bool hasCreatedAt() => _createdAt != null;

  static EventDataModelStruct fromMap(Map<String, dynamic> data) =>
      EventDataModelStruct(
        eventId: castToType<int>(data['event_id']),
        eventName: data['event_name'] as String?,
        description: data['description'] as String?,
        createdBy: data['created_by'] as String?,
        isActive: castToType<int>(data['is_active']),
        uploadedBy: data['uploaded_by'] as String?,
        notificationFrequencyAmount:
            castToType<int>(data['notification_frequency_amount']),
        notificationFrequencyMinute:
            castToType<int>(data['notification_frequency_minute']),
        eventImageList: getDataList(data['event_image_list']),
        startDatetime: data['start_datetime'] as DateTime?,
        endDatetime: data['end_datetime'] as DateTime?,
        uploadedAt: data['uploaded_at'] as DateTime?,
        createdAt: data['created_at'] as DateTime?,
      );

  static EventDataModelStruct? maybeFromMap(dynamic data) => data is Map
      ? EventDataModelStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'event_id': _eventId,
        'event_name': _eventName,
        'description': _description,
        'created_by': _createdBy,
        'is_active': _isActive,
        'uploaded_by': _uploadedBy,
        'notification_frequency_amount': _notificationFrequencyAmount,
        'notification_frequency_minute': _notificationFrequencyMinute,
        'event_image_list': _eventImageList,
        'start_datetime': _startDatetime,
        'end_datetime': _endDatetime,
        'uploaded_at': _uploadedAt,
        'created_at': _createdAt,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'event_id': serializeParam(
          _eventId,
          ParamType.int,
        ),
        'event_name': serializeParam(
          _eventName,
          ParamType.String,
        ),
        'description': serializeParam(
          _description,
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
        'uploaded_by': serializeParam(
          _uploadedBy,
          ParamType.String,
        ),
        'notification_frequency_amount': serializeParam(
          _notificationFrequencyAmount,
          ParamType.int,
        ),
        'notification_frequency_minute': serializeParam(
          _notificationFrequencyMinute,
          ParamType.int,
        ),
        'event_image_list': serializeParam(
          _eventImageList,
          ParamType.String,
          isList: true,
        ),
        'start_datetime': serializeParam(
          _startDatetime,
          ParamType.DateTime,
        ),
        'end_datetime': serializeParam(
          _endDatetime,
          ParamType.DateTime,
        ),
        'uploaded_at': serializeParam(
          _uploadedAt,
          ParamType.DateTime,
        ),
        'created_at': serializeParam(
          _createdAt,
          ParamType.DateTime,
        ),
      }.withoutNulls;

  static EventDataModelStruct fromSerializableMap(Map<String, dynamic> data) =>
      EventDataModelStruct(
        eventId: deserializeParam(
          data['event_id'],
          ParamType.int,
          false,
        ),
        eventName: deserializeParam(
          data['event_name'],
          ParamType.String,
          false,
        ),
        description: deserializeParam(
          data['description'],
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
        uploadedBy: deserializeParam(
          data['uploaded_by'],
          ParamType.String,
          false,
        ),
        notificationFrequencyAmount: deserializeParam(
          data['notification_frequency_amount'],
          ParamType.int,
          false,
        ),
        notificationFrequencyMinute: deserializeParam(
          data['notification_frequency_minute'],
          ParamType.int,
          false,
        ),
        eventImageList: deserializeParam<String>(
          data['event_image_list'],
          ParamType.String,
          true,
        ),
        startDatetime: deserializeParam(
          data['start_datetime'],
          ParamType.DateTime,
          false,
        ),
        endDatetime: deserializeParam(
          data['end_datetime'],
          ParamType.DateTime,
          false,
        ),
        uploadedAt: deserializeParam(
          data['uploaded_at'],
          ParamType.DateTime,
          false,
        ),
        createdAt: deserializeParam(
          data['created_at'],
          ParamType.DateTime,
          false,
        ),
      );

  @override
  String toString() => 'EventDataModelStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is EventDataModelStruct &&
        eventId == other.eventId &&
        eventName == other.eventName &&
        description == other.description &&
        createdBy == other.createdBy &&
        isActive == other.isActive &&
        uploadedBy == other.uploadedBy &&
        notificationFrequencyAmount == other.notificationFrequencyAmount &&
        notificationFrequencyMinute == other.notificationFrequencyMinute &&
        listEquality.equals(eventImageList, other.eventImageList) &&
        startDatetime == other.startDatetime &&
        endDatetime == other.endDatetime &&
        uploadedAt == other.uploadedAt &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode => const ListEquality().hash([
        eventId,
        eventName,
        description,
        createdBy,
        isActive,
        uploadedBy,
        notificationFrequencyAmount,
        notificationFrequencyMinute,
        eventImageList,
        startDatetime,
        endDatetime,
        uploadedAt,
        createdAt
      ]);
}

EventDataModelStruct createEventDataModelStruct({
  int? eventId,
  String? eventName,
  String? description,
  String? createdBy,
  int? isActive,
  String? uploadedBy,
  int? notificationFrequencyAmount,
  int? notificationFrequencyMinute,
  DateTime? startDatetime,
  DateTime? endDatetime,
  DateTime? uploadedAt,
  DateTime? createdAt,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    EventDataModelStruct(
      eventId: eventId,
      eventName: eventName,
      description: description,
      createdBy: createdBy,
      isActive: isActive,
      uploadedBy: uploadedBy,
      notificationFrequencyAmount: notificationFrequencyAmount,
      notificationFrequencyMinute: notificationFrequencyMinute,
      startDatetime: startDatetime,
      endDatetime: endDatetime,
      uploadedAt: uploadedAt,
      createdAt: createdAt,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

EventDataModelStruct? updateEventDataModelStruct(
  EventDataModelStruct? eventDataModel, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    eventDataModel
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addEventDataModelStructData(
  Map<String, dynamic> firestoreData,
  EventDataModelStruct? eventDataModel,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (eventDataModel == null) {
    return;
  }
  if (eventDataModel.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && eventDataModel.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final eventDataModelData =
      getEventDataModelFirestoreData(eventDataModel, forFieldValue);
  final nestedData =
      eventDataModelData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = eventDataModel.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getEventDataModelFirestoreData(
  EventDataModelStruct? eventDataModel, [
  bool forFieldValue = false,
]) {
  if (eventDataModel == null) {
    return {};
  }
  final firestoreData = mapToFirestore(eventDataModel.toMap());

  // Add any Firestore field values
  mapToFirestore(eventDataModel.firestoreUtilData.fieldValues)
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getEventDataModelListFirestoreData(
  List<EventDataModelStruct>? eventDataModels,
) =>
    eventDataModels
        ?.map((e) => getEventDataModelFirestoreData(e, true))
        .toList() ??
    [];
