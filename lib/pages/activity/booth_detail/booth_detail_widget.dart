import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/instant_timer.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octo_image/octo_image.dart';
import 'package:provider/provider.dart';
import 'booth_detail_model.dart';
export 'booth_detail_model.dart';

class BoothDetailWidget extends StatefulWidget {
  const BoothDetailWidget({
    super.key,
    required this.eventId,
    required this.eventDocRef,
    required this.boothId,
    required this.boothDocRef,
    required this.boothDoc,
  });

  final int? eventId;
  final DocumentReference? eventDocRef;
  final int? boothId;
  final BoothsRecord? boothDocRef;
  final BoothsRecord? boothDoc;

  static String routeName = 'BoothDetail';
  static String routePath = '/boothDetail';

  @override
  State<BoothDetailWidget> createState() => _BoothDetailWidgetState();
}

class _BoothDetailWidgetState extends State<BoothDetailWidget> {
  late BoothDetailModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BoothDetailModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await Future.wait([
        Future(() async {
          // getActivity
          _model.dataActivity = await queryUserActivitiesRecordOnce(
            queryBuilder: (userActivitiesRecord) => userActivitiesRecord
                .where(
                  'booth_id',
                  isEqualTo: widget.boothId?.toString(),
                )
                .where(
                  'is_active',
                  isEqualTo: 0,
                )
                .where(
                  'event_id',
                  isEqualTo: widget.eventId?.toString(),
                )
                .where(
                  'uid',
                  isEqualTo: currentUserUid,
                ),
            singleRecord: true,
          ).then((s) => s.firstOrNull);
          _model.isComplete = _model.dataActivity!.isCompleted;
          safeSetState(() {});
          // getBooth
          _model.dataBooth = await queryBoothsRecordOnce(
            queryBuilder: (boothsRecord) => boothsRecord
                .where(
                  'booth_id',
                  isEqualTo: widget.boothId,
                )
                .where(
                  'is_active',
                  isEqualTo: 0,
                ),
            singleRecord: true,
          ).then((s) => s.firstOrNull);
          _model.dataEvent = await queryEventsRecordOnce(
            queryBuilder: (eventsRecord) => eventsRecord
                .where(
                  'event_id',
                  isEqualTo: widget.eventId,
                )
                .where(
                  'is_active',
                  isEqualTo: 0,
                ),
            singleRecord: true,
          ).then((s) => s.firstOrNull);
        }),
        Future(() async {
          _model.instantTimer = InstantTimer.periodic(
            duration: Duration(milliseconds: 500),
            callback: (timer) async {
              safeSetState(() {});
            },
            startImmediately: true,
          );
        }),
      ]);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 30.0,
            ),
            onPressed: () async {
              context.pop();
            },
          ),
          title: Text(
            valueOrDefault<String>(
              widget.boothDocRef?.boothName,
              '-',
            ),
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  font: GoogleFonts.outfit(
                    fontWeight:
                        FlutterFlowTheme.of(context).headlineMedium.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                  ),
                  color: FlutterFlowTheme.of(context).tertiary,
                  letterSpacing: 0.0,
                  fontWeight:
                      FlutterFlowTheme.of(context).headlineMedium.fontWeight,
                  fontStyle:
                      FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Hero(
                  tag: widget.boothDocRef!.boothImageList.elementAtOrNull(0)!,
                  transitionOnUserGestures: true,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0),
                    ),
                    child: OctoImage(
                      placeholderBuilder: (_) => SizedBox.expand(
                        child: Image(
                          image: BlurHashImage(
                              'UBEVpOXp4mV@bw9F8_?b00ITt7ocIA~q_48_'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      image: NetworkImage(
                        widget.boothDocRef!.boothImageList.elementAtOrNull(0)!,
                      ),
                      width: double.infinity,
                      height: 330.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 8.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 8.0, 0.0, 8.0),
                          child: Text(
                            'รายละเอียด',
                            style: FlutterFlowTheme.of(context)
                                .headlineMedium
                                .override(
                                  font: GoogleFonts.outfit(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .headlineMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .headlineMedium
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .headlineMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .headlineMedium
                                      .fontStyle,
                                ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(1.0, 0.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 8.0, 0.0, 12.0),
                            child: Text(
                              functions.returnIndexValueInList(
                                          FFAppState().beaconIdList.toList(),
                                          widget.boothDoc?.deviceUuid) !=
                                      -1
                                  ? ((String beaconDistance,
                                              int notificationDistance) {
                                      return double.parse(beaconDistance) <=
                                          double.parse('$notificationDistance');
                                    }(
                                          FFAppState()
                                              .beaconDistanceList
                                              .elementAtOrNull(functions
                                                  .returnIndexValueInList(
                                                      FFAppState()
                                                          .beaconIdList
                                                          .toList(),
                                                      widget.boothDoc
                                                          ?.deviceUuid)!)!,
                                          widget
                                              .boothDoc!.notificationDistance)
                                      ? 'อยู่ในระยะ ${FFAppState().beaconDistanceList.elementAtOrNull(functions.returnIndexValueInList(FFAppState().beaconIdList.toList(), widget.boothDoc?.deviceUuid)!)} m'
                                      : 'ไม่อยู่ในระยะ')
                                  : 'ไม่อยู่ในระยะ',
                              style: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    font: GoogleFonts.readexPro(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontStyle,
                                    ),
                                    color:
                                        FlutterFlowTheme.of(context).secondary,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontStyle,
                                  ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(-1.0, 0.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 8.0, 0.0, 12.0),
                            child: Text(
                              valueOrDefault<String>(
                                widget.boothDocRef?.description,
                                '-',
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    font: GoogleFonts.readexPro(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontStyle,
                                  ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 12.0),
                          child: FFButtonWidget(
                            onPressed: _model.isComplete
                                ? null
                                : () async {
                                    var _shouldSetState = false;
                                    var confirmDialogResponse =
                                        await showDialog<bool>(
                                              context: context,
                                              builder: (alertDialogContext) {
                                                return AlertDialog(
                                                  content: Text(
                                                      'คุณต้องการเช็คอินบูธ${widget.boothDocRef?.boothName}ใช่ไหม ?'),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              alertDialogContext,
                                                              false),
                                                      child: Text('Cancel'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              alertDialogContext,
                                                              true),
                                                      child: Text('Confirm'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            ) ??
                                            false;
                                    if (confirmDialogResponse) {
                                      // countActivity
                                      _model.countRows =
                                          await queryUserActivitiesRecordCount();
                                      _shouldSetState = true;
                                      _model.counterActivity = _model.countRows;
                                      safeSetState(() {});
                                      _model.counterActivity =
                                          _model.counterActivity! + 1;
                                      safeSetState(() {});

                                      var userActivitiesRecordReference =
                                          UserActivitiesRecord.collection.doc();
                                      await userActivitiesRecordReference.set({
                                        ...createUserActivitiesRecordData(
                                          uid: currentUserUid,
                                          eventId: widget.eventId?.toString(),
                                          boothId: widget.boothId?.toString(),
                                          isCompleted: true,
                                          createdBy: currentUserReference?.path,
                                          isActive: 0,
                                          activityId: _model.counterActivity,
                                        ),
                                        ...mapToFirestore(
                                          {
                                            'check_in_time':
                                                FieldValue.serverTimestamp(),
                                            'created_at':
                                                FieldValue.serverTimestamp(),
                                          },
                                        ),
                                      });
                                      _model.saveActivity = UserActivitiesRecord
                                          .getDocumentFromData({
                                        ...createUserActivitiesRecordData(
                                          uid: currentUserUid,
                                          eventId: widget.eventId?.toString(),
                                          boothId: widget.boothId?.toString(),
                                          isCompleted: true,
                                          createdBy: currentUserReference?.path,
                                          isActive: 0,
                                          activityId: _model.counterActivity,
                                        ),
                                        ...mapToFirestore(
                                          {
                                            'check_in_time': DateTime.now(),
                                            'created_at': DateTime.now(),
                                          },
                                        ),
                                      }, userActivitiesRecordReference);
                                      _shouldSetState = true;
                                      if (Navigator.of(context).canPop()) {
                                        context.pop();
                                      }
                                      context.pushNamed(
                                        SuccessInprocessWidget.routeName,
                                        queryParameters: {
                                          'boothName': serializeParam(
                                            widget.boothDocRef?.boothName,
                                            ParamType.String,
                                          ),
                                          'eventId': serializeParam(
                                            widget.eventId,
                                            ParamType.int,
                                          ),
                                          'eventDocRef': serializeParam(
                                            _model.dataEvent,
                                            ParamType.Document,
                                          ),
                                        }.withoutNulls,
                                        extra: <String, dynamic>{
                                          'eventDocRef': _model.dataEvent,
                                        },
                                      );
                                    } else {
                                      if (_shouldSetState) safeSetState(() {});
                                      return;
                                    }

                                    if (_shouldSetState) safeSetState(() {});
                                  },
                            text: _model.isComplete ? 'เช็คอินแล้ว' : 'เช็คอิน',
                            options: FFButtonOptions(
                              width: double.infinity,
                              height: 48.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: FlutterFlowTheme.of(context).primary,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    font: GoogleFonts.readexPro(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontStyle,
                                    ),
                                    color: Colors.white,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                              disabledColor: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              disabledTextColor:
                                  FlutterFlowTheme.of(context).primaryText,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
