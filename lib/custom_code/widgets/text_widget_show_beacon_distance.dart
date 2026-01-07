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
            final index =
                returnIndexValueInList(ids.toList(), widget.deviceUuid!);

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

            // print('------xxx------');
            // if (index != -1) {
            //   print('------yyy------');
            //
            //   final safeIndex = index!;
            //   final distanceStr = distances.elementAtOrNull(safeIndex);
            //
            //   if (distanceStr != null) {
            //     print('------zzz------');
            //
            //     final distance = double.tryParse(distanceStr);
            //     final notifyDistance =
            //         double.tryParse(distances[safeIndex]) ?? -99;
            //
            //     print(
            //       '[UI DEBUG] uuid=${widget.deviceUuid}, '
            //           'notifyDistance=$notifyDistance, '
            //           'distance=$distance, '
            //           'distanceStr=$distanceStr',
            //     );
            //
            //     if (distance != null && notifyDistance != null) {
            //       if (distance <= notifyDistance) {
            //         statusText = 'อยู่ในระยะ';
            //         statusColor = FlutterFlowTheme.of(context).success;
            //       }
            //     }
            //   }
            // }

            if (index != null && index != -1 && index < distances.length) {
              final int safeIndex = index; // ✅ แปลงจาก int? → int

              final rawRssi = double.tryParse(distances[safeIndex]) ?? -99;

              // final threshold = widget.rssiThreshold ?? 0;

              // 🔧 TEMP: hardcode threshold ตาม UUID
              int threshold;

              switch (widget.deviceUuid) {
                case '25786407-EBC6-CFAF-B14F-E2A49306A5FD':
                  threshold = 62;
                  break;

                case 'FDA50693-A4E2-4FB1-AFCF-C6EB07647826':
                  threshold = 71;
                  break;

                case 'FDA50693-A4E2-4FB1-AFCF-C6EB07647827':
                  threshold = 70;
                  break;

                default:
                  threshold = 70; // ค่า default กันพัง
              }

              final compareValue = -threshold;
              final pass = rawRssi >= compareValue;

              // 🔍 DEBUG
              print('[RSSI DEBUG] '
                  'uuid=${widget.deviceUuid}, '
                  'index=$safeIndex, '
                  'rawRssi=$rawRssi dBm, '
                  'threshold=$threshold (=> $compareValue dBm), '
                  'pass=$pass');

              if (pass) {
                statusText = 'อยู่ในระยะ';
                // statusText = 'อยู่ในระยะ $rawRssi';
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
