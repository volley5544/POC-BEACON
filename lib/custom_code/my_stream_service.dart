import 'dart:async';
import 'package:dchs_flutter_beacon/dchs_flutter_beacon.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import '/backend/schema/structs/index.dart';
import '/backend/schema/events_record.dart';
import '/custom_code/event_data_model_struct_1.dart';
import '/custom_code/booth_data_model_struct_new.dart';
import '/custom_code/user_notification_data_model_struct.dart';
import '/custom_code/user_activity_data_model_struct_new.dart';
import '/custom_code/register_data_model_struct.dart';
import 'package:flutter/services.dart';
import '/auth/firebase_auth/auth_util.dart';
import 'package:rxdart/rxdart.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';
import 'package:flutter/widgets.dart';

class MyStreamService with WidgetsBindingObserver {
  static final MyStreamService _instance = MyStreamService._internal();
  factory MyStreamService() => _instance;

  // bool isLogging = false;

  MyStreamService._internal() {
    // ✅ เริ่มฟังสถานะ lifecycle ของแอป เพิ่ม observer ตอนสร้าง service..
    WidgetsBinding.instance.addObserver(this);

    // ✅ โหลดค่า config ทันทีเมื่อสร้าง instance
    FirebaseFirestore.instance
        .collection('app_config')
        .doc('test_mode')
        .snapshots()
        .listen((snapshot) {
      if (snapshot.exists) {
        isTestMode = snapshot.data()?['isTestMode'] ?? false;
        // print('🔥 Test mode updated from Firebase: $isTestMode');
      }
    });
  }

  static DateTime? _lastUpdateTime;
  bool isTestMode = false;

  StreamSubscription<RangingResult>? _streamRanging;
  StreamSubscription? _subEvents;
  StreamSubscription? _subBooth;
  final ValueNotifier<List<String>> beaconDistance = ValueNotifier([]);
  final ValueNotifier<List<String>> beaconId = ValueNotifier([]);
  final ValueNotifier<List<String>> beaconRssi = ValueNotifier([]);

  List<Map<String, dynamic>> eventDocs = [];
  List<EventDataModelStruct1> eventData = [];

  List<Map<String, dynamic>> boothDocs = [];
  List<BoothDataModelStructNew> boothData = [];

  List<Map<String, dynamic>> userNotiDocs = [];
  List<UserNotificationDataModelStruct> userNotiData = [];

  List<Map<String, dynamic>> userActivityDocs = [];
  List<UserActivityDataModelStructNew> userActivityData = [];

  List<Map<String, dynamic>> eventRegisterDocs = [];
  List<RegisterDataModelStruct> eventRegisterData = [];

  final Map<String, List<double>> _rssiHistory = {};
  final Map<String, double> _emaMap = {};
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  // 🔴 1. ค่าคงที่สำหรับการปรับเทียบ (ต้องแทนที่ด้วยค่าที่วัดได้จริง)
  // **สำคัญ:** แทนที่ค่าเหล่านี้ด้วยผลลัพธ์จากฟังก์ชัน calculateCalibrationParams
  // static const double TX_POWER_CALIBRATED = -59.5; // ตัวอย่าง: ค่า RSSI ที่วัดได้จริง ณ 1 เมตร
  // static const double PATH_LOSS_EXPONENT_N = 2.75; // ตัวอย่าง: ค่า Path Loss Exponent ที่คำนวณได้

  // static const double TX_POWER_CALIBRATED = -55.33844294323458;///
  // static const double PATH_LOSS_EXPONENT_N = 4.064296685954029;
  //
  // // 🟢 2. ค่าคงที่สำหรับ Exponential Moving Average (EMA)
  // // ใช้สำหรับกรอง RSSI: ค่า α ยิ่งน้อย (ใกล้ 0) ยิ่งเสถียร (ตอบสนองช้า)
  // // static const double EMA_ALPHA = 0.2; // แนะนำ 0.1 - 0.3 สำหรับความเสถียรสูง
  // static const double EMA_ALPHA = 0.15; // แนะนำ 0.1 - 0.3 สำหรับความเสถียรสูง

  // เก็บค่า RSSI ล่าสุดที่ถูก Smoothing แล้วของแต่ละ Beacon
  // Map<major:minor, smoothedRssi>
  Map<String, double> _smoothedRssiCache = {};

// List<String> get beaconId => _beaconId;
// List<String> get beaconDistance => _beaconDistance;

  bool? _wasInRange;
  bool _registerInviteSent = false; // กันไม่ให้ยิงซ้ำ

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // print("🟢 แอปกลับมา Foreground → รีเซ็ตสถานะ beacon");
      // FFAppState().isAppForeground = true;

      // ✅ รีเซ็ตสถานะค้างทั้งหมด
      _wasInRange = null;
      FFAppState().beaconIdList = [];
      FFAppState().beaconDistanceList = [];
      FFAppState().beaconRssiList = [];

      // ✅ รีสตาร์ทการฟังสัญญาณใหม่
      if (_streamRanging != null) {
        _streamRanging!.cancel();
        _streamRanging = null;
      }

      // เรียก startListening() ใหม่ (ต้องมี stream จาก plugin beacon)
      // ตัวอย่าง:
      // startListening(FlutterBeacon.ranging(...));
    }

    if (state == AppLifecycleState.paused) {
      // print("🔴 แอปไป Background → หยุดฟังสัญญาณชั่วคราว");
      // FFAppState().isAppForeground = false;
      _streamRanging?.pause();
    }
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _streamRanging?.cancel();
    _subEvents?.cancel();
    _subBooth?.cancel();
  }

