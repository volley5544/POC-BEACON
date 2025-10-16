import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/emoji_rating_component_widget.dart';
import '/components/loading_component_widget.dart';
import '/components/no_data_component_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'survey_model.dart';
export 'survey_model.dart';

class SurveyWidget extends StatefulWidget {
  const SurveyWidget({
    super.key,
    this.uid,
    required this.eventRef,
    required this.eventId,
  });

  final String? uid;
  final EventsRecord? eventRef;
  final int? eventId;

  static String routeName = 'Survey';
  static String routePath = '/survey';

  @override
  State<SurveyWidget> createState() => _SurveyWidgetState();
}

class _SurveyWidgetState extends State<SurveyWidget>
    with TickerProviderStateMixin {
  late SurveyModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SurveyModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'Survey'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      showDialog(
        context: context,
        builder: (dialogContext) {
          return Dialog(
            elevation: 0,
            insetPadding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            alignment: AlignmentDirectional(0.0, 0.0)
                .resolve(Directionality.of(context)),
            child: GestureDetector(
              onTap: () {
                FocusScope.of(dialogContext).unfocus();
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Container(
                height: double.infinity,
                width: double.infinity,
                child: LoadingComponentWidget(),
              ),
            ),
          );
        },
      );

      _model.queryUserActivityAction = await queryUserActivityRecordOnce(
        parent: currentUserReference,
        queryBuilder: (userActivityRecord) => userActivityRecord.where(
          'is_surveyed',
          isEqualTo: false,
        ),
      );
      _model.scoreList = functions
          .generateDefaultList('0', _model.queryUserActivityAction?.length)!
          .toList()
          .cast<String>();
      safeSetState(() {});
      Navigator.pop(context);
    });

    animationsMap.addAll({
      'buttonOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 350.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 350.0.ms,
            duration: 300.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          ScaleEffect(
            curve: Curves.easeInOut,
            delay: 350.0.ms,
            duration: 300.0.ms,
            begin: Offset(0.8, 0.8),
            end: Offset(1.0, 1.0),
          ),
          TiltEffect(
            curve: Curves.easeInOut,
            delay: 350.0.ms,
            duration: 300.0.ms,
            begin: Offset(1.222, 0),
            end: Offset(0, 0),
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 350.0.ms,
            duration: 300.0.ms,
            begin: Offset(0.0, 40.0),
            end: Offset(0.0, 0.0),
          ),
        ],
      ),
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
    return Builder(
      builder: (context) => GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          appBar: AppBar(
            backgroundColor: FlutterFlowTheme.of(context).primary,
            automaticallyImplyLeading: false,
            title: Text(
              'ประเมินความพึงพอใจ',
              style: FlutterFlowTheme.of(context).displaySmall.override(
                    font: GoogleFonts.outfit(
                      fontWeight: FontWeight.normal,
                      fontStyle:
                          FlutterFlowTheme.of(context).displaySmall.fontStyle,
                    ),
                    color: FlutterFlowTheme.of(context).primaryBackground,
                    fontSize: 22.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.normal,
                    fontStyle:
                        FlutterFlowTheme.of(context).displaySmall.fontStyle,
                  ),
            ),
            actions: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 16.0, 0.0),
                    child: FlutterFlowIconButton(
                      borderColor: FlutterFlowTheme.of(context).alternate,
                      borderRadius: 12.0,
                      borderWidth: 1.0,
                      buttonSize: 40.0,
                      fillColor:
                          FlutterFlowTheme.of(context).secondaryBackground,
                      icon: Icon(
                        Icons.close_rounded,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 24.0,
                      ),
                      onPressed: () async {
                        context.safePop();
                      },
                    ),
                  ),
                ],
              ),
            ],
            centerTitle: false,
            elevation: 0.0,
          ),
          body: SafeArea(
            top: true,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_model.queryUserActivityAction!.length > 0)
                  Expanded(
                    child: Builder(
                      builder: (context) {
                        final listBooths =
                            _model.queryUserActivityAction?.toList() ?? [];
                        if (listBooths.isEmpty) {
                          return NoDataComponentWidget(
                            title: 'ไม่พบข้อมูล',
                            body:
                                'ไม่พบข้อมูลประเมินความพึงพอใจ กรุณาเข้าร่วมบูธกิจกรรมและทำแบบสอบถามภายหลัง',
                          );
                        }

                        return ListView.builder(
                          padding: EdgeInsets.fromLTRB(
                            0,
                            0,
                            0,
                            50.0,
                          ),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: listBooths.length,
                          itemBuilder: (context, listBoothsIndex) {
                            final listBoothsItem = listBooths[listBoothsIndex];
                            return Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 5.0),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Align(
                                          alignment:
                                              AlignmentDirectional(-1.0, 0.0),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 12.0, 0.0, 0.0),
                                            child: Text(
                                              listBoothsItem.boothId.toString(),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .labelMedium
                                                  .override(
                                                    font: GoogleFonts.readexPro(
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .fontStyle,
                                                    ),
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelMedium
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelMedium
                                                            .fontStyle,
                                                  ),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional(-1.0, 0.0),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    8.0, 12.0, 0.0, 0.0),
                                            child: Text(
                                              listBoothsItem.boothName,
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .labelMedium
                                                  .override(
                                                    font: GoogleFonts.readexPro(
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .fontStyle,
                                                    ),
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelMedium
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelMedium
                                                            .fontStyle,
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          wrapWithModel(
                                            model: _model
                                                .emojiRatingComponentModels
                                                .getModel(
                                              listBoothsIndex.toString(),
                                              listBoothsIndex,
                                            ),
                                            updateCallback: () =>
                                                safeSetState(() {}),
                                            updateOnChange: true,
                                            child: EmojiRatingComponentWidget(
                                              key: Key(
                                                'Key31u_${listBoothsIndex.toString()}',
                                              ),
                                              returnScoreAction: (score) async {
                                                _model.updateScoreListAtIndex(
                                                  listBoothsIndex,
                                                  (_) => score,
                                                );
                                                safeSetState(() {});
                                                safeSetState(() {});
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                if ((List<String> listScore) {
                  return listScore.every((item) => item != "0");
                }(_model.scoreList.toList()))
                  Container(
                    height: 100.0,
                    decoration: BoxDecoration(),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                24.0, 10.0, 24.0, 24.0),
                            child: FFButtonWidget(
                              onPressed: () async {
                                if (!((List<String> listScore) {
                                  return listScore.every((item) => item != "0");
                                }(_model.scoreList.toList()))) {
                                  await showDialog(
                                    context: context,
                                    builder: (alertDialogContext) {
                                      return AlertDialog(
                                        content:
                                            Text('กรุณาประเมินกิจกรรมให้ครบ'),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.pop(
                                                alertDialogContext),
                                            child: Text('Ok'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                  return;
                                }
                                for (int loop1Index = 0;
                                    loop1Index <=
                                        _model.queryUserActivityAction!.length -
                                            1;
                                    loop1Index++) {
                                  final currentLoop1Item = _model
                                      .queryUserActivityAction![loop1Index];

                                  await currentLoop1Item.reference
                                      .update(createUserActivityRecordData(
                                    isSurveyed: true,
                                    surveyData: createSurveyDataModelStruct(
                                      uid: currentLoop1Item.uid,
                                      eventId: currentLoop1Item.eventId,
                                      boothId: currentLoop1Item.boothId,
                                      rating: int.parse((_model.scoreList
                                          .elementAtOrNull(loop1Index)!)),
                                      feedback: _model
                                          .emojiRatingComponentModels
                                          .getValueForKey(
                                        loop1Index.toString(),
                                        (m) => m.remarkTextController.text,
                                      ),
                                      createdBy: currentUserReference?.path,
                                      isActive: 0,
                                      updatedBy: currentUserReference?.path,
                                      fieldValues: {
                                        'survey_id': FieldValue.increment(1),
                                        'created_at':
                                            FieldValue.serverTimestamp(),
                                        'updated_at':
                                            FieldValue.serverTimestamp(),
                                      },
                                      clearUnsetFields: false,
                                    ),
                                  ));
                                }
                                if (Navigator.of(context).canPop()) {
                                  context.pop();
                                }
                                context.pushNamed(
                                  SuccessSurveyWidget.routeName,
                                  queryParameters: {
                                    'eventId': serializeParam(
                                      widget.eventId,
                                      ParamType.int,
                                    ),
                                    'eventRef': serializeParam(
                                      widget.eventRef,
                                      ParamType.Document,
                                    ),
                                  }.withoutNulls,
                                  extra: <String, dynamic>{
                                    'eventRef': widget.eventRef,
                                  },
                                );
                              },
                              text: 'ส่ง',
                              options: FFButtonOptions(
                                width: double.infinity,
                                height: 48.0,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    24.0, 0.0, 24.0, 0.0),
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
                                elevation: 3.0,
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ).animateOnPageLoad(
                                animationsMap['buttonOnPageLoadAnimation']!),
                          ),
                        ),
                      ],
                    ),
                  ),
              ].addToEnd(SizedBox(height: 50.0)),
            ),
          ),
        ),
      ),
    );
  }
}
