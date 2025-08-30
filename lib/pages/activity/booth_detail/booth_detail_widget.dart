import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/instant_timer.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;
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
  LatLng? currentUserLocationValue;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BoothDetailModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await Future.wait([
        Future(() async {
          // getActivity
          _model.dataActivity = await queryUserActivityRecordOnce(
            parent: currentUserReference,
            queryBuilder: (userActivityRecord) => userActivityRecord
                .where(
                  'booth_id',
                  isEqualTo: widget.boothId,
                )
                .where(
                  'is_active',
                  isEqualTo: 0,
                )
                .where(
                  'event_id',
                  isEqualTo: widget.eventId,
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
          child: SingleChildScrollView(
            primary: false,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Builder(
                    builder: (context) {
                      final pageview =
                          widget.boothDoc?.boothImageList.toList() ?? [];

                      return Container(
                        width: double.infinity,
                        height: 400.0,
                        child: Stack(
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 40.0),
                              child: PageView.builder(
                                controller: _model.pageViewController ??=
                                    PageController(
                                        initialPage: max(
                                            0, min(0, pageview.length - 1))),
                                scrollDirection: Axis.horizontal,
                                itemCount: pageview.length,
                                itemBuilder: (context, pageviewIndex) {
                                  final pageviewItem = pageview[pageviewIndex];
                                  return Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(12.0),
                                        child: Hero(
                                          tag: pageviewItem,
                                          transitionOnUserGestures: true,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(8.0),
                                              bottomRight: Radius.circular(8.0),
                                              topLeft: Radius.circular(8.0),
                                              topRight: Radius.circular(8.0),
                                            ),
                                            child: OctoImage(
                                              placeholderBuilder: (_) =>
                                                  SizedBox.expand(
                                                child: Image(
                                                  image: BlurHashImage(
                                                      'UBEVpOXp4mV@bw9F8_?b00ITt7ocIA~q_48_'),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              image: NetworkImage(
                                                pageviewItem,
                                              ),
                                              width: double.infinity,
                                              height: 330.0,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(0.0, 1.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 16.0),
                                child:
                                    smooth_page_indicator.SmoothPageIndicator(
                                  controller: _model.pageViewController ??=
                                      PageController(
                                          initialPage: max(
                                              0, min(0, pageview.length - 1))),
                                  count: pageview.length,
                                  axisDirection: Axis.horizontal,
                                  onDotClicked: (i) async {
                                    await _model.pageViewController!
                                        .animateToPage(
                                      i,
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.ease,
                                    );
                                    safeSetState(() {});
                                  },
                                  effect: smooth_page_indicator.SlideEffect(
                                    spacing: 8.0,
                                    radius: 8.0,
                                    dotWidth: 8.0,
                                    dotHeight: 8.0,
                                    dotColor:
                                        FlutterFlowTheme.of(context).accent1,
                                    activeDotColor:
                                        FlutterFlowTheme.of(context).primary,
                                    paintStyle: PaintingStyle.fill,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: Padding(
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
                                              FFAppState()
                                                  .beaconIdList
                                                  .toList(),
                                              widget.boothDoc?.deviceUuid) !=
                                          -1
                                      ? 'อยู่ในระยะ ${FFAppState().beaconDistanceList.elementAtOrNull(functions.returnIndexValueInList(FFAppState().beaconIdList.toList(), widget.boothDoc?.deviceUuid)!)} m'
                                      : 'ไม่อยู่ในระยะ',
                                  style: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        font: GoogleFonts.readexPro(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .fontStyle,
                                        ),
                                        color: FlutterFlowTheme.of(context)
                                            .secondary,
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
                                    10.0, 8.0, 10.0, 12.0),
                                child: Text(
                                  valueOrDefault<String>(
                                    widget.boothDocRef?.description,
                                    '-',
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        font: GoogleFonts.readexPro(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
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
                                        currentUserLocationValue =
                                            await getCurrentUserLocation(
                                                defaultLocation:
                                                    LatLng(0.0, 0.0));
                                        var _shouldSetState = false;
                                        var confirmDialogResponse =
                                            await showDialog<bool>(
                                                  context: context,
                                                  builder:
                                                      (alertDialogContext) {
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
                                                          child:
                                                              Text('Confirm'),
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
                                          _model.counterActivity =
                                              _model.countRows;
                                          safeSetState(() {});
                                          _model.counterActivity =
                                              _model.counterActivity! + 1;
                                          safeSetState(() {});

                                          var userActivityRecordReference =
                                              UserActivityRecord.createDoc(
                                                  currentUserReference!);
                                          await userActivityRecordReference
                                              .set({
                                            ...createUserActivityRecordData(
                                              uid: currentUserUid,
                                              eventId: widget.eventId,
                                              boothId: widget.boothId,
                                              isCompleted: true,
                                              createdBy:
                                                  currentUserReference?.path,
                                              isActive: 0,
                                              activityId:
                                                  _model.counterActivity,
                                              associatedEventId:
                                                  widget.eventDocRef?.id,
                                              associatedBoothId: widget
                                                  .boothDocRef?.reference.id,
                                              checkInLocation:
                                                  currentUserLocationValue,
                                              isSurveyed: false,
                                              boothName:
                                                  widget.boothDoc?.boothName,
                                              updatedBy:
                                                  currentUserReference?.path,
                                            ),
                                            ...mapToFirestore(
                                              {
                                                'check_in_time': FieldValue
                                                    .serverTimestamp(),
                                                'created_at': FieldValue
                                                    .serverTimestamp(),
                                                'updated_at': FieldValue
                                                    .serverTimestamp(),
                                              },
                                            ),
                                          });
                                          _model.saveActivity =
                                              UserActivityRecord
                                                  .getDocumentFromData({
                                            ...createUserActivityRecordData(
                                              uid: currentUserUid,
                                              eventId: widget.eventId,
                                              boothId: widget.boothId,
                                              isCompleted: true,
                                              createdBy:
                                                  currentUserReference?.path,
                                              isActive: 0,
                                              activityId:
                                                  _model.counterActivity,
                                              associatedEventId:
                                                  widget.eventDocRef?.id,
                                              associatedBoothId: widget
                                                  .boothDocRef?.reference.id,
                                              checkInLocation:
                                                  currentUserLocationValue,
                                              isSurveyed: false,
                                              boothName:
                                                  widget.boothDoc?.boothName,
                                              updatedBy:
                                                  currentUserReference?.path,
                                            ),
                                            ...mapToFirestore(
                                              {
                                                'check_in_time': DateTime.now(),
                                                'created_at': DateTime.now(),
                                                'updated_at': DateTime.now(),
                                              },
                                            ),
                                          }, userActivityRecordReference);
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
                                          if (_shouldSetState)
                                            safeSetState(() {});
                                          return;
                                        }

                                        if (_shouldSetState)
                                          safeSetState(() {});
                                      },
                                text: _model.isComplete
                                    ? 'เช็คอินแล้ว'
                                    : 'เช็คอิน',
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
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmall
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
