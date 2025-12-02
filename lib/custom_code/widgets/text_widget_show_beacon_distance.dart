// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/custom_code/my_stream_service.dart';
import 'package:google_fonts/google_fonts.dart';

class TextWidgetShowBeaconDistance extends StatefulWidget {
  const TextWidgetShowBeaconDistance({
    super.key,
    this.width,
    this.height,
    this.deviceUuid,
    this.notificationDistance,
    // this.showText = false, // niruemon ค่า default = ซ่อนข้อความ
  });

  final double? width;
  final double? height;
  final String? deviceUuid;
  final String? notificationDistance;
  // final bool showText; // พารามิเตอร์เปิด/ปิดข้อความ

  @override
  State<TextWidgetShowBeaconDistance> createState() =>
      _TextWidgetShowBeaconDistanceState();
}

class _TextWidgetShowBeaconDistanceState
    extends State<TextWidgetShowBeaconDistance> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<String>>(
      valueListenable: MyStreamService().beaconDistance,
      builder: (context, distances, _) {
        return ValueListenableBuilder<List<String>>(
          valueListenable: MyStreamService().beaconId,
          builder: (context, ids, __) {
            // if (!widget.showText) {
            //   // 👈 ถ้าไม่ให้แสดงข้อความ → ซ่อนทั้งหมด
            // return SizedBox.shrink();
            // }

            return Text(
              returnIndexValueInList(ids.toList(), widget.deviceUuid!) != -1
                  ? double.parse(distances.elementAtOrNull(
                              returnIndexValueInList(
                                  ids.toList(), widget.deviceUuid!)!)!) <=
                          double.parse(widget.notificationDistance!)
                      ? 'อยู่ในระยะ' // ${distances.elementAtOrNull(returnIndexValueInList(ids.toList(), widget.deviceUuid!)!)} m'
                      : 'ไม่อยู่ในระยะ'
                  : 'ไม่อยู่ในระยะ',
              style: FlutterFlowTheme.of(context).labelMedium.override(
                    font: GoogleFonts.readexPro(
                      fontWeight:
                          FlutterFlowTheme.of(context).labelMedium.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).labelMedium.fontStyle,
                    ),
                    color: FlutterFlowTheme.of(context).success,
                    letterSpacing: 0.0,
                    fontWeight:
                        FlutterFlowTheme.of(context).labelMedium.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).labelMedium.fontStyle,
                  ),
            );
          },
        );
      },
    );
  }
}
