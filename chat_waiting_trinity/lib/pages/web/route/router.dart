import 'package:flutter/material.dart';
import 'route_names.dart';
import '../view/web_home_view.dart';
import '../view/web_waiting_view.dart';
import '../view/web_about_view.dart';
import '../view/web_chat_view.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomeRoute:
      return _getPageRoute(WebHomeView());
      break;
    case WaitingRoute:
      return _getPageRoute(WebWaitingView());
      break;
    case ChatRoute:
      return _getPageRoute(WebChatView());
      break;
    case AboutRoute:
      return _getPageRoute(WebAboutView());
      break;
    default:
      return _getPageRoute(WebHomeView());
  }
}

PageRoute _getPageRoute(Widget child) {
  return _FadeRoute(child: child);
}

class _FadeRoute extends PageRouteBuilder {
  final Widget child;
  _FadeRoute({this.child})
      : super(
            pageBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) =>
                child,
            transitionsBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) =>
                FadeTransition(
                  opacity: animation,
                  child: child,
                ));
}
