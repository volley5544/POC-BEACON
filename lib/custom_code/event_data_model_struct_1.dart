import 'package:cloud_firestore/cloud_firestore.dart';
import '/custom_code/booth_data_model_struct_new.dart';

class EventDataModelStruct1 {
  final int eventId;
  final String eventName;
  final String description;
  final String createdBy;
  final int isActive;
  final String uploadedBy;
  final int notificationFrequencyAmount;
  final int notificationFrequencyMinute;
  final List<String> eventImageList;
  final DateTime startDatetime;
  final DateTime endDatetime;
  final DateTime uploadedAt;
  final DateTime createdAt;
  final List<BoothDataModelStructNew> boothList;

  EventDataModelStruct1(
      {required this.eventId,
      required this.eventName,
      required this.description,
      required this.createdBy,
      required this.isActive,
      required this.uploadedBy,
      required this.notificationFrequencyAmount,
      required this.notificationFrequencyMinute,
      required this.eventImageList,
      required this.startDatetime,
      required this.endDatetime,
      required this.uploadedAt,
      required this.createdAt,
      required this.boothList});

  factory EventDataModelStruct1.fromMap(Map<String, dynamic> map) {
    return EventDataModelStruct1(
      eventId: map['event_id'] ?? 0,
      eventName: map['event_name'] ?? '',
      description: map['description'] ?? '',
      createdBy: map['created_by'] ?? '',
      isActive: map['is_active'] ?? 1,
      uploadedBy: map['uploaded_by'] ?? '',
      notificationFrequencyAmount: map['notification_frequency_amount'] ?? 0,
      notificationFrequencyMinute: map['notification_frequency_minute'] ?? 0,
      eventImageList: map['event_image_list'] != null
          ? map['event_image_list'].cast<String>()
          : [],
      startDatetime: map['start_datetime'] != null
          ? map['start_datetime'].toDate()
          : Timestamp.now().toDate(),
      endDatetime: map['end_datetime'] != null
          ? map['end_datetime'].toDate()
          : Timestamp.now().toDate(),
      uploadedAt: map['uploaded_at'] != null
          ? map['uploaded_at'].toDate()
          : Timestamp.now().toDate(),
      createdAt: map['created_at'] != null
          ? map['created_at'].toDate()
          : Timestamp.now().toDate(),
      boothList: [],
    );
  }
}
