import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';

import '/auth/base_auth_user_provider.dart';

import '/backend/push_notifications/push_notifications_handler.dart'
    show PushNotificationsHandler;
import '/main.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';

import '/index.dart';

export 'package:go_router/go_router.dart';
export 'serialization_util.dart';

const kTransitionInfoKey = '__transition_info__';

GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();

  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  BaseAuthUser? initialUser;
  BaseAuthUser? user;
  bool showSplashImage = true;
  String? _redirectLocation;

  /// Determines whether the app will refresh and build again when a sign
  /// in or sign out happens. This is useful when the app is launched or
  /// on an unexpected logout. However, this must be turned off when we
  /// intend to sign in/out and then navigate or perform any actions after.
  /// Otherwise, this will trigger a refresh and interrupt the action(s).
  bool notifyOnAuthChange = true;

  bool get loading => user == null || showSplashImage;
  bool get loggedIn => user?.loggedIn ?? false;
  bool get initiallyLoggedIn => initialUser?.loggedIn ?? false;
  bool get shouldRedirect => loggedIn && _redirectLocation != null;

  String getRedirectLocation() => _redirectLocation!;
  bool hasRedirect() => _redirectLocation != null;
  void setRedirectLocationIfUnset(String loc) => _redirectLocation ??= loc;
  void clearRedirectLocation() => _redirectLocation = null;

  /// Mark as not needing to notify on a sign in / out when we intend
  /// to perform subsequent actions (such as navigation) afterwards.
  void updateNotifyOnAuthChange(bool notify) => notifyOnAuthChange = notify;

  void update(BaseAuthUser newUser) {
    final shouldUpdate =
        user?.uid == null || newUser.uid == null || user?.uid != newUser.uid;
    initialUser ??= newUser;
    user = newUser;
    // Refresh the app on auth change unless explicitly marked otherwise.
    // No need to update unless the user has changed.
    if (notifyOnAuthChange && shouldUpdate) {
      notifyListeners();
    }
    // Once again mark the notifier as needing to update on auth change
    // (in order to catch sign in / out events).
    updateNotifyOnAuthChange(true);
  }

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      refreshListenable: appStateNotifier,
      navigatorKey: appNavigatorKey,
      errorBuilder: (context, state) =>
          appStateNotifier.loggedIn ? NavBarPage() : LoginWidget(),
      routes: [
        FFRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) =>
              appStateNotifier.loggedIn ? NavBarPage() : LoginWidget(),
        ),
        FFRoute(
          name: HomePagexxxxWidget.routeName,
          path: HomePagexxxxWidget.routePath,
          builder: (context, params) => HomePagexxxxWidget(),
        ),
        FFRoute(
          name: TestWidget.routeName,
          path: TestWidget.routePath,
          builder: (context, params) => TestWidget(),
        ),
        FFRoute(
          name: LoginPageWidget.routeName,
          path: LoginPageWidget.routePath,
          builder: (context, params) => LoginPageWidget(),
        ),
        FFRoute(
          name: PracticePageWidget.routeName,
          path: PracticePageWidget.routePath,
          builder: (context, params) => PracticePageWidget(),
        ),
        FFRoute(
          name: ScanBeaconWidget.routeName,
          path: ScanBeaconWidget.routePath,
          builder: (context, params) => ScanBeaconWidget(),
        ),
        FFRoute(
          name: Checkout3Widget.routeName,
          path: Checkout3Widget.routePath,
          builder: (context, params) => Checkout3Widget(),
        ),
        FFRoute(
          name: CreateAccountWidget.routeName,
          path: CreateAccountWidget.routePath,
          builder: (context, params) => CreateAccountWidget(),
        ),
        FFRoute(
          name: LoginWidget.routeName,
          path: LoginWidget.routePath,
          builder: (context, params) => LoginWidget(),
        ),
        FFRoute(
          name: ForgotPasswordWidget.routeName,
          path: ForgotPasswordWidget.routePath,
          builder: (context, params) => ForgotPasswordWidget(),
        ),
        FFRoute(
          name: EventSelectionWidget.routeName,
          path: EventSelectionWidget.routePath,
          builder: (context, params) => params.isEmpty
              ? NavBarPage(initialPage: 'EventSelection')
              : EventSelectionWidget(),
        ),
        FFRoute(
            name: HomeWidget.routeName,
            path: HomeWidget.routePath,
            requireAuth: true,
            builder: (context, params) => params.isEmpty
                ? NavBarPage(initialPage: 'Home')
                : NavBarPage(
                    initialPage: 'Home',
                    page: HomeWidget(
                      uid: params.getParam(
                        'uid',
                        ParamType.String,
                      ),
                    ),
                  )),
        FFRoute(
            name: EditProfileWidget.routeName,
            path: EditProfileWidget.routePath,
            builder: (context, params) => NavBarPage(
                  initialPage: '',
                  page: EditProfileWidget(
                    uid: params.getParam(
                      'uid',
                      ParamType.String,
                    ),
                  ),
                )),
        FFRoute(
          name: ProfileWidget.routeName,
          path: ProfileWidget.routePath,
          requireAuth: true,
          builder: (context, params) => params.isEmpty
              ? NavBarPage(initialPage: 'Profile')
              : ProfileWidget(
                  uid: params.getParam(
                    'uid',
                    ParamType.String,
                  ),
                ),
        ),
        FFRoute(
            name: BoothListWidget.routeName,
            path: BoothListWidget.routePath,
            builder: (context, params) => NavBarPage(
                  initialPage: '',
                  page: BoothListWidget(
                    eventId: params.getParam(
                      'eventId',
                      ParamType.int,
                    ),
                  ),
                )),
        FFRoute(
            name: BoothDetailWidget.routeName,
            path: BoothDetailWidget.routePath,
            builder: (context, params) => NavBarPage(
                  initialPage: '',
                  page: BoothDetailWidget(),
                )),
        FFRoute(
          name: SuccessInprocessWidget.routeName,
          path: SuccessInprocessWidget.routePath,
          builder: (context, params) => SuccessInprocessWidget(),
        ),
        FFRoute(
          name: SuccessSurveyWidget.routeName,
          path: SuccessSurveyWidget.routePath,
          builder: (context, params) => SuccessSurveyWidget(),
        ),
        FFRoute(
            name: SurveyWidget.routeName,
            path: SurveyWidget.routePath,
            builder: (context, params) => NavBarPage(
                  initialPage: '',
                  page: SurveyWidget(),
                )),
        FFRoute(
            name: SettingEventListWidget.routeName,
            path: SettingEventListWidget.routePath,
            requireAuth: true,
            builder: (context, params) => NavBarPage(
                  initialPage: '',
                  page: SettingEventListWidget(
                    isActive: params.getParam(
                      'isActive',
                      ParamType.int,
                    ),
                  ),
                )),
        FFRoute(
            name: SettingEventWidget.routeName,
            path: SettingEventWidget.routePath,
            requireAuth: true,
            builder: (context, params) => NavBarPage(
                  initialPage: '',
                  page: SettingEventWidget(
                    eventId: params.getParam(
                      'eventId',
                      ParamType.int,
                    ),
                    typePage: params.getParam(
                      'typePage',
                      ParamType.String,
                    ),
                    newEventId: params.getParam(
                      'newEventId',
                      ParamType.int,
                    ),
                    responseUpdated: params.getParam(
                      'responseUpdated',
                      ParamType.bool,
                    ),
                    pathFileImages: params.getParam<String>(
                      'pathFileImages',
                      ParamType.String,
                      isList: true,
                    ),
                  ),
                )),
        FFRoute(
            name: SettingBoothListOldWidget.routeName,
            path: SettingBoothListOldWidget.routePath,
            builder: (context, params) => NavBarPage(
                  initialPage: '',
                  page: SettingBoothListOldWidget(
                    eventId: params.getParam(
                      'eventId',
                      ParamType.int,
                    ),
                    eventDocRef: params.getParam(
                      'eventDocRef',
                      ParamType.DocumentReference,
                      isList: false,
                      collectionNamePath: ['events'],
                    ),
                    eventName: params.getParam(
                      'eventName',
                      ParamType.String,
                    ),
                  ),
                )),
        FFRoute(
            name: SettingBoothOldWidget.routeName,
            path: SettingBoothOldWidget.routePath,
            builder: (context, params) => NavBarPage(
                  initialPage: '',
                  page: SettingBoothOldWidget(
                    eventId: params.getParam(
                      'eventId',
                      ParamType.int,
                    ),
                    typePage: params.getParam(
                      'typePage',
                      ParamType.String,
                    ),
                    newEventId: params.getParam(
                      'newEventId',
                      ParamType.int,
                    ),
                    responseUpdated: params.getParam(
                      'responseUpdated',
                      ParamType.bool,
                    ),
                    pathFileImages: params.getParam<String>(
                      'pathFileImages',
                      ParamType.String,
                      isList: true,
                    ),
                    boothId: params.getParam(
                      'boothId',
                      ParamType.int,
                    ),
                    eventDocRef: params.getParam(
                      'eventDocRef',
                      ParamType.String,
                    ),
                  ),
                )),
        FFRoute(
            name: SettingEventListCopy3Widget.routeName,
            path: SettingEventListCopy3Widget.routePath,
            builder: (context, params) => NavBarPage(
                  initialPage: '',
                  page: SettingEventListCopy3Widget(),
                )),
        FFRoute(
            name: SettingEventListCopyWidget.routeName,
            path: SettingEventListCopyWidget.routePath,
            builder: (context, params) => NavBarPage(
                  initialPage: '',
                  page: SettingEventListCopyWidget(
                    isActive: params.getParam(
                      'isActive',
                      ParamType.int,
                    ),
                  ),
                )),
        FFRoute(
            name: SettingEventCopyWidget.routeName,
            path: SettingEventCopyWidget.routePath,
            requireAuth: true,
            builder: (context, params) => NavBarPage(
                  initialPage: '',
                  page: SettingEventCopyWidget(
                    eventId: params.getParam(
                      'eventId',
                      ParamType.int,
                    ),
                    typePage: params.getParam(
                      'typePage',
                      ParamType.String,
                    ),
                    newEventId: params.getParam(
                      'newEventId',
                      ParamType.int,
                    ),
                    responseUpdated: params.getParam(
                      'responseUpdated',
                      ParamType.bool,
                    ),
                  ),
                )),
        FFRoute(
            name: SettingBoothListCopyWidget.routeName,
            path: SettingBoothListCopyWidget.routePath,
            builder: (context, params) => NavBarPage(
                  initialPage: '',
                  page: SettingBoothListCopyWidget(
                    eventId: params.getParam(
                      'eventId',
                      ParamType.int,
                    ),
                    eventDocRef: params.getParam(
                      'eventDocRef',
                      ParamType.DocumentReference,
                      isList: false,
                      collectionNamePath: ['events'],
                    ),
                  ),
                )),
        FFRoute(
            name: SettingBoothList2Widget.routeName,
            path: SettingBoothList2Widget.routePath,
            builder: (context, params) => NavBarPage(
                  initialPage: '',
                  page: SettingBoothList2Widget(
                    isActive: params.getParam(
                      'isActive',
                      ParamType.int,
                    ),
                  ),
                )),
        FFRoute(
            name: SettingBoothListWidget.routeName,
            path: SettingBoothListWidget.routePath,
            builder: (context, params) => NavBarPage(
                  initialPage: '',
                  page: SettingBoothListWidget(
                    eventName: params.getParam(
                      'eventName',
                      ParamType.String,
                    ),
                    eventDocRef: params.getParam(
                      'eventDocRef',
                      ParamType.DocumentReference,
                      isList: false,
                      collectionNamePath: ['events'],
                    ),
                    eventID: params.getParam(
                      'eventID',
                      ParamType.int,
                    ),
                  ),
                )),
        FFRoute(
            name: SettingBoothWidget.routeName,
            path: SettingBoothWidget.routePath,
            requireAuth: true,
            builder: (context, params) => NavBarPage(
                  initialPage: '',
                  page: SettingBoothWidget(
                    typePage: params.getParam(
                      'typePage',
                      ParamType.String,
                    ),
                    boothDocRef: params.getParam(
                      'boothDocRef',
                      ParamType.DocumentReference,
                      isList: false,
                      collectionNamePath: ['events', 'booths'],
                    ),
                    eventDocRef: params.getParam(
                      'eventDocRef',
                      ParamType.DocumentReference,
                      isList: false,
                      collectionNamePath: ['events'],
                    ),
                    eventId: params.getParam(
                      'eventId',
                      ParamType.int,
                    ),
                  ),
                )),
        FFRoute(
          name: ProfileCopyWidget.routeName,
          path: ProfileCopyWidget.routePath,
          requireAuth: true,
          builder: (context, params) => ProfileCopyWidget(
            uid: params.getParam(
              'uid',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: EventSelectionCopyWidget.routeName,
          path: EventSelectionCopyWidget.routePath,
          builder: (context, params) => EventSelectionCopyWidget(),
        )
      ].map((r) => r.toRoute(appStateNotifier)).toList(),
    );

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void goNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : goNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void pushNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : pushNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void safePop() {
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping.
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
}

