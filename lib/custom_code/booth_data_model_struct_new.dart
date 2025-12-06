import 'package:cloud_firestore/cloud_firestore.dart';

class BoothDataModelStructNew {
  final int boothId;
  final String boothName;
  final String description;
  final double notificationDistance;
  final String associatedEventId;
  final DateTime createdAt;
  final String createdBy;
  final int isActive;
  final String uploadedBy;
  final DateTime uploadedAt;
  final int eventId;
  final List<String> boothImageList;
  final String deviceUuid;
  final double txPower;
  final double pathLossExponent;
  final double smoothingAlpha;
  final double maxDistanceCap;
  final DateTime calibratedAt;
  final String environmentLabel;

  BoothDataModelStructNew({
    required this.boothId,
    required this.boothName,
    required this.description,
    required this.notificationDistance,
    required this.associatedEventId,
    required this.createdAt,
    required this.createdBy,
    required this.isActive,
    required this.uploadedBy,
    required this.uploadedAt,
    required this.eventId,
    required this.boothImageList,
    required this.deviceUuid,
    required this.txPower,
    required this.pathLossExponent,
    required this.smoothingAlpha,
    required this.maxDistanceCap,
    required this.calibratedAt,
    required this.environmentLabel,
  });

  factory BoothDataModelStructNew.fromMap(Map<String, dynamic> map) {
    return BoothDataModelStructNew(
      boothId: map['booth_id'] ?? 0,
      boothName: map['booth_name'] ?? '',
      description: map['description'] ?? '',
      notificationDistance:
          (map['notification_distance'] as num?)?.toDouble() ?? 0.0,
      associatedEventId: map['associated_event_id'] != null
          ? '${map['associated_event_id']}'
          : '',
      createdAt: map['created_at'] != null
          ? map['created_at'].toDate()
          : Timestamp.now().toDate(),
      createdBy: map['created_by'] ?? '',
      isActive: map['is_active'] ?? 1,
      uploadedBy: map['uploaded_by'] ?? '',
      uploadedAt: map['uploaded_at'] != null
          ? map['uploaded_at'].toDate()
          : Timestamp.now().toDate(),
      eventId: map['event_id'] ?? 0,
      boothImageList: map['booth_image_list'] != null
          ? map['booth_image_list'].cast<String>()
          : [],
      deviceUuid: map['device_uuid'] ?? '',
      txPower: (map['tx_power'] as num?)?.toDouble() ?? 0.0,
      pathLossExponent: (map['path_loss_exponent'] as num?)?.toDouble() ?? 0.0,
      smoothingAlpha: (map['smoothing_alpha'] as num?)?.toDouble() ?? 0.0,
      maxDistanceCap: (map['max_distance_cap'] as num?)?.toDouble() ?? 0.0,
      calibratedAt: map['calibrated_at'] != null
          ? map['calibrated_at'].toDate()
          : Timestamp.now().toDate(),
      environmentLabel: map['environment_label'] ?? '',
    );
  }
}
