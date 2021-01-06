import 'package:flutter/material.dart';
import 'route_names.dart';
import '../view/web_home_view.dart';
import '../view/web_waiting_view.dart';
import '../view/web_about_view.dart';
import '../view/web_chat_view.dart';


Route<dynamic> generateRoute(RouteSettings settings) {
  Function dummy;
  print('settings: $settings');
  switch (settings.name) {
    case HomeRoute:
      return _getPageRoute(WebHomeView(dummy),settings);
      break;
    case WaitingRoute:
      return _getPageRoute(WebWaitingView(),settings);
      break;
    case ChatRoute:
      return _getPageRoute(WebChatView(),settings);
      break;
    case AboutRoute:
      return _getPageRoute(WebAboutView(),settings);
      break;
    default:
      return _getPageRoute(WebHomeView(dummy),settings);
  }
}

PageRoute _getPageRoute(Widget child, RouteSettings settings) {
  return _FadeRoute(child: child, routeName: settings.name);
}

class _FadeRoute extends PageRouteBuilder {
  final String routeName;
  final Widget child;
  _FadeRoute({this.child, this.routeName})
      : super(
        settings: RouteSettings(name: routeName),
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