extension GoRouterExtensions on GoRouter {
  AppStateNotifier get appState => AppStateNotifier.instance;
  void prepareAuthEvent([bool ignoreRedirect = false]) =>
      appState.hasRedirect() && !ignoreRedirect
          ? null
          : appState.updateNotifyOnAuthChange(false);
  bool shouldRedirect(bool ignoreRedirect) =>
      !ignoreRedirect && appState.hasRedirect();
  void clearRedirectLocation() => appState.clearRedirectLocation();
  void setRedirectLocationIfUnset(String location) =>
      appState.updateNotifyOnAuthChange(false);
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(pathParameters)
    ..addAll(uri.queryParameters)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
      ? extraMap[kTransitionInfoKey] as TransitionInfo
      : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.allParams.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, {
    bool isList = false,
    List<String>? collectionNamePath,
    StructBuilder<T>? structBuilder,
  }) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(
      param,
      type,
      isList,
      collectionNamePath: collectionNamePath,
      structBuilder: structBuilder,
    );
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        redirect: (context, state) {
          if (appStateNotifier.shouldRedirect) {
            final redirectLocation = appStateNotifier.getRedirectLocation();
            appStateNotifier.clearRedirectLocation();
            return redirectLocation;
          }

          if (requireAuth && !appStateNotifier.loggedIn) {
            appStateNotifier.setRedirectLocationIfUnset(state.uri.toString());
            return '/login';
          }
          return null;
        },
        pageBuilder: (context, state) {
          fixStatusBarOniOS16AndBelow(context);
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final child = appStateNotifier.loading
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
              : PushNotificationsHandler(child: page);

          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).buildTransitions(
                    context,
                    animation,
                    secondaryAnimation,
                    child,
                  ),
                )
              : MaterialPage(key: state.pageKey, child: child);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => TransitionInfo(hasTransition: false);
}

class RootPageContext {
  const RootPageContext(this.isRootPage, [this.errorRoute]);
  final bool isRootPage;
  final String? errorRoute;

  static bool isInactiveRootPage(BuildContext context) {
    final rootPageContext = context.read<RootPageContext?>();
    final isRootPage = rootPageContext?.isRootPage ?? false;
    final location = GoRouterState.of(context).uri.toString();
    return isRootPage &&
        location != '/' &&
        location != rootPageContext?.errorRoute;
  }

  static Widget wrap(Widget child, {String? errorRoute}) => Provider.value(
        value: RootPageContext(true, errorRoute),
        child: child,
      );
}

extension GoRouterLocationExtension on GoRouter {
  String getCurrentLocation() {
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }
}