//   DateTime lastScanTime = DateTime.now();
//
// // Threshold จาก Mean − 2σ ของแต่ละอุปกรณ์
//   final Map<String, double> boothThreshold = {
//     "UUID_BOOTH1": -71,
//     "UUID_BOOTH2": -73.8,
//     "UUID_BOOTH3": -75.5,
//     "UUID_BOOTH4_2": -82.5,
//     "UUID_BOOTH4_3": -84.4,
//   };
//
//   void startListening(Stream<RangingResult> myStream) {
//     _streamRanging ??= myStream.listen((result) async {
//
//       // 📌 จำกัดการประมวลผลทุก 200ms
//       if (DateTime.now().difference(lastScanTime).inMilliseconds < 200) {
//         return;
//       }
//       lastScanTime = DateTime.now();
//
//       if (result.beacons.isEmpty) return;
//
//       // 📌 ใช้ RSSI แทน accuracy
//       result.beacons.sort((a, b) => b.rssi.compareTo(a.rssi));
//       final nearest = result.beacons;
//
//       // 📌 Update global state
//       beaconId.value = nearest.map((e) => e.proximityUUID).toList();
//       FFAppState().beaconIdList = beaconId.value;
//
//       FFAppState().beaconRssiList =
//           nearest.map((e) => e.rssi.toString()).toList();
//
//       if (FFAppState().isLogging) startPrintRawRSSIContinuous();
//
//       // 📌 เริ่มกรอง event
//       final matchingEvents = eventData
//           .map((event) {
//
//         // Filter booths by BEACON RSSI
//         final matchedBooths = event.boothList.where((booth) {
//
//           final uuid = booth.deviceUuid;
//
//           // หา index
//           final idx = FFAppState().beaconIdList.indexOf(uuid);
//           if (idx == -1) return false;
//
//           final rawRssi =
//               double.tryParse(FFAppState().beaconRssiList[idx]) ?? -99;
//
//           // Threshold ของแต่ละบูธ
//           final threshold = boothThreshold[uuid] ?? -80;
//
//           // ⭐ ตัดสินด้วย RSSI
//           return rawRssi >= threshold;
//
//         }).toList();
//
//         // ส่งกลับ event ที่เหลือเฉพาะบูธที่ match
//         return event.copyWith(
//           boothList: matchedBooths,
//         );
//       })
//           .where((event) => event.boothList.isNotEmpty)
//           .toList();
//
//       // 📌 ส่ง Noti
//       if (matchingEvents.isNotEmpty) {
//         await Future.wait(
//           matchingEvents.expand((event) =>
//               event.boothList.map((booth) async {
//
//                 await createUserNotificationDoc(event, booth);
//                 await createDetectionLog(event, booth);
//                 await cleanupOldDetections(event);
//                 await updateBoothCountsIfNeeded(event);
//
//               })),
//         );
//       }
//     });
//   }

  DateTime lastScanTime = DateTime.now();

  // Threshold จาก Mean − 2σ ของแต่ละอุปกรณ์
  // final Map<String, double> boothThreshold = {
  //   "UUID_BOOTH1": -71,
  //   "UUID_BOOTH2": -73.8,
  //   "UUID_BOOTH3": -75.5,
  //   "UUID_BOOTH4_2": -82.5,
  //   "UUID_BOOTH4_3": -84.4,
  // };

  void startListening(Stream<RangingResult> myStream) {
    List<EventDataModelStruct1> matchingEvents = [];
    _streamRanging ??= myStream.listen((result) async {
      // print('in ranging.listen');
      // print('🎧 Start listening... Test mode: $isTestMode');

      // ⏳ Limit processing every 200 ms
      if (DateTime.now().difference(lastScanTime).inMilliseconds < 200) {
        return;
      }
      lastScanTime = DateTime.now();

      if (result.beacons.isEmpty) return;

      if (result.beacons.isNotEmpty) {
        // เรียงตามความใกล้
        result.beacons.sort((a, b) => a.accuracy.compareTo(b.accuracy));
        final nearest = result.beacons;

        // Update global state
        beaconId.value = nearest.map((e) => e.proximityUUID).toList();
        FFAppState().beaconIdList = beaconId.value;
        beaconRssi.value = nearest.map((e) => e.rssi.toString()).toList();
        FFAppState().beaconRssiList =
            nearest.map((e) => e.rssi.toString()).toList();

        if (FFAppState().isLogging) startPrintRawRSSIContinuous();

        FFAppState().beaconDistanceList =
            nearest.map((e) => e.accuracy.toStringAsFixed(2)).toList();

        // if (FFAppState().isLogging) {
        //   // 🟢 เรียก log แค่ครั้งเดียวเท่านั้น
        //   // isLogging = true;
        //   startPrintRawRSSIContinuous();
        // }
        // print('🛰️ Beacon Map Updated: ${FFAppState().beaconDistanceList}');

        // Convert beaconId + beaconDistance into a Map for easy lookup แปลง beaconId + distance เป็น Map สำหรับ lookup ภายหลัง
        // Map<String, double> beaconMap = {
        //   for (int i = 0; i < beaconId.value.length; i++)
        //     beaconId.value[i]: double.parse('${beaconDistance.value[i]}')
        // };
        final Map<String, double> beaconRssiMap = {
          for (int i = 0; i < FFAppState().beaconIdList.length; i++)
            FFAppState().beaconIdList[i]:
                double.tryParse(FFAppState().beaconRssiList[i]) ?? -99,
        };

        // print('🛰️ Beacon Map: $beaconMap');

        // FFAppState().beaconNameList = nearest.map((e) => e.macAddress).toList();
        //safeSetState((){});

        if (true) {
          // matchingEvents = eventData.where((event) {
          //   return event.boothList.any((booth) {
          //     final beaconDist = beaconMap['${booth.deviceUuid}'];
          //     if (beaconDist == null) return false;
          //
          //     return beaconDist
          //         booth.notificationDistance; // ✅ extra condition
          //   });
          // }).toList();

          matchingEvents = eventData
              .map((event) {
                // Filter booths by condition
                // final matchedBooths = evefinal beaconDist = beaconMap['${booth.deviceUuid}']nt.boothList.where((booth) {
                //   ;
                //   return beaconDist != null &&
                //       beaconDist <= booth.notificationDistance;
                // }).toList();

                final matchedBooths = event.boothList.where((booth) {
                  final rawRssi = beaconRssiMap[booth.deviceUuid];
                  if (rawRssi == null) return false;

                  final threshold = booth.rssiThreshold ?? 0;

                  print('----matchedBooths----');
                  print(threshold);

                  return rawRssi >= -threshold;
                }).toList();

                // Return event with only matching booths
                return EventDataModelStruct1(
                    eventId: event.eventId,
                    eventName: event.eventName,
                    description: event.description,
                    createdBy: event.createdBy,
                    isActive: event.isActive,
                    uploadedBy: event.uploadedBy,
                    notificationFrequencyAmount:
                        event.notificationFrequencyAmount,
                    notificationFrequencyMinute:
                        event.notificationFrequencyMinute,
                    notificationFrequencySecond:
                        event.notificationFrequencySecond,
                    eventImageList: event.eventImageList,
                    startDatetime: event.startDatetime,
                    endDatetime: event.endDatetime,
                    uploadedAt: event.uploadedAt,
                    createdAt: event.createdAt,
                    boothList: matchedBooths, // ✅ only matched booths
                    docRef: event.docRef);
              })
              .where((event) =>
                  event.boothList.isNotEmpty) // keep only events with matches
              .toList();

          // print("Found ${matchingEvents.length} matching events");

          if (matchingEvents.length > 0) {
            // HapticFeedback.heavyImpact();
            // print('in range Beac');

            await Future.wait(
              matchingEvents
                  .expand((event) => event.boothList.map((booth) async {
                        // ✅ ส่ง noti และบันทึก log เฉพาะเมื่อผ่านเงื่อนไขแล้ว
                        await createUserNotificationDoc(
                            event, booth); // เรียก function เดิม
                        await createDetectionLog(
                            event, booth); // เรียก function ใหม่ เก็บ detection
                        await cleanupOldDetections(event);
                        await updateBoothCountsIfNeeded(event);
                      })),
            );
          } else {
            print('not in range Beac');
          }
        }
      }
      // handle data
    });
  }

  void listenEvent() {
    _subEvents = FirebaseFirestore.instance
        .collection('events')
        .where('is_active', isEqualTo: 0)
        .snapshots()
        .listen((snapshot) {
      eventDocs = snapshot.docs.map((d) => d.data()).toList();
      //eventData = snapshot;//EventDataModelStruct.fromMap(Map(eventDocs));
      eventData = eventDocs
          .map(
            (doc) => EventDataModelStruct1.fromMap(doc),
          )
          .toList();
      // print("Collection1 updated: ${eventDocs.length} docs");
      // print('object');
      // print('eventName : ${eventDocs.first}');
      // print('eventName : ${eventData.first.startDatetime}');
      // print('allEvent5544 : ${snapshot.length}');
    });

    // for (var doc in snapshot.docs) {
    //   print("Order: ${doc.id} => ${doc.data()}");
    // }
  }

  void listenBooth() {
    FirebaseFirestore.instance
        .collectionGroup("booths")
        .snapshots()
        .listen((snapshot) {
      boothDocs = snapshot.docs.map((d) => d.data()).toList();
      // print('volley5544123');
      // print(boothDocs.first);
      boothData = boothDocs
          .map(
            (doc) => BoothDataModelStructNew.fromMap(doc),
          )
          .toList();
      // print('Booth5544 : ${boothData[3].boothName}');
    });
  }

  void listenEventWithBooths() {
    queryEventsWithBooths5544().listen((eventList) {
      eventData = eventList;
      // print('qwofjhweoifjew : ${eventData[4].eventId}');
      // print('qwofjhweoifjew1 : ${eventData[4].boothList[2].notificationDistance}');
    });
  }

  Stream<List<EventDataModelStruct1>> queryEventsWithBooths5544() {
    final eventsStream = FirebaseFirestore.instance
        .collection("events")
        .where("is_active", isEqualTo: 0)
        .where("start_datetime", isLessThanOrEqualTo: DateTime.now())
        .where("end_datetime", isGreaterThanOrEqualTo: DateTime.now())
        .snapshots();

    final boothsStream =
        FirebaseFirestore.instance.collectionGroup("booths").snapshots();

    return Rx.combineLatest2(
      eventsStream,
      boothsStream,
      (QuerySnapshot eventSnapshot, QuerySnapshot boothSnapshot) {
        // Convert booths first
        final allBooths = boothSnapshot.docs
            .map((doc) => BoothDataModelStructNew.fromMap(
                doc.data() as Map<String, dynamic>))
            .toList();

        // Convert events and attach booths
        return eventSnapshot.docs.map((eventDoc) {
          final eventDataNew1 = EventDataModelStruct1.fromMap(
              eventDoc.data() as Map<String, dynamic>);

          final boothList = allBooths
              .where(
                  (b) => b.eventId == eventDataNew1.eventId) // join by eventId
              .toList();

          return EventDataModelStruct1(
              eventId: eventDataNew1.eventId,
              eventName: eventDataNew1.eventName,
              description: eventDataNew1.description,
              createdBy: eventDataNew1.createdBy,
              isActive: eventDataNew1.isActive,
              uploadedBy: eventDataNew1.uploadedBy,
              notificationFrequencyAmount:
                  eventDataNew1.notificationFrequencyAmount,
              notificationFrequencyMinute:
                  eventDataNew1.notificationFrequencyMinute,
              notificationFrequencySecond:
                  eventDataNew1.notificationFrequencySecond,
              eventImageList: eventDataNew1.eventImageList,
              startDatetime: eventDataNew1.startDatetime,
              endDatetime: eventDataNew1.endDatetime,
              uploadedAt: eventDataNew1.uploadedAt,
              createdAt: eventDataNew1.createdAt,
              boothList: boothList,
              docRef: eventDoc.id);
        }).toList();
      },
    );
  }

  Stream<List<EventDataModelStruct1>> queryEventsWithBooths() {
    return FirebaseFirestore.instance
        .collection("events")
        .where("is_active", isEqualTo: 0)
        .orderBy("event_id", descending: true)
        .snapshots()
        .asyncMap((eventSnapshot) async {
      List<EventDataModelStruct1> eventTemp = [];

      for (var eventDoc in eventSnapshot.docs) {
        final eventDataNew = EventDataModelStruct1.fromMap(eventDoc.data());

        // Listen to booth subcollection
        final boothSnapshot = await eventDoc.reference
            .collection("booths")
            .orderBy("booth_id", descending: true)
            .get(); // one-time read, OR replace with .snapshots() if you want nested listeners

        List<BoothDataModelStructNew> boothList = boothSnapshot.docs
            .map((doc) => BoothDataModelStructNew.fromMap(doc.data()))
            .toList();

        eventTemp.add(
          EventDataModelStruct1(
              eventId: eventDataNew.eventId,
              eventName: eventDataNew.eventName,
              description: eventDataNew.description,
              createdBy: eventDataNew.createdBy,
              isActive: eventDataNew.isActive,
              uploadedBy: eventDataNew.uploadedBy,
              notificationFrequencyAmount:
                  eventDataNew.notificationFrequencyAmount,
              notificationFrequencyMinute:
                  eventDataNew.notificationFrequencyMinute,
              notificationFrequencySecond:
                  eventDataNew.notificationFrequencySecond,
              eventImageList: eventDataNew.eventImageList,
              startDatetime: eventDataNew.startDatetime,
              endDatetime: eventDataNew.endDatetime,
              uploadedAt: eventDataNew.uploadedAt,
              createdAt: eventDataNew.createdAt,
              boothList: boothList,
              docRef: eventDataNew.docRef),
        );
      }

      return eventTemp;
    });
  }

  void listenUserNotification() async {
    // print('currentUserUid5544 : ${currentUserUid}');
    FirebaseFirestore.instance
        .collection("users")
        .doc("${currentUserUid}")
        .collection("notifications")
        .snapshots()
        .listen((snapshot) {
      userNotiDocs = snapshot.docs.map((d) => d.data()).toList();
      // print('userDocLength : ${snapshot.docs.map((d) => d.data()).toList()}');
      // print('volley5544123');
      // print(boothDocs.first);
      userNotiData = userNotiDocs
          .map(
            (doc) => UserNotificationDataModelStruct.fromMap(doc),
          )
          .toList();
      // print('Booth5544 : ${boothData[3].boothName}');
      // print('userNoti5544 : ${userNotiData.length}');
      List<UserNotificationDataModelStruct> filteredNotiType5544 = userNotiData
          .where(
              (noti) => noti.notiType == 'register_invite' && noti.eventId == 2)
          .toList();

      // print('filteredNotiType5544 : ${filteredNotiType5544.length}');
    });
  }

  void listenUserActivity() async {
    FirebaseFirestore.instance
        .collection("users")
        .doc("${currentUserUid}")
        .collection("UserActivity")
        .where('is_active', isEqualTo: 0)
        .snapshots()
        .listen((snapshot) {
      userActivityDocs = snapshot.docs.map((d) => d.data()).toList();
      // print('userAcDocLength : ${snapshot.docs.map((d) => d.data()).toList()}');
      // print('volley5544123');
      // print(boothDocs.first);
      userActivityData = userActivityDocs
          .map(
            (doc) => UserActivityDataModelStructNew.fromMap(doc),
          )
          .toList();
      // print('Booth5544 : ${boothData[3].boothName}');
      // print('userActivity5544 : ${userActivityData.length}');
      // print('${userActivityData.first.isSurveyed}');
      // print(
      //     'userActivity5544 survey : ${userActivityData.first.surveyData.rating}');
      // print('activity : ${userActivityData.length}');
      // print('activity : ${userActivityData}');
    });
  }

  void listenEventRegister() async {
    FirebaseFirestore.instance
        .collectionGroup("register")
        .snapshots()
        .listen((snapshot) {
      eventRegisterDocs = snapshot.docs.map((d) => d.data()).toList();
      // print('userAcDocLength : ${snapshot.docs.map((d) => d.data()).toList()}');
      // print('volley5544123');
      // print(boothDocs.first);
      eventRegisterData = eventRegisterDocs
          .map(
            (doc) => RegisterDataModelStruct.fromMap(doc),
          )
          .toList();
      // print('Booth5544 : ${boothData[3].boothName}');
      // print('eventRegister5544 : ${eventRegisterData.length}');
      // print('${eventRegisterData.first.eventId}');
      // print('eventRegister5544 uid : ${eventRegisterData.first.uid}');
      // print('register : ${eventRegisterData.length}');

      //filter register ว่าเคยลงทะเบียนevent_idนี้ไปหรือยัง
      List<RegisterDataModelStruct> filteredRegister5544 = eventRegisterData
          .where((register) =>
              register.eventId == 2 && register.uid == '${currentUserUid}')
          .toList();

      // print('filteredRegister : ${filteredRegister5544.length}');
    });
  }

  Future createUserNotificationDoc(
      EventDataModelStruct1 event, BoothDataModelStructNew booth) async {
    // filter noitที่เป็น event_id ที่ beaconจับเจอ และ noti_type เป็นชวนลงทะเบียน
    List<UserNotificationDataModelStruct> filteredNotiType = userNotiData
        .where((noti) =>
            noti.notiType == 'register_invite' && noti.eventId == event.eventId)
        .toList();

    //filter register ว่าเคยลงทะเบียนevent_idนี้ไปหรือยัง
    List<RegisterDataModelStruct> filteredRegister = eventRegisterData
        .where((register) =>
            register.eventId == event.eventId &&
            register.uid == '${currentUserUid}')
        .toList();

    // print('filteredRegister.length : ${filteredRegister.length}');
    // FFAppState().textDebug = '${filteredRegister.length}';
    // print('filteredNotiType.length : ${filteredNotiType.length}');
    // FFAppState().textDebug2 = '${filteredNotiType.length}';
    // if (filteredRegister.length > 0){
    //
    // }

    //ยังไม่เคยลงทะเบียนและยังไม่เคยส่งnotiชวนลงทะเบียนกิจกรรม
    if (filteredRegister.length == 0 && filteredNotiType.length == 0) {
      if (_registerInviteSent) {
        return; // เคยยิงไปแล้ว
      }
      _registerInviteSent = true; // ล็อกครั้งแรก

      // HapticFeedback.heavyImpact();
      //ส่งinapp noti ชวนลงทะเบียนกิจกรรม event_idนี้
      final notiRefRegist = FirebaseFirestore.instance
          .collection('users')
          .doc('${currentUserUid}')
          .collection('notifications');

      await notiRefRegist.add({
        'to_uid': '${currentUserUid}',
        'booth_id': '${booth.boothId}',
        'title': 'เชิญลงทะเบียน',
        'body':
            'ขณะนี้คุณได้อยู่ใกล้กิจกรรม ${event.eventName} เชิญลงทะเบียนเข้าร่วมกิจกรรม',
        'sent_at': FieldValue.serverTimestamp(),
        'event_id': int.parse('${event.eventId}'),
        'send_count': 1,
        'is_read': false,
        'is_deleted': false,
        'noti_type': 'register_invite',
      });

      // ✅ เพิ่มการ log event ใน Firebase Analytics

      // FirebaseAnalytics analytics = FirebaseAnalytics.instance; **ส่ง first time
      // await analytics.logEvent(
      //   name: 'notification_sent',
      //   parameters: {
      //     'event_id': event.eventId,
      //     'booth_id': booth.boothId,
      //     'noti_type': 'register_invite',
      //     'to_uid': currentUserUid,
      //     'timestamp': FieldValue.serverTimestamp(),
      //   },
      // );

      // ✅ เพิ่มการ log event ใน Firebase Analytics
      await analytics.logEvent(
        name: 'register_invite_beacon',
        parameters: {
          'event_id': event.eventId,
          'booth_id': booth.boothId,
          'noti_type': 'register_invite',
          'to_uid': currentUserUid,
          'detect_time': DateTime.now()
              .millisecondsSinceEpoch, // ✅ บังคับเป็น String ชัดเจน
        },
      );

      final sendTime = DateTime.now().millisecondsSinceEpoch;
      //ส่งnoti FCM นอกแอพ ชวนลงทะเบียน event_idนี้
      triggerPushNotification(
        notificationTitle: 'เชิญลงทะเบียน',
        notificationText:
            'ขณะนี้คุณได้อยู่ใกล้กิจกรรม ${event.eventName} เชิญลงทะเบียนเข้าร่วมกิจกรรม',
        notificationSound: 'default',
        userRefs: [currentUserReference!],
        initialPageName: 'EventSelection',
        parameterData: {
          'log_id': '',
          'event_id': event.eventId,
          'booth_id': booth.boothId,
        },
      );

      return;
    }

    if (filteredRegister.length == 0) {
      return;
    }

    List<UserActivityDataModelStructNew> filteredUserActivity = [];
    //filter activity เคยเล่นboothนั้นหรือยัง
    if (userActivityData.isNotEmpty) {
      filteredUserActivity = userActivityData
          .where((activity) =>
              activity.uid == '${currentUserUid}' &&
              activity.eventId == event.eventId &&
              activity.boothId == booth.boothId)
          .toList();
    }
    // FFAppState().textDebug3 = '${filteredUserActivity.length}';

    //เช็คว่าเคยเล่นbooth_idนี้หรือยัง
    if (filteredUserActivity.length != 0) {
      return;
    }

    //filter notiชวนเล่นกิจกรรม
    List<UserNotificationDataModelStruct> filteredNoti = userNotiData
        .where((noti) =>
            noti.eventId == event.eventId &&
            noti.boothId == '${booth.boothId}' &&
            noti.notiType == 'booth_invite')
        .toList();

    //เช็คว่าเคยส่งnotiชวนเล่นกิจกรรมนี้แล้ว
    if (filteredNoti.length != 0) {
      //เช็คว่าจำนวนครั้งที่ส่งnotiไปแล้ว เกินnotificationFrequencyAmountของกิจกรรม ที่setไว้มั้ย
      if (filteredNoti.first.sendCount >=
          (event.notificationFrequencyAmount != null
              ? event.notificationFrequencyAmount
              : 0)) {
        return;
      }
      //ถ้ายังส่งnotiไม่เกินจำนวนครั้ง
      // else {
      //   DateTime nextNotiTime = filteredNoti.first.sentAt
      //       .add(Duration(minutes: event.notificationFrequencyMinute));
      //   //เช็คว่าเวลาที่ส่งnotiชวนเล่นกิจกรรมล่าสุดของevent_idนี้ + กับเวลาnotificationFrequencyMinuteที่setไว้ เลยเวลาปัจจุบันหรือยัง
      //   if (nextNotiTime.isAfter(Timestamp.now().toDate())) {
      //     return;
      //   }
      // }
      else {
        // ใช้สำหรับทดสอบ 144 จุด
        // final freq = event.notificationFrequencySecond ?? 0;
        //
        // // ⭐ แปลงนาที (รองรับทศนิยม) → วินาที
        // final totalSeconds = (freq * 60).round();
        //
        // DateTime nextNotiTime =
        // filteredNoti.first.sentAt.add(Duration(seconds: totalSeconds));
        //
        // // ⭐ ถ้ายังไม่ถึงเวลาที่ควรส่ง noti → ห้ามส่ง
        // if (nextNotiTime.isAfter(DateTime.now())) {
        //   return;
        // }
        /////////////////////////////////////
        final freqMinute = event.notificationFrequencyMinute ?? 0;

        final nextNotiTime = filteredNoti.first.sentAt.add(
          Duration(minutes: freqMinute),
        );

        if (nextNotiTime.isAfter(DateTime.now())) {
          return;
        }
        /////////////////////////////////////

        // DateTime nextNotiTime = filteredNoti.first.sentAt
        //     .add(Duration(minutes: event.notificationFrequencyMinute));
        // //เช็คว่าเวลาที่ส่งnotiชวนเล่นกิจกรรมล่าสุดของevent_idนี้ + กับเวลาnotificationFrequencyMinuteที่setไว้ เลยเวลาปัจจุบันหรือยัง
        // if (nextNotiTime.isAfter(Timestamp.now().toDate())) {
        //   return;
        // }
      }
    }

    //niruemon add
    // 1️⃣ คำนวณระยะล่าสุด
    // final distance = getDistanceOfUuid(booth.deviceUuid);
    // 🧭 1️⃣ อ่านระยะและ RSSI ของ Beacon ปัจจุบัน
    // double? rssi;
    // double calibratedDistance = getDistanceOfUuid(booth.deviceUuid);
    double? rssi;
    double calibratedDistance = 999;
    double calibratedDistance_Rmse = 999;
    bool isStable = false;

    // อ่าน RSSI ดิบจาก FFAppState
    if (FFAppState().beaconIdList.contains(booth.deviceUuid)) {
      final index = FFAppState().beaconIdList.indexOf(booth.deviceUuid);
      rssi = double.tryParse(FFAppState().beaconRssiList[index]) ?? -60;

      final both = await getCalibratedDistance(
        booth,
        booth.deviceUuid,
        rssi!,
      );

      calibratedDistance = both["log_model"]!;
      calibratedDistance_Rmse = both["rmse_model"]!;

      print('calibratedDistance : ${calibratedDistance}');
      print('calibratedDistance_Rmse : ${calibratedDistance_Rmse}');
    }

    // 🔹 ตรวจว่าอยู่ในระยะต่อเนื่องหรือไม่
    isStable = isUserStableNear(booth, calibratedDistance);

    // ✅ Niruemon: บันทึกเมื่อ Beacon ตรวจจับได้
    final logId = await logProximityAndConcurrentUsers(
      event,
      booth,
      rssi: rssi, // ค่า RSSI ล่าสุด
      calibratedDistance: calibratedDistance, // ระยะหลังคาลิเบรต
      calibratedDistance_Rmse: calibratedDistance_Rmse, // ระยะหลังคาลิเบรต
      sent_from_server_time: Timestamp.now(),
      isStable: isStable, // สถานะเสถียร (อยู่ใกล้ต่อเนื่อง)
      boothThreshold: booth.notificationDistance ?? 0,
      source: 'createUserNotificationDoc',
      status: (calibratedDistance <= (booth.notificationDistance ?? 0))
          ? 'in_range'
          : 'out_of_range',
      notiData: {
        // ✅ ส่งเฉพาะข้อมูล noti
        'to_uid': currentUserUid,
        'booth_id': booth.boothId,
        'title':
            'ขณะนี้คุณอยู่ใกล้บูธ ${booth.boothName} (กิจกรรม ${event.eventName})',
        'body': booth.description,
        'sent_at': FieldValue.serverTimestamp(),
        'event_id': event.eventId,
        'send_count': 1,
        'is_read': false,
        'is_deleted': false,
        'noti_type': 'booth_invite',
      },
    );

    final notiRef = FirebaseFirestore.instance
        .collection('users')
        .doc('${currentUserUid}')
        .collection('notifications');

    final query = await notiRef
        .where('event_id', isEqualTo: int.parse('${event.eventId}'))
        .where('noti_type', isEqualTo: 'booth_invite')
        .where('booth_id', isEqualTo: '${booth.boothId}')
        // .where('booth_id'), isEqualTo: '${event.boothList.first}'
        .get();
    //notiกระดิ่ง (inapp)

    //เคยส่งnotiชวนเล่นกิจกรรม event_idนี้แล้ว
    if (query.docs.isNotEmpty) {
      // 👉 update noti doc
      await notiRef.doc(query.docs.first.id).set({
        'booth_id': '${booth.boothId}',
        'sent_at': FieldValue.serverTimestamp(),
        'send_count': int.parse('${query.docs.first.data()['send_count'] + 1}'),
        'is_read': false,
        'is_deleted': false,
      }, SetOptions(merge: true));
    }
    //ยังไม่เคยเคยส่งnotiชวนเล่นกิจกรรม event_idนี้
    else {
      print('query.docs.isEmpty');
      // 👉 create new noti doc
      await notiRef.add({
        'to_uid': '${currentUserUid}',
        'booth_id': '${booth.boothId}',
        'title':
            'ขณะนี้คุณได้อยู่ใกล้บูธ${booth.boothName} (กิจกรรม ${event.eventName})',
        'body': '${booth.description}',
        'sent_at': FieldValue.serverTimestamp(),
        'event_id': int.parse('${event.eventId}'),
        'send_count': 1,
        'is_read': false,
        'is_deleted': false,
        'noti_type': 'booth_invite',
      });
    }

    //noti FCM (นอกแอพ)
    final sendTime = DateTime.now().millisecondsSinceEpoch;
    // print('sendTime');
    // print(sendTime);

    // await analytics.logEvent(
    //   name: 'detect_booth_beacon',
    //   parameters: {
    //     'event_id': event.eventId,
    //     'booth_id': booth.boothId,
    //     'noti_type': 'booth_invite',
    //     'to_uid': currentUserUid,
    //     'title':
    //         'ขณะนี้คุณได้อยู่ใกล้บูธ${booth.boothName} (กิจกรรม ${event.eventName})',
    //     'body': '${booth.description}',
    //     'booth_name': booth.boothName ?? '',
    //     'booth_uuid': booth.deviceUuid ?? '',
    //     'notification_distance': booth.notificationDistance ?? '',
    //     'detect_time':
    //         DateTime.now().millisecondsSinceEpoch, // ✅ บังคับเป็น String ชัดเจน
    //     'log_id': logId ?? '',
    //     // ✅ เพิ่มสถานะ foreground / background
    //     // 'is_background': !FFAppState().isAppForeground ? 1 : 0,
    //     'is_background': 0,
    //     'sent_from_server_time': sendTime,
    //   },
    // );

    await analytics.logEvent(
      name: 'detect_booth_beacon',
      parameters: {
        'event_id': event.eventId,
        'log_id': logId ?? '',
        'to_uid': currentUserUid,
        'noti_type': 'booth_invite',

        // 🔽 booth (ยุบ)
        'booth': jsonEncode({
          'id': booth.boothId,
          'name': booth.boothName ?? '',
          'uuid': booth.deviceUuid ?? '',
        }),

        // 🔽 noti (ยุบ)
        // 'noti': jsonEncode({
        //   'title':
        //   'ขณะนี้คุณได้อยู่ใกล้บูธ${booth.boothName} (กิจกรรม ${event.eventName})',
        //   'body': booth.description ?? '',
        // }),

        'is_background': 0,
        'detect_time': DateTime.now().millisecondsSinceEpoch,
        'sent_from_server_time': sendTime,
      },
    );

    // print('sendTime2 : ');
    // print(sendTime);

    // print('🔔 [DEBUG] triggerPushNotification CALLED');
    // print('🔔 boothName = ${booth.boothName}');
    // print('🔔 eventName = ${event.eventName}');
    // print('🔔 boothId = ${booth.boothId}');
    // print('🔔 logId = $logId');
    // print('🔔 currentUserReference = $currentUserReference');
    //
    // final payload = {
    //   'log_id': logId,
    //   'event_id': event.eventId,
    //   'booth_id': booth.boothId,
    // };
    //
    // print('🔔 [DEBUG] payload = $payload');

    // try {
    print('🔔 [DEBUG] BEFORE triggerPushNotification');
    //ส่ง FCM notiชวนเล่นกิจกรรม
    triggerPushNotification(
      notificationTitle:
          'ขณะนี้คุณได้อยู่ใกล้บูธ${booth.boothName} (กิจกรรม ${event.eventName})',
      notificationText: '${booth.description}',
      notificationSound: 'default',
      userRefs: [currentUserReference!],
      initialPageName: 'Home',
      parameterData: {
        'log_id': logId,
        'event_id': event.eventId,
        'booth_id': booth.boothId,
      },
    );
    print('✅ [DEBUG] triggerPushNotification FINISHED');
    // } catch (e, st) {
    //   print('❌ [ERROR] triggerPushNotification failed');
    //   print(e);
    //   print(st);
    // }
    // print('sendTime3 : ');
    // print(sendTime);
  }

  Future updateUserNotificationDoc(EventDataModelStruct1 event) async {
    final notiRef = FirebaseFirestore.instance
        .collection('users')
        .doc('${currentUserUid}')
        .collection('notifications');

    final query = await notiRef
        .where('event_id', isEqualTo: int.parse('${event.eventId}'))
        .get();

    await notiRef.doc(query.docs.first.id).set({
      'send_count': int.parse('${query.docs.first.data()['send_count'] + 1}'),
    }, SetOptions(merge: true));
  }

  Future<Map<String, dynamic>> getDataFromCollection(String eventId) async {
    // Add your function code here!
    Map<String, dynamic> dataOutput = {};

    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      QuerySnapshot querySnapshot = await firestore
          .collection("users")
          .doc("${currentUserUid}")
          .collection("notifications")
          .where('event_id', isEqualTo: int.parse('${eventId}'))
          .get(); //.where(filterField, isEqualTo: filterValue)

      List<QueryDocumentSnapshot> documents = querySnapshot.docs;

      for (QueryDocumentSnapshot document in documents!) {
        Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;
        if (data != null) {
          dataOutput = data;
        }
      }
    } catch (e) {
      print('Error: $e');
    }
    // print('dataOutput :  $dataOutput');

    return dataOutput;
  }

  /// ✅ ฟังก์ชันดึงข้อมูลอุปกรณ์ (ยี่ห้อ, รุ่น, OS)
  Future<Map<String, String>> getDeviceDetails() async {
    final deviceInfo = DeviceInfoPlugin();
    String deviceBrand = 'unknown';
    String deviceModel = 'unknown';
    String osVersion = 'unknown';

    try {
      if (Platform.isAndroid) {
        final info = await deviceInfo.androidInfo;
        deviceBrand = info.brand ?? 'unknown';
        deviceModel = info.model ?? 'unknown';
        osVersion = 'Android ${info.version.release ?? ''}';
      } else if (Platform.isIOS) {
        final info = await deviceInfo.iosInfo;
        deviceBrand = 'Apple';
        deviceModel = info.utsname.machine ?? info.name ?? 'unknown';
        osVersion = 'iOS ${info.systemVersion ?? ''}';
      }
    } catch (e) {
      print("⚠️ Error fetching device info: $e");
    }

    return {
      'device_brand': deviceBrand,
      'device_model': deviceModel,
      'os_version': osVersion,
    };
  }

  /// niuemon 2025-10-01 ฟังก์ชันสำหรับบันทึกการตรวจจับผู้ใช้ใกล้บูธ
  Future<void> createDetectionLog(
      EventDataModelStruct1 event, BoothDataModelStructNew booth) async {
    try {
      // path: events/{eventId}/detections
      final detectionRef = FirebaseFirestore.instance
          .collection('events')
          // .doc('${event.eventId}')
          .doc(event.docRef)
          .collection('detections');

      // print('createDetectionLog docRef : ${event.docRef}');
      // final detectionRef = eventRef.collection('detections');

      final cutoff = DateTime.now().subtract(const Duration(minutes: 1));

      // 🔍 เช็คว่ามี detection ล่าสุดของ user+booth ใน 1 นาทีแล้วหรือยัง
      final query = await detectionRef
          .where('uid', isEqualTo: currentUserUid)
          .where('booth_id', isEqualTo: booth.boothId)
          .where('detect_timestamp',
              isGreaterThanOrEqualTo: Timestamp.fromDate(cutoff))
          .get();

      if (query.docs.isNotEmpty) {
        // print('Duplicate detection ignored (within 1 minute)');
        return; // ไม่บันทึกซ้ำ
      }

      // Firestore generate id อัตโนมัติ
      final newDoc = detectionRef.doc();

      await newDoc.set({
        'detection_id': newDoc.id, // เก็บ id ที่ firestore สร้างให้
        'booth_id': booth.boothId,
        'event_id': event.eventId,
        'uid': currentUserUid,
        'detect_timestamp': FieldValue.serverTimestamp(),
      });

      // print('Detection saved: ${newDoc.id} for booth ${booth.boothId}');
    } catch (e) {
      print('Error saving detection: $e');
    }
  }

  Future<void> cleanupOldDetections(EventDataModelStruct1 event) async {
    try {
      // print('cleanupOldDetections : ${event.docRef}');

      // final detectionRef = eventRef.collection('detections');
      final detectionRef = FirebaseFirestore.instance
          .collection('events')
          .doc('${event.docRef}')
          .collection('detections');

      final cutoff = DateTime.now().subtract(const Duration(minutes: 10));

      final oldDocs = await detectionRef
          .where('detect_timestamp', isLessThan: Timestamp.fromDate(cutoff))
          .get();

      if (oldDocs.docs.isEmpty) {
        // print('ไม่มีข้อมูลเก่าที่ต้องลบ');
        return;
      }

      for (final doc in oldDocs.docs) {
        await detectionRef.doc(doc.id).delete();
        // print('🗑️ ลบ detection เก่าแล้ว: ${doc.id}');
      }

      // print('Cleanup เสร็จสิ้น ลบ ${oldDocs.docs.length} documents');
    } catch (e) {
      print('Error cleanupOldDetections: $e');
    }
  }

  /// ฟังก์ชันนับจำนวน unique uid ต่อ booth
  Future<Map<DocumentReference, int>> countUniqueUsersPerBooth(
      EventDataModelStruct1 event) async {
    print('countUniqueUsersPerBooth : ${event.docRef}');

    final eventRef =
        FirebaseFirestore.instance.collection('events').doc(event.docRef);

    // โหลด booth docs ทั้งหมดของ event นี้มาก่อน
    final boothSnapshot = await eventRef.collection('booths').get();

    // สร้าง map จาก booth_id (field) → boothDocRef
    final Map<String, DocumentReference> boothIdToRef = {};
    for (final boothDoc in boothSnapshot.docs) {
      final boothData = boothDoc.data();
      final boothIdField = boothData['booth_id'].toString();
      boothIdToRef[boothIdField] = boothDoc.reference;
    }

    // โหลด detection ภายใน 1 นาทีล่าสุด
    final cutoff = DateTime.now().subtract(const Duration(minutes: 1));
    final detectionSnapshot = await eventRef
        .collection('detections')
        .where('detect_timestamp',
            isGreaterThanOrEqualTo: Timestamp.fromDate(cutoff))
        .get();

    // เก็บ unique uid ต่อ booth (ใช้ docRef เป็น key)
    final Map<DocumentReference, Set<String>> boothUsers = {};

    for (final doc in detectionSnapshot.docs) {
      final data = doc.data();
      final boothId = data['booth_id'].toString();
      final uid = data['uid'].toString();

      final boothDocRef = boothIdToRef[boothId]; // หา docRef จาก map

      if (boothDocRef != null) {
        boothUsers.putIfAbsent(boothDocRef, () => <String>{});
        boothUsers[boothDocRef]!.add(uid);
      } else {
        print("⚠️ ไม่เจอ booth doc ที่มี booth_id = $boothId");
      }
    }

    // boothCounts = { boothDocRef: count }
    final Map<DocumentReference, int> boothCounts =
        boothUsers.map((ref, set) => MapEntry(ref, set.length));

    return boothCounts;
  }

  /// ฟังก์ชันอัปเดต booths แต่เฉพาะทุกๆ 1 นาทีเท่านั้น
  Future<void> updateBoothCountsIfNeeded(EventDataModelStruct1 event) async {
    // print('updateBoothCountsIfNeeded');
    final now = DateTime.now();

    // ถ้ายังไม่ครบ 1 นาที → ข้าม
    if (_lastUpdateTime != null &&
        now.difference(_lastUpdateTime!).inMinutes < 1) {
      // print("⏳ ข้ามการอัปเดต (last update: $_lastUpdateTime)");
      return;
    }

    // ✅ นับจำนวน unique user ต่อ booth โดย return เป็น Map<DocumentReference, int>
    final boothCounts = await countUniqueUsersPerBooth(event);

    for (final entry in boothCounts.entries) {
      final boothDocRef = entry.key; // key = DocumentReference ของ booth จริง ๆ
      final count = entry.value;

      // print("📍 BoothRef: ${boothDocRef.path} 👤 $count คน");

      await boothDocRef.set(
        {
          'current_user_count': count,
          'last_updated': FieldValue.serverTimestamp(),
        },
        SetOptions(merge: true), // merge กันฟิลด์อื่นไม่หาย
      );
    }

    // เก็บเวลาอัปเดตล่าสุด
    _lastUpdateTime = now;
    // print("✅ อัปเดต booth counts เสร็จสิ้น เวลา: $_lastUpdateTime");
  }

  Future<String?> logProximityAndConcurrentUsers(
    EventDataModelStruct1 event,
    BoothDataModelStructNew booth, {
    required double? rssi, // ค่าที่อ่านจาก BLE ล่าสุด
    required double? calibratedDistance, // ระยะคาลิเบรตแล้ว
    required double? calibratedDistance_Rmse, // ระยะคาลิเบรตแล้ว
    required Timestamp? sent_from_server_time,
    required bool isStable, // อยู่ใกล้บูธต่อเนื่องครบเวลา
    required double? boothThreshold, // threshold เฉพาะของบูธ
    String source = 'createUserNotificationDoc', // ✅ default
    String status = 'in_range', // ✅ default
    Map<String, dynamic>? notiData, // ข้อมูล noti (เช่น title, body)
  }) async {
    try {
      // print('🛰 logProximityAndConcurrentUsers: ${booth.boothName}');

      final uid = currentUserUid;
      final int eventId = event.eventId;
      final int boothId = booth.boothId;
      final now = DateTime.now();

      // 📱 ดึงข้อมูลอุปกรณ์
      final deviceData = await getDeviceDetails();
      final String deviceBrand = deviceData['device_brand'] ?? 'unknown';
      final String deviceModel = deviceData['device_model'] ?? 'unknown';
      final String osVersion = deviceData['os_version'] ?? 'unknown';

      // ✅ เก็บ log ที่ collection ของ user (หรือจะเก็บที่ event ก็ได้)
      final proximityCollection = FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('proximity_logs');

      final proximityRef = proximityCollection.doc();

      // ✅ เขียนข้อมูลลง Firestore
      await proximityRef.set({
        'log_id': proximityRef.id,
        'event_id': eventId,
        'event_ref': '${event.docRef}',
        'booth_id': boothId,
        'uid': uid,
        'rssi': rssi ?? -99,
        'distance_calibrated': calibratedDistance ?? -1,
        'distance_calibrated_rmse': calibratedDistance_Rmse ?? -1,
        'stable_status': (isStable ?? false) ? 'stable' : 'unstable',
        'threshold': boothThreshold ?? 0,
        'status': status,
        'source': source,
        'detect_timestamp': Timestamp.fromDate(now),
        'device_brand': deviceBrand,
        'device_model': deviceModel,
        'os_version': osVersion,
        'sent_from_server_time': sent_from_server_time,

        // ✅ รวมข้อมูลการแจ้งเตือน (ถ้ามี)
        if (notiData != null) ...{
          'noti_type': notiData['noti_type'] ?? '',
          'title': notiData['title'] ?? '',
          'body': notiData['body'] ?? '',
          'sent_at': notiData['sent_at'] ?? FieldValue.serverTimestamp(),
          'send_count': notiData['send_count'] ?? 1,
          'is_read': notiData['is_read'] ?? false,
          'is_deleted': notiData['is_deleted'] ?? false,
        },
      });

      final sendTime = DateTime.now().millisecondsSinceEpoch;
      // ✅ Log ไปที่ Firebase Analytics (สำหรับ dashboard)
      await analytics.logEvent(name: 'detect_distance_beacon', parameters: {
        'log_id': proximityRef.id,
        'event_id': eventId,
        'uid': uid,
        'noti_type': notiData?['noti_type'] ?? '',

        'rssi': rssi ?? -99,
        'distance': calibratedDistance ?? -1,

        // 🔽 booth (ยุบ)
        'booth': jsonEncode({
          'id': boothId,
          'name': booth.boothName ?? '',
          'uuid': booth.deviceUuid ?? '',
          'rssiThreshold': booth.rssiThreshold ?? 0,
        }),

        // 🔽 measurement
        // 'measure': jsonEncode({
        //   'distance': calibratedDistance ?? -1,
        //   'stable': isStable ? 'stable' : 'unstable',
        //   'threshold': boothThreshold ?? 999,
        //   'status': status,
        //   'source': source,
        // }),

        'context': jsonEncode({
          'device': {
            'brand': deviceBrand,
            'model': deviceModel,
            'os': osVersion,
          },
        }),

        'detect_time': now.millisecondsSinceEpoch,
        'sent_from_server_time': sendTime,

        // 🔽 noti (ยุบ – เฉพาะ metadata)
        if (notiData != null)
          'noti': jsonEncode({
            'type': notiData['noti_type'] ?? '',
          })
      });

      // await analytics.logEvent(
      //   name: 'detect_distance_beacon',
      //   parameters: {
      //     'log_id': proximityRef.id,
      //     'event_id': eventId,
      //     'booth_id': boothId,
      //     'booth_name': booth.boothName ?? '',
      //     'booth_uuid': booth.deviceUuid ?? '',
      //     'tx_powersd': booth.txPower ?? 0,
      //     'path_loss_exponent': booth.pathLossExponent ?? 0,
      //     'smoothing_alpha': booth.smoothingAlpha ?? 0,
      //     // 'rmse_a': booth.rmseA ?? 0,
      //     // 'rmse_b': booth.rmseB ?? 0,
      //     // 'rmse_c': booth.rmseC ?? 0,
      //     'uid': uid,
      //     'rssi': rssi ?? -99,
      //     'distance_calibrated': calibratedDistance ?? -1,
      //     // 'distance_calibrated_rmse': calibratedDistance_Rmse ?? -1,
      //     'stable_status': isStable ? 'stable' : 'unstable',
      //     'config_threshold': boothThreshold ?? 999,
      //     //
      //     // 'context': jsonEncode({
      //     //   'device': {
      //     //     'brand': deviceBrand,
      //     //     'model': deviceModel,
      //     //     'os': osVersion,
      //     //   },
      //     //   'status': status,
      //     //   'source': source,
      //     // }),
      //
      //     // 'device_brand': deviceBrand,
      //     // 'device_model': deviceModel,
      //     // 'os_version': osVersion,
      //     // 'status': status,
      //     // 'source': source,
      //
      //     'detect_time': now.millisecondsSinceEpoch,
      //     'sent_from_server_time': sendTime,
      //     if (notiData != null) ...{
      //       'noti_type': notiData['noti_type'] ?? '',
      //       'title': notiData['title'] ?? '',
      //       'body': notiData['body'] ?? '',
      //     },
      //   },
      // );

      // print(
      //   "✅ Proximity log saved: booth=${booth.boothName}, "
      //   "distance=${calibratedDistance?.toStringAsFixed(2)}m, "
      //   "stable=${isStable ? 'Y' : 'N'}",
      // );

      return proximityRef.id;
    } catch (e, st) {
      // print("⚠️ Error while logging proximity/concurrent users: $e");
      // print(st);
      return null;
    }
  }

  // Future < String ?> logProximityAndConcurrentUsers(
  //     EventDataModelStruct1 event,
  //     BoothDataModelStructNew booth, [
  //       Map<String, dynamic> ? notiData,
  //     ]) async {
  //   try {
  //     print('logProximityAndConcurrentUsers');
  //
  //     final uid = currentUserUid; // ผู้ใช้ปัจจุบัน
  //     final int eventId = event.eventId;
  //     final int boothId = booth.boothId;
  //     final now = DateTime.now();
  //
  //     // 📱 ดึงข้อมูลอุปกรณ์
  //     final deviceData = await getDeviceDetails();
  //     final String deviceBrand = deviceData['device_brand'] ?? 'unknown';
  //     final String deviceModel = deviceData['device_model'] ?? 'unknown';
  //     final String osVersion = deviceData['os_version'] ?? 'unknown';
  //
  //     double ? rssi;
  //     double ? distance;
  //
  //     // 🛰️ ดึงข้อมูล beacon ที่ตรวจพบจาก FFAppState
  //     if (FFAppState().beaconIdList.contains(booth.deviceUuid)) {
  //       final index = FFAppState().beaconIdList.indexOf(booth.deviceUuid);
  //
  //       // ✅ ถ้ามีระยะทางจาก beaconDistanceList อยู่แล้ว
  //       if (FFAppState().beaconDistanceList.isNotEmpty &&
  //           FFAppState().beaconDistanceList.length > index) {
  //         final distanceStr = FFAppState().beaconDistanceList[index];
  //         distance = double.tryParse(distanceStr);
  //       }
  //
  //       // // ✅ ใช้ RSSI จาก beaconRssiList ถ้ามี
  //       // try {
  //       //   // ถ้ายังไม่มี beaconRssiList ให้ใช้ค่า RSSI จำลอง
  //       //   rssi = (-60 - Random().nextInt(15)).toDouble(); // random -60 ถึง -75
  //       // } catch (_) {
  //       //   rssi = (-60 - Random().nextInt(15)).toDouble();
  //       // }
  //       // ✅ ใช้ RSSI จริงจาก FFAppState ถ้ามี
  //       if (FFAppState().beaconRssiList.isNotEmpty &&
  //           FFAppState().beaconRssiList.length > index) {
  //         rssi = double.tryParse(FFAppState().beaconRssiList[index]) ?? -60;
  //       } else {
  //         rssi = -60; // fallback default
  //       }
  //
  //       // ✅ คำนวณระยะทางจาก RSSI
  //       // distance = calculateDistanceFromRSSI(rssi ?? -60);
  //       distance = calculateDistanceFromRSSI(rssi, txPower: -63, n: 2.2);
  //     }
  //
  //     // final proximityCollection = FirebaseFirestore.instance
  //     //     .collection('events')
  //     //     .doc('${event.docRef}')
  //     //     .collection('proximity_logs');
  //
  //     // ✅ 1️⃣ ตรวจสอบว่ามี log เดิมของ uid ใน booth เดียวกันหรือไม่
  //     final proximityCollection = FirebaseFirestore.instance
  //         .collection('users')
  //         .doc('${uid}')
  //         .collection('proximity_logs');
  //
  //     // ✅ สร้างช่วงเวลาเริ่มต้นของวันนี้
  //     // final nowToday = DateTime.now();
  //     // final startOfDay = DateTime(nowToday.year, nowToday.month, nowToday.day);
  //     // final endOfDay = startOfDay.add(const Duration(days: 1));
  //     // final oneHourAgo = now.subtract(const Duration(hours: 1));
  //
  //     // final existingLog = await proximityCollection
  //     //     .where('uid', isEqualTo: uid)
  //     //     .where('booth_id', isEqualTo: boothId)
  //     //     .where('detect_timestamp',isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay))
  //     //     .where('detect_timestamp',isLessThan: Timestamp.fromDate(endOfDay))
  //     //     .limit(1)
  //     //     .get();
  //
  //     // final existingLog = await proximityCollection
  //     //   .where('uid', isEqualTo: uid)
  //     //   .where('booth_id', isEqualTo: boothId)
  //     //   .where('detect_timestamp', isGreaterThanOrEqualTo: Timestamp.fromDate(oneHourAgo))
  //     //   .limit(1)
  //     //   .get();
  //
  //     // if (existingLog.docs.isNotEmpty) {
  //     //   print("⏳ User $uid เคยเข้าบูธ $boothId แล้ว — ไม่บันทึกซ้ำ");
  //     // } else {
  //     // 👇 บันทึก log ครั้งแรกเท่านั้น
  //     // print('⏳ Skip insert (recent log found within 1 hour)');
  //     final proximityRef = proximityCollection.doc();
  //
  //     await proximityRef.set({
  //       'log_id': proximityRef.id,
  //       'event_id': eventId,
  //       'event_ref': '${event.docRef}',
  //       'booth_id': boothId,
  //       'booth_ref': '',
  //       'uid': uid,
  //
  //       // ✅ ค่า RSSI เดิม (ดิบ)
  //       'rssi': rssi ?? -99,
  //
  //       // ✅ ระยะคาลิเบรตแล้ว (ระยะจริงที่แสดงบนจอ)
  //       'distance_calibrated': distance ?? -1,
  //
  //       // ✅ สถานะความเสถียรของการตรวจจับ
  //       'stable_status': isStable ? 'stable' : 'unstable',
  //
  //       // ✅ ระยะ threshold ของบูธนี้ (ดึงจาก config หรือ booth.notificationDistance)
  //       'threshold': boothThreshold ?? 1.5,
  //
  //       // ✅ เวลา timestamp
  //       'detect_timestamp': Timestamp.fromDate(now),
  //
  //       // ✅ รายละเอียดอุปกรณ์
  //       'device_brand': deviceBrand,
  //       'device_model': deviceModel,
  //       'os_version': osVersion,
  //
  //       // ✅ รวมข้อมูลการแจ้งเตือน (ถ้ามี)
  //       if (notiData != null) ...{
  //         'noti_type': notiData['noti_type'] ?? '',
  //         'title': notiData['title'] ?? '',
  //         'body': notiData['body'] ?? '',
  //         'sent_at': notiData['sent_at'] ?? FieldValue.serverTimestamp(),
  //         'send_count': notiData['send_count'] ?? 1,
  //         'is_read': notiData['is_read'] ?? false,
  //         'is_deleted': notiData['is_deleted'] ?? false,
  //       },
  //     });
  //
  //     // ✅ Log ไปที่ Firebase Analytics
  //     await analytics.logEvent(
  //       name: 'detect_distance_beacon',
  //       parameters: {
  //         'log_id': proximityRef.id,
  //         'event_id': eventId,
  //         'event_ref': '${event.docRef}',
  //         'booth_id': boothId,
  //         'booth_ref': '',
  //         'uid': uid,
  //         'rssi': rssi ?? -00,
  //         'distance': distance ?? -1,
  //         // 'status': 'in_range',
  //         'detect_time': DateTime.now().millisecondsSinceEpoch,
  //         'device_brand': deviceBrand,
  //         'device_model': deviceModel,
  //         'os_version': osVersion,
  //         if(notiData != null) ...{
  //           'noti_type': notiData['noti_type'] ?? '',
  //           'title': notiData['title'] ?? '',
  //           'body': notiData['body'] ?? '',
  //         },
  //       },
  //     );
  //
  //     print(
  //         "✅ Proximity log (first entry) saved → user: $uid | booth: $boothId | distance: ${distance?.toStringAsFixed(2)} m");
  //
  //     return proximityRef.id; // ✅ คืนค่า log_id ออกไป
  //     //////////// save concurrent_users ////////////
  //     // ✅ 2️⃣ อัปเดต concurrent users snapshot (ภายใน 2 นาทีล่าสุด)
  //     // final cutoff = now.subtract(const Duration(minutes: 2));
  //
  //     // final activeSnap = await proximityCollection
  //     //     .where('detect_timestamp',
  //     //         isGreaterThanOrEqualTo: Timestamp.fromDate(cutoff))
  //     //     .get();
  //
  //     // final activeUids =
  //     //     activeSnap.docs.map((e) => e.data()['uid'].toString()).toSet();
  //
  //     // final concurrentRef = FirebaseFirestore.instance
  //     //     .collection('events')
  //     //     .doc('${event.docRef}')
  //     //     .collection('concurrent_users')
  //     //     .doc();
  //
  //     // await concurrentRef.set({
  //     //   'record_id': concurrentRef.id,
  //     //   'event_id': eventId,
  //     //   'timestamp': Timestamp.fromDate(now),
  //     //   'uids': activeUids.toList(),
  //     //   'user_count': activeUids.length,
  //     // });
  //
  //     // print(
  //     //     "👥 Concurrent users snapshot saved (${activeUids.length}) for event $eventId");
  //     // }
  //   } catch (e) {
  //     print("⚠️ Error while logging proximity/concurrent users: $e");
  //     return '';
  //   }
  // }

  /// ฟังก์ชันแปลง RSSI เป็นระยะทาง (ประมาณ)
  // double calculateDistanceFromRSSI(double rssi, {int txPower = -59}) {
  //   if (rssi == 0) return -1.0;
  //   double ratio = rssi / txPower;
  //   if (ratio < 1.0) {
  //     return pow(ratio, 10).toDouble();
  //   } else {
  //     return (0.89976) * pow(ratio, 7.7095) + 0.111;
  //   }
  // }

  /// ✅ เวอร์ชันใหม่ตามสูตรมาตรฐานของอาจารย์
  // double calculateDistanceFromRSSI(
  //   double rssi, {
  //   int txPower = -63, // A = RSSI ที่ 1 เมตร
  //   double n = 2.0, // ห้องโล่งใช้ 2.0 ได้
  // }) {
  //   if (rssi == 0) return -1.0; // ป้องกัน error กรณีไม่มีสัญญาณ
  //
  //   // สูตร Log-distance Path Loss Model
  //   double distance = pow(10, (txPower - rssi) / (10 * n)).toDouble();
  //
  //   // จำกัดระยะที่คำนวณได้ให้อยู่ในขอบเขตสมเหตุสมผล
  //   if (distance < 0.1) distance = 0.1;
  //   if (distance > 20.0) distance = 20.0;
  //
  //   return double.parse(distance.toStringAsFixed(2));
  // }

  // ======================
  // ✅ ตรวจผู้ใช้อยู่ในระยะต่อเนื่อง
  // ======================
  Map<String, DateTime?> _stableStartMap = {};
  Map<String, bool> _inRangeState = {};

  bool isUserStableNear(
    BoothDataModelStructNew booth,
    double distance, {
    int stableMs = 1000, // 1 วินาที
  }) {
    final boothUuid = booth.deviceUuid ?? '';
    final threshold = booth.notificationDistance ?? 1.5;
    final now = DateTime.now();

    _stableStartMap.putIfAbsent(boothUuid, () => null);
    _inRangeState.putIfAbsent(boothUuid, () => false);

    if (distance <= threshold) {
      _stableStartMap[boothUuid] ??= now;
      final diff = now.difference(_stableStartMap[boothUuid]!).inMilliseconds;
      if (diff >= stableMs) {
        _inRangeState[boothUuid] = true;
        return true;
      }
    } else {
      _stableStartMap[boothUuid] = null;
      _inRangeState[boothUuid] = false;
    }
    return false;
  }

  // ======================
  // ✅ RSSI smoothing: median + exponential moving average
  // ======================
  // double getSmoothedRSSI(String uuid, double newRssi,
  //     {int window = 10, double alpha = 0.2}) {
  //   _rssiHistory.putIfAbsent(uuid, () => []);
  //   final history = _rssiHistory[uuid]!;
  //
  //   if (newRssi < -90) return _emaMap[uuid] ?? -90; // กรองสัญญาณอ่อนเกิน
  //
  //   history.add(newRssi);
  //   if (history.length > window) history.removeAt(0);
  //
  //   final sorted = [...history]..sort();
  //   final median = sorted[sorted.length ~/ 2];
  //
  //   final prev = _emaMap[uuid] ?? median;
  //   final ema = alpha * median + (1 - alpha) * prev;
  //   _emaMap[uuid] = ema;
  //   return ema;
  // }

  double getDistanceOfUuid(String uuid) {
    if (FFAppState().beaconIdList.contains(uuid)) {
      final index = FFAppState().beaconIdList.indexOf(uuid);
      return double.tryParse(FFAppState().beaconDistanceList[index]) ?? 999;
    }
    return 999;
  }

  /// ฟังก์ชันสำหรับกรองค่า RSSI ด้วย Exponential Moving Average (EMA)
  // double applyExponentialSmoothing(String beaconId, double currentRssi) {
  //   // กำหนดค่าเริ่มต้นสำหรับ Beacon ที่ไม่เคยมีข้อมูล
  //   if (!_smoothedRssiCache.containsKey(beaconId)) {
  //     _smoothedRssiCache[beaconId] = currentRssi;
  //     return currentRssi;
  //   }
  //
  //   double previousRssi = _smoothedRssiCache[beaconId]!;
  //
  //   // สูตร EMA: S_t = α * Y_t + (1 - α) * S_{t-1}
  //   double smoothedRssi =
  //       (EMA_ALPHA * currentRssi) + ((1.0 - EMA_ALPHA) * previousRssi);
  //
  //   // อัปเดต Cache และคืนค่า
  //   _smoothedRssiCache[beaconId] = smoothedRssi;
  //
  //   return smoothedRssi;
  // }

  /// ฟังก์ชันสำหรับหาค่า TxPower และ n ด้วย Linear Regression (ต้องใช้ Math Library)
  // Map<String, double> calculateCalibrationParams(
  //     List<double> distances, List<double> rssis) {
  //   // Log-distance path loss model: RSSI = TxPower - 10n * log10(d)
  //   // จัดรูปให้อยู่ในรูปสมการเส้นตรง: y = m*x + c
  //   // โดยที่ y = RSSI, x = log10(d), m = -10n, c = TxPower
  //
  //   // 1. แปลงระยะทางให้อยู่ในรูป Log10(d)
  //   List<double> logDistances = distances.map((d) => log(d) / ln10).toList();
  //
  //   // 2. คำนวณค่าเฉลี่ย
  //   double meanX = logDistances.reduce((a, b) => a + b) / logDistances.length;
  //   double meanY = rssis.reduce((a, b) => a + b) / rssis.length;
  //
  //   // 3. คำนวณความชัน (Slope, m) และจุดตัดแกน Y (Intercept, c)
  //   double num = 0.0; // ตัวเศษ
  //   double den = 0.0; // ตัวส่วน
  //   for (int i = 0; i < logDistances.length; i++) {
  //     num += (logDistances[i] - meanX) * (rssis[i] - meanY);
  //     den += pow((logDistances[i] - meanX), 2);
  //   }
  //
  //   double slope = num / den; // m = -10n
  //   double intercept = meanY - slope * meanX; // c = TxPower
  //
  //   // 4. คำนวณหาค่า n และ TxPower
  //   double n = -slope / 10.0;
  //   double txPower = intercept;
  //
  //   return {"txPower": txPower, "n": n};
  // }

  // // ⚠️ วิธีการใช้งาน (รันแค่ครั้งเดียวเพื่อหาค่า):
  // void testCalibrationAndGetValues() {
  //   // 🔴 ป้อนข้อมูลที่วัดได้จริงของคุณที่นี่:
  //   List<double> realDistances = [
  //     0.5,
  //     1.0,
  //     2.0,
  //     3.0,
  //     4.0,
  //     5.0
  //   ]; // ระยะทางจริง (เมตร)
  //   List<double> rssis = [
  //     -45.5,
  //     -53.2,
  //     -65.1,
  //     -74.8,
  //     -80.5,
  //     -85.2
  //   ]; // RSSI เฉลี่ยที่วัดได้
  //
  //   final result = calculateCalibrationParams(realDistances, rssis);
  //   print("-------------------------------------------------------");
  //   print(
  //       "✅ ค่าที่ต้องนำไปใช้ในโค้ด (TX_POWER_CALIBRATED): ${result['txPower']}");
  //   print("✅ ค่าที่ต้องนำไปใช้ในโค้ด (PATH_LOSS_EXPONENT_N): ${result['n']}");
  //   print("-------------------------------------------------------");
  //
  //   // นำค่าเหล่านี้ไปแทนที่ในส่วนที่ 1: TX_POWER_CALIBRATED และ PATH_LOSS_EXPONENT_N
  // }

  // -----------------------------------
  // ฟังก์ชันคำนวณระยะจาก RSSI ต่อ Beacon
  // -----------------------------------
  // double? calculateDistanceByBeacon(String uuid, double rssi) {
  //   final Map<String, Map<String, double>> params = {
  //     // A = ค่า RSSI ที่ 1 เมตร (TxPower)
  //     // n = ดัชนีการสูญเสียเส้นทาง (Path Loss Exponent)
  //     "25786407-EBC6-CFAF-B14F-E2A49306A5FD": {"A": -62.12, "n": 3.55},
  //     "FDA50693-A4E2-4FB1-AFCF-C6EB07647826": {"A": -62.12, "n": 3.55},
  //     "FDA50693-A4E2-4FB1-AFCF-C6EB07647827": {"A": -62.12, "n": 3.55},
  //   };

  //   if (!params.containsKey(uuid)) {
  //     print("⚠️ Unknown beacon UUID: $uuid (no calibration params)");
  //     return null;
  //   }

  //   final A = params[uuid]!["A"]!;
  //   final n = params[uuid]!["n"]!;

  //   final distance = math.pow(10, (A - rssi) / (10 * n));

  //   // print(
  //   //   "Calibrate :: Beacon $uuid , RSSI=$rssi ; Distance=$distance",
  //   // );

  //   // math.pow คืนค่าเป็น num → แปลงเป็น double
  //   return distance.toDouble();
  // }

  // Future<Map<String, double>?> getCalibrationParams(String uuid) async {
  //   final doc =
  //       await FirebaseFirestore.instance.collection('booths').doc(uuid).get();
  //
  //   if (!doc.exists) return null;
  //
  //   return {
  //     "A": (doc["tx_power"] as num).toDouble(),
  //     "n": (doc["path_loss_exponent"] as num).toDouble(),
  //   };
  // }

  double calculateDistanceByBeacon(double rssi, double A, double n) {
    return math.pow(10, (A - rssi) / (10 * n)).toDouble();
  }

  double distanceByRMSE(double d, double a, double b, double c) {
    final result = a * d * d + b * d + c;
    return result < 0 ? 0 : result; // ห้ามเป็นค่าติดลบ
  }

  Future<Map<String, double>> getCalibratedDistance(
      BoothDataModelStructNew booth, String uuid, double rawRssi) async {
    print('---- Calculate Distance ----');
    print('Beacon UUID: $uuid');

    // 1) ดึงค่าพารามิเตอร์จาก booth โดยตรง
    final A = -((booth.txPower as num).toDouble());
    final n = (booth.pathLossExponent as num?)?.toDouble();

    final rmse_a = (booth.rmseA as num?)?.toDouble() ?? 0.0;
    final rmse_b = (booth.rmseB as num?)?.toDouble() ?? 0.0;
    final rmse_c = (booth.rmseC as num?)?.toDouble() ?? 0.0;

    print("A = $A, n = $n");
    print("RMSE → a=$rmse_a, b=$rmse_b, c=$rmse_c");

    if (A == null || n == null) {
      print("⚠️ A or n missing");
      return {
        "log_model": 999,
        "rmse_model": 999,
      };
    }

    final distance = calculateDistanceByBeacon(rawRssi, A, n);
    print('Distance = $distance m');

    // 2️⃣ คำนวณด้วย RMSE
    final distanceRMSE = distanceByRMSE(distance, rmse_a, rmse_b, rmse_c);
    print('distanceRMSE = $distanceRMSE ');

    return {
      "log_model": distance,
      "rmse_model": distanceRMSE,
    };
  }

  Timer? _continuousPrintTimer;
  DateTime? _lastSeenBeacon; // ⭐ เวลาเจอ Beacon ครั้งล่าสุด

  Future<void> startPrintRawRSSIContinuous() async {
    final minutes = FFAppState().DeviceMinute;
    final distance = FFAppState().DeviceDistance;
    final endTime = DateTime.now().add(Duration(minutes: minutes));

    print("📡 Start FULL RSSI logging (200 ms) for $minutes minutes");

    // Log header ให้ทุก Beacon
    for (final uuid in FFAppState().beaconIdList) {
      await saveLogToFile(
          uuid, "=== Start logging === Minute:$minutes Distance:$distance ===");
    }

    _continuousPrintTimer?.cancel();
    _continuousPrintTimer = Timer.periodic(
      const Duration(milliseconds: 200), // ⭐ sample ทุก 200 ms
      (timer) async {
        final now = DateTime.now();

        // ❌ หมดเวลา — หยุด
        if (now.isAfter(endTime)) {
          print("🛑 Logging finished (time limit reached)");

          for (final uuid in FFAppState().beaconIdList) {
            await saveLogToFile(
                uuid, "🛑 Logging finished (time limit reached)");
          }
          timer.cancel();
          return;
        }

        // ❌ ไม่พบ Beacon เลย
        if (FFAppState().beaconIdList.isEmpty) {
          // ถ้าเพิ่งเริ่มไม่เจอ ให้บันทึกเวลานี้เป็นครั้งแรก
          _lastSeenBeacon ??= now;

          // Beacon หายเกิน 5 วินาที → หยุด
          if (now.difference(_lastSeenBeacon!).inSeconds >= 5) {
            print("🛑 Auto stop — no beacon detected for 5 seconds");

            // Log ให้ทุก UUID (กันข้อมูลขาด)
            for (final uuid in FFAppState().beaconIdList) {
              await saveLogToFile(
                  uuid, "🛑 Auto stop — no beacon detected for 5 seconds");
            }

            timer.cancel();
            _lastSeenBeacon = null;
            return;
          }

          print("⚠️ Beacon not found... waiting...");
          return;
        }

        // 🟢 เจอ Beacon → reset timer
        _lastSeenBeacon = now;

        // Loop เก็บข้อมูลทุก Beacon
        for (int i = 0; i < FFAppState().beaconIdList.length; i++) {
          final uuid = FFAppState().beaconIdList[i];
          final rssiStr = FFAppState().beaconRssiList[i];
          final rssi = double.tryParse(rssiStr);

          if (rssi == null) continue;

          final log =
              "📝 [$now] UUID=$uuid | RSSI=$rssi | Minute:$minutes | Distance:$distance";

          print(log);
          await saveLogToFile(uuid, log); // ⭐ แยกไฟล์ตาม UUID
        }
      },
    );

    FFAppState().isLogging = false;
  }

  Future<File> saveLogToFile(String uuid, String text) async {
    // โฟลเดอร์ที่มองเห็นได้
    final directory = Directory('/storage/emulated/0/Documents');

    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
    }

    // วันที่แบบ YYYYMMDD
    final date = DateTime.now();
    final dateStr =
        "${date.year}${date.month.toString().padLeft(2, '0')}${date.day.toString().padLeft(2, '0')}";

    // UUID แบบ filename-safe (ตัด '-')
    final uuidSafe = uuid.replaceAll("-", "");

    // สร้างชื่อไฟล์แบบ 20250202_UUID.txt
    final fileName = "${dateStr}_${uuidSafe}.txt";

    final file = File('${directory.path}/$fileName');

    // เขียนต่อท้ายไฟล์ (append)
    return file.writeAsString("$text\n", mode: FileMode.append);
  }

  void stopPrintRawRSSIContinuous() {
    _continuousPrintTimer?.cancel();
    _continuousPrintTimer = null;
    _lastSeenBeacon = null;
    print("🛑 Continuous RAW RSSI logging manually stopped");
  }

  void stopListening() {
    _streamRanging?.cancel();
    _streamRanging = null;
  }

// List<String> getBeaconIdList() {
//   return beaconId;
// }
//
// List<String> getBeaconDistanceList() {
//   return FFAppState().beaconDistanceList;
// }
}
