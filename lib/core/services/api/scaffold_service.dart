import 'package:flashbar/flashbar.dart';
import 'package:flutter/material.dart';

class ScaffoldService {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  BuildContext get context => navigatorKey.currentState.overlay.context;

  ScaffoldState get scaffoldState => Scaffold.of(context);

  showSnackBar(Widget child) {
    showFlashbar(
      context: context,
      duration: Duration(milliseconds: 3000),
      builder: (context, controller) {
        return Flashbar(
          controller: controller,
          message: child,
          backgroundColor: Colors.amber,
          boxShadows: kElevationToShadow[4],
        );
      },
    );
  }

  removeCurrentSnackBar(
      {SnackBarClosedReason reason = SnackBarClosedReason.remove}) {}
}
