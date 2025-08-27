import '/backend/backend.dart';
import '/components/emoji_rating_component_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'survey_widget.dart' show SurveyWidget;
import 'package:flutter/material.dart';

class SurveyModel extends FlutterFlowModel<SurveyWidget> {
  ///  Local state fields for this page.

  List<String> scoreList = [];
  void addToScoreList(String item) => scoreList.add(item);
  void removeFromScoreList(String item) => scoreList.remove(item);
  void removeAtIndexFromScoreList(int index) => scoreList.removeAt(index);
  void insertAtIndexInScoreList(int index, String item) =>
      scoreList.insert(index, item);
  void updateScoreListAtIndex(int index, Function(String) updateFn) =>
      scoreList[index] = updateFn(scoreList[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in Survey widget.
  List<UserActivityRecord>? queryUserActivityAction;
  // Models for EmojiRatingComponent dynamic component.
  late FlutterFlowDynamicModels<EmojiRatingComponentModel>
      emojiRatingComponentModels;

  @override
  void initState(BuildContext context) {
    emojiRatingComponentModels =
        FlutterFlowDynamicModels(() => EmojiRatingComponentModel());
  }

  @override
  void dispose() {
    emojiRatingComponentModels.dispose();
  }
}
