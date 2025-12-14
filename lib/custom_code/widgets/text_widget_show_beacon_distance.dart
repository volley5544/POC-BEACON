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
    this.rssiThreshold,
  });

  final double? width;
  final double? height;
  final String? deviceUuid;
  final String? notificationDistance;
  final int? rssiThreshold;

  @override
  State<TextWidgetShowBeaconDistance> createState() =>
      _TextWidgetShowBeaconDistanceState();
}

class _TextWidgetShowBeaconDistanceState
    extends State<TextWidgetShowBeaconDistance> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<String>>(
      // valueListenable: MyStreamService().beaconDistance,
      valueListenable: MyStreamService().beaconRssi,
      builder: (context, distances, _) {
        return ValueListenableBuilder<List<String>>(
          valueListenable: MyStreamService().beaconId,
          builder: (context, ids, __) {
            // final index =
            // returnIndexValueInList(ids.toList(), widget.deviceUuid!);

            // ✅ ประกาศตรงนี้ (อยู่ใน scope เดียวกับ if)
            final int? indexNullable =
            returnIndexValueInList(ids.toList(), widget.deviceUuid!);

            String statusText = 'ไม่อยู่ในระยะ';
            Color statusColor = Colors.red;

            // if (index != -1) {
            //   // final distanceStr = distances.elementAtOrNull(index);
            //   final safeIndex = index!;   // แปลงเป็น non-null
            //   final distanceStr = distances.elementAtOrNull(safeIndex);
            //   if (distanceStr != null && widget.notificationDistance != null) {
            //     final distance = double.tryParse(distanceStr);
            //     final notifyDistance =
            //     double.tryParse(widget.notificationDistance!);
            //
            //     if (distance != null && notifyDistance != null) {
            //       if (distance <= notifyDistance) {
            //         statusText = 'อยู่ในระยะ';
            //         statusColor = FlutterFlowTheme.of(context).success;
            //       }
            //     }
            //   }
            // }

            if (indexNullable != null &&
                indexNullable != -1 &&
                widget.rssiThreshold != null &&
                FFAppState().beaconRssiList.length > indexNullable) {

              final int index = indexNullable; // ✅ แปลงเป็น non-null

              final rawRssi =
                  double.tryParse(FFAppState().beaconRssiList[index]) ?? -99;

              final int threshold = widget.rssiThreshold!;

              // ⭐ logic เดียวกับ backend
              if (rawRssi >= -threshold) {
                statusText = 'อยู่ในระยะ ${rawRssi}'
                statusColor = FlutterFlowTheme.of(context).success;
              }
            }

            return Text(
              statusText,
              textAlign: TextAlign.right, // 👉 ชิดขวา
              style: FlutterFlowTheme.of(context).labelMedium.override(
                font: GoogleFonts.readexPro(
                  fontWeight:
                  FlutterFlowTheme.of(context).labelMedium.fontWeight,
                  fontStyle:
                  FlutterFlowTheme.of(context).labelMedium.fontStyle,
                ),
                color: statusColor, // 👉 สีตามสถานะ
                letterSpacing: 0.0,
              ),
            );
          },
        );
      },
    );
  }
}