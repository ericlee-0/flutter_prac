import 'package:chat_waiting_trinity/pages/web/call_to_action/call_to_action.dart';
import 'package:chat_waiting_trinity/pages/web/home_contents/home_contents_desktop.dart';
import 'package:chat_waiting_trinity/pages/web/home_contents/home_contents_mobile.dart';
import 'package:chat_waiting_trinity/pages/web/navigation/navigation_drawer.dart';

import 'package:responsive_builder/responsive_builder.dart';

import './navigation/navigation_bar.dart';
import 'package:flutter/material.dart';
import './centered_view/centered_view.dart';

class WebHomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) => Scaffold(
        drawer: sizingInformation.deviceScreenType == DeviceScreenType.mobile
            ? NavigationDrawer()
            : null,
        backgroundColor: Colors.white,
        body: CenteredView(
          child: Column(
            children: [
              NavigationBar(),
              Expanded(
                  child: ScreenTypeLayout(
                mobile: HomeContentsMobile(),
                desktop: HomeContentsDesktop(),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
