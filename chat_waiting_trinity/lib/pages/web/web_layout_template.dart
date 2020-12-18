import './home_contents/chat_drawer.dart';
import 'package:chat_waiting_trinity/pages/web/route/route_names.dart';
import 'package:chat_waiting_trinity/pages/web/view/web_home_view.dart';

import '../../locator.dart';
import './navigation/navigation_service.dart';

// import 'home_contents/home_contents_desktop.dart';
// import 'home_contents/home_contents_mobile.dart';
import './navigation/navigation_drawer.dart';

import 'package:responsive_builder/responsive_builder.dart';

import './navigation/navigation_bar.dart';
import 'package:flutter/material.dart';
import './centered_view/centered_view.dart';
import './route/router.dart';

class WebLayoutTemplate extends StatelessWidget {
  final Widget child;
  WebLayoutTemplate(this.child);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    // print('open drawer');
    _scaffoldKey.currentState.openDrawer();
  }

  void _openEndDrawer() {
    print('open enddrawer');
    _scaffoldKey.currentState.openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) => Scaffold(
        key: _scaffoldKey,
        drawer: sizingInformation.deviceScreenType == DeviceScreenType.mobile
            ? NavigationDrawer()
            : null,
        endDrawer: ChatDrawer(),
        backgroundColor: Colors.blue[100],
        body: CenteredView(
          child: Column(
            children: [
              NavigationBar(_openDrawer, _openEndDrawer),
              Expanded(
                child: child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
