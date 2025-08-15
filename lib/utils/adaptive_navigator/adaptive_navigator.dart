import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveNavigator {
  static final bool _useMaterial =
      defaultTargetPlatform == TargetPlatform.android || kIsWeb;

  static PageRoute<T> _buildRoute<T>(WidgetBuilder builder) {
    final settings = RouteSettings(name: builder.toString());
    return _useMaterial
        ? MaterialPageRoute<T>(builder: builder, settings: settings)
        : CupertinoPageRoute<T>(builder: builder, settings: settings);
  }

  static Future<T?> push<T extends Object?>(BuildContext context, Widget page) {
    return Navigator.of(context).push<T>(_buildRoute((_) => page));
  }

  static Future<T?> pushReplacement<T extends Object?, TO extends Object?>(
    BuildContext context,
    Widget page, {
    TO? result,
  }) {
    return Navigator.of(
      context,
    ).pushReplacement<T, TO>(_buildRoute((_) => page), result: result);
  }

  static Future<T?> pushAndRemoveUntil<T extends Object?>(
    BuildContext context,
    Widget page,
    bool Function(Route<dynamic>) predicate,
  ) {
    return Navigator.of(
      context,
    ).pushAndRemoveUntil<T>(_buildRoute((_) => page), predicate);
  }

  static void pop<T extends Object?>(BuildContext context, [T? result]) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop<T>(result);
    }
  }

  static bool canPop(BuildContext context) {
    return Navigator.of(context).canPop();
  }

  static void maybePop<T extends Object?>(BuildContext context, [T? result]) {
    Navigator.of(context).maybePop(result);
  }

  static void popUntil(BuildContext context, RoutePredicate predicate) {
    Navigator.of(context).popUntil(predicate);
  }
}
