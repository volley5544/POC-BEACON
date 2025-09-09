import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'home_widget.dart' show HomeWidget;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomeModel extends FlutterFlowModel<HomeWidget> {
  ///  Local state fields for this page.

  DateTime? currentDateTime;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in Home widget.
  UsersRecord? dataUser;
  // Stores action output result for [Firestore Query - Query a collection] action in Home widget.
  RolesRecord? roleData;
  // State field(s) for Carousel widget.
  CarouselSliderController? carouselController;
  int carouselCurrentIndex = 0;

  var linkReister = '';

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
