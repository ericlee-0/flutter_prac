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
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) => Scaffold(
        drawer: sizingInformation.deviceScreenType == DeviceScreenType.mobile
            ? NavigationDrawer()
            : null,
        backgroundColor: Colors.blue[100],
        body: CenteredView(
          child: Column(
            children: [
              NavigationBar(),
              Expanded(
                child:
                 Navigator(
                  key: locator<NavigationService>().navigatorKey,
                  onGenerateRoute: generateRoute,
                  initialRoute: HomeRoute,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
