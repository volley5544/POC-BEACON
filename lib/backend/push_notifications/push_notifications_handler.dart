import 'dart:async';

import 'serialization_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';


final _handledMessageIds = <String?>{};

class PushNotificationsHandler extends StatefulWidget {
  const PushNotificationsHandler({Key? key, required this.child})
      : super(key: key);

  final Widget child;

  @override
  _PushNotificationsHandlerState createState() =>
      _PushNotificationsHandlerState();
}

class _PushNotificationsHandlerState extends State<PushNotificationsHandler> {
  bool _loading = false;

  Future handleOpenedPushNotification() async {
    if (isWeb) {
      return;
    }

    final notification = await FirebaseMessaging.instance.getInitialMessage();
    if (notification != null) {
      await _handlePushNotification(notification);
    }
    FirebaseMessaging.onMessageOpenedApp.listen(_handlePushNotification);
  }

  Future _handlePushNotification(RemoteMessage message) async {
    if (_handledMessageIds.contains(message.messageId)) {
      return;
    }
    _handledMessageIds.add(message.messageId);

    safeSetState(() => _loading = true);
    try {
      final initialPageName = message.data['initialPageName'] as String;
      final initialParameterData = getInitialParameterData(message.data);
      final parametersBuilder = parametersBuilderMap[initialPageName];
      if (parametersBuilder != null) {
        final parameterData = await parametersBuilder(initialParameterData);
        if (mounted) {
          context.pushNamed(
            initialPageName,
            pathParameters: parameterData.pathParameters,
            extra: parameterData.extra,
          );
        } else {
          appNavigatorKey.currentContext?.pushNamed(
            initialPageName,
            pathParameters: parameterData.pathParameters,
            extra: parameterData.extra,
          );
        }
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      safeSetState(() => _loading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      handleOpenedPushNotification();
    });
  }

  @override
  Widget build(BuildContext context) => _loading
      ? Center(
          child: SizedBox(
            width: 50.0,
            height: 50.0,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                FlutterFlowTheme.of(context).primary,
              ),
            ),
          ),
        )
      : widget.child;
}

class ParameterData {
  const ParameterData(
      {this.requiredParams = const {}, this.allParams = const {}});
  final Map<String, String?> requiredParams;
  final Map<String, dynamic> allParams;

  Map<String, String> get pathParameters => Map.fromEntries(
        requiredParams.entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
  Map<String, dynamic> get extra => Map.fromEntries(
        allParams.entries.where((e) => e.value != null),
      );

  static Future<ParameterData> Function(Map<String, dynamic>) none() =>
      (data) async => ParameterData();
}

final parametersBuilderMap =
    <String, Future<ParameterData> Function(Map<String, dynamic>)>{
  'HomePagexxxx': ParameterData.none(),
  'test': ParameterData.none(),
  'LoginPage': ParameterData.none(),
  'PracticePage': ParameterData.none(),
  'scan_beacon': ParameterData.none(),
  'Checkout3': ParameterData.none(),
  'CreateAccount': ParameterData.none(),
  'Login': ParameterData.none(),
  'ForgotPassword': ParameterData.none(),
  'EventSelection': ParameterData.none(),
  'Home': (data) async => ParameterData(
        allParams: {
          'uid': getParameter<String>(data, 'uid'),
        },
      ),
  'EditProfile': (data) async => ParameterData(
        allParams: {
          'uid': getParameter<String>(data, 'uid'),
        },
      ),
  'Profile': (data) async => ParameterData(
        allParams: {
          'uid': getParameter<String>(data, 'uid'),
        },
      ),
  'BoothList': (data) async => ParameterData(
        allParams: {
          'eventId': getParameter<int>(data, 'eventId'),
          'eventDocRef': getParameter<DocumentReference>(data, 'eventDocRef'),
        },
      ),
  'BoothDetail': ParameterData.none(),
  'SuccessInprocess': ParameterData.none(),
  'SuccessSurvey': ParameterData.none(),
  'Survey': ParameterData.none(),
  'SettingEventList': (data) async => ParameterData(
        allParams: {
          'isActive': getParameter<int>(data, 'isActive'),
        },
      ),
  'SettingEvent': (data) async => ParameterData(
        allParams: {
          'eventId': getParameter<int>(data, 'eventId'),
          'typePage': getParameter<String>(data, 'typePage'),
          'newEventId': getParameter<int>(data, 'newEventId'),
          'responseUpdated': getParameter<bool>(data, 'responseUpdated'),
        },
      ),
  'SettingBoothListOld': (data) async => ParameterData(
        allParams: {
          'eventId': getParameter<int>(data, 'eventId'),
          'eventDocRef': getParameter<DocumentReference>(data, 'eventDocRef'),
          'eventName': getParameter<String>(data, 'eventName'),
        },
      ),
  'SettingBoothOld': (data) async => ParameterData(
        allParams: {
          'eventId': getParameter<int>(data, 'eventId'),
          'typePage': getParameter<String>(data, 'typePage'),
          'newEventId': getParameter<int>(data, 'newEventId'),
          'responseUpdated': getParameter<bool>(data, 'responseUpdated'),
          'boothId': getParameter<int>(data, 'boothId'),
          'eventDocRef': getParameter<String>(data, 'eventDocRef'),
        },
      ),
  'SettingEventListCopy3': ParameterData.none(),
  'SettingEventListCopy': (data) async => ParameterData(
        allParams: {
          'isActive': getParameter<int>(data, 'isActive'),
        },
      ),
  'SettingEventCopy': (data) async => ParameterData(
        allParams: {
          'eventId': getParameter<int>(data, 'eventId'),
          'typePage': getParameter<String>(data, 'typePage'),
          'newEventId': getParameter<int>(data, 'newEventId'),
          'responseUpdated': getParameter<bool>(data, 'responseUpdated'),
        },
      ),
  'SettingBoothListCopy': (data) async => ParameterData(
        allParams: {
          'eventId': getParameter<int>(data, 'eventId'),
          'eventDocRef': getParameter<DocumentReference>(data, 'eventDocRef'),
        },
      ),
  'SettingBoothList2': (data) async => ParameterData(
        allParams: {
          'isActive': getParameter<int>(data, 'isActive'),
        },
      ),
  'SettingBoothList': (data) async => ParameterData(
        allParams: {
          'eventName': getParameter<String>(data, 'eventName'),
          'eventDocRef': getParameter<DocumentReference>(data, 'eventDocRef'),
          'eventID': getParameter<int>(data, 'eventID'),
        },
      ),
  'SettingBooth': (data) async => ParameterData(
        allParams: {
          'typePage': getParameter<String>(data, 'typePage'),
          'boothDocRef': getParameter<DocumentReference>(data, 'boothDocRef'),
          'eventDocRef': getParameter<DocumentReference>(data, 'eventDocRef'),
          'eventId': getParameter<int>(data, 'eventId'),
        },
      ),
  'ProfileCopy': (data) async => ParameterData(
        allParams: {
          'uid': getParameter<String>(data, 'uid'),
        },
      ),
  'EventSelectionCopy2': ParameterData.none(),
};

Map<String, dynamic> getInitialParameterData(Map<String, dynamic> data) {
  try {
    final parameterDataStr = data['parameterData'];
    if (parameterDataStr == null ||
        parameterDataStr is! String ||
        parameterDataStr.isEmpty) {
      return {};
    }
    return jsonDecode(parameterDataStr) as Map<String, dynamic>;
  } catch (e) {
    print('Error parsing parameter data: $e');
    return {};
  }
}
