import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './screen_route_path.dart';
import 'package:flutter/material.dart';
import '../pages/web/web_home_nav.dart';

List<String> titles = [
  'home',
  'add',
  'menu',
  'contact',
  // 'console',
  'chat',
];
// List<String> titlesDesktopAdmin = ['home', 'menu', 'contact', 'console'];
List<String> titlesDesktop = [
  'home',
  'menu',
  'contact',
];

class ScreenRouteInformationParser
    extends RouteInformationParser<ScreenRoutePath> {
  @override
  Future<ScreenRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location);

    //handle '/'
    if (uri.pathSegments.length == 0) return ScreenRoutePath.home();

    //handle '/details'
    if (uri.pathSegments.length == 1) if (titles
        .contains(uri.pathSegments.first)) {
      final title = uri.pathSegments.elementAt(0);
      return ScreenRoutePath.details(title);
    } else {
      return ScreenRoutePath.unKnown();
    }

    return ScreenRoutePath.unKnown();
  }

  @override
  RouteInformation restoreRouteInformation(ScreenRoutePath path) {
    if (path.isUnknown) return RouteInformation(location: '/404');
    if (path.isHomepage) return RouteInformation(location: '/');
    if (path.isDetailsPage) return RouteInformation(location: '/${path.title}');
    return null;
  }
}

class ScreenRouterDelegate extends RouterDelegate<ScreenRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<ScreenRoutePath> {
  String _selectedTitle;
  bool show404 = false;
  @override
  // TODO: implement navigatorKey
  GlobalKey<NavigatorState> get navigatorKey => GlobalKey<NavigatorState>();

  @override
  // TODO: implement currentConfiguration
  ScreenRoutePath get currentConfiguration {
    if (show404) return ScreenRoutePath.unKnown();
    if (_selectedTitle == null) return ScreenRoutePath.home();

    return ScreenRoutePath.details(_selectedTitle);
  }

  int _routeControl(BuildContext context, String _selectedTitle) {
    if (MediaQuery.of(context).size.width < 900) {
      return titles.indexOf(_selectedTitle);
    }
    return titlesDesktop.indexOf(_selectedTitle);
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(
          key: ValueKey('HomePage'),
          child: WebHomeNav(
              // title: ,
              // onTapped: _handleBookTapped,
              selectedTitle: (_selectedTitle != null)
                  ? _routeControl(context, _selectedTitle)
                  : null),
        ),
        if (show404)
          MaterialPage(key: ValueKey('UnknownPage'), child: UnknownScreen())
        // else if (_selectedTitle != null)
        //   MaterialPage(
        //       key: ValueKey('DetailsPage'),
        //       child: WebHomeNav(
        //           selectedTitle: _routeControl(context, _selectedTitle))),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        _selectedTitle = null;
        show404 = false;
        notifyListeners();

        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(ScreenRoutePath path) async {
    if (path.isUnknown) {
      _selectedTitle = null;
      show404 = true;
      return;
    }
    if (path.isDetailsPage) {
      if (!titles.contains(path.title)) {
        show404 = true;
        return;
      }
      _selectedTitle = path.title;
    } else {
      _selectedTitle = null;
    }
    show404 = false;
  }
}

class UnknownScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('404!'),
      ),
    );
  }
}
