import 'package:cloud_firestore/cloud_firestore.dart';
import '/flutter_flow/lat_lng.dart';
import '/custom_code/survey_data_model_struct_new.dart';

class UserActivityDataModelStructNew {
  final String uid;
  final DateTime checkInTime;
  final LatLng checkInLocation;
  final bool isCompleted;
  final DateTime createdAt;
  final String createdBy;
  final int isActive;
  final DateTime updatedAt;
  final String updatedBy;
  final int activityId;
  final String associatedEventId;
  final String associatedBoothId;
  final bool isSurveyed;
  final SurveyDataModelStructNew surveyData;
  final String boothName;
  final int eventId;
  final int boothId;

  UserActivityDataModelStructNew({
    required this.uid,
    required this.checkInTime,
    required this.checkInLocation,
    required this.isCompleted,
    required this.createdAt,
    required this.createdBy,
    required this.isActive,
    required this.updatedAt,
    required this.updatedBy,
    required this.activityId,
    required this.associatedEventId,
    required this.associatedBoothId,
    required this.isSurveyed,
    required this.surveyData,
    required this.boothName,
    required this.eventId,
    required this.boothId,
  });

  factory UserActivityDataModelStructNew.fromMap(Map<String, dynamic> map) {
    return UserActivityDataModelStructNew(
      uid: map['uid'] ?? '',
      checkInTime: map['check_in_time'] != null
          ? map['check_in_time'].toDate()
          : Timestamp.now().toDate(),
      checkInLocation: map['check_in_location'] != null
          ? LatLng(map['check_in_location'].latitude,
              map['check_in_location'].longitude)
          : LatLng(0.0, 0.0),
      isCompleted: map['is_completed'] ?? false,
      createdAt: map['created_at'] != null
          ? map['created_at'].toDate()
          : Timestamp.now().toDate(),
      createdBy: map['created_by'] ?? '',
      isActive: map['is_active'] ?? 0,
      updatedAt: map['updated_at'] != null
          ? map['updated_at'].toDate()
          : Timestamp.now().toDate(),
      updatedBy: map['updated_by'] ?? '',
      activityId: map['activity_id'] ?? 0,
      associatedEventId: map['associated_event_id'] ?? '',
      associatedBoothId: map['associated_booth_id'] ?? '',
      isSurveyed: map['is_surveyed'] ?? false,
      surveyData: map['is_surveyed']
          ? SurveyDataModelStructNew.fromMap(map['survey_data'])
          : new SurveyDataModelStructNew(
              boothId: 0,
              createdAt: DateTime.now(),
              createdBy: '',
              eventId: 0,
              feedback: '',
              isActive: 0,
              rating: 0,
              surveyId: 0,
              uid: '',
              updatedAt: DateTime.now(),
              updatedBy: ''),
      boothName: map['booth_name'] ?? 0,
      eventId: map['event_id'] ?? 0,
      boothId: map['booth_id'] ?? 0,
    );
  }
}
