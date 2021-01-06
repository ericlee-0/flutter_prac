import './contents/chat_drawer.dart';
import 'package:chat_waiting_trinity/pages/web_old/route/route_names.dart';
import 'package:chat_waiting_trinity/pages/web_old/view/web_home_view.dart';

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
import 'package:firebase_auth/firebase_auth.dart';

class WebLayoutTemplate extends StatefulWidget {
  final Widget child;
  // final String open;
  WebLayoutTemplate(
    this.child,
  );

  @override
  _WebLayoutTemplateState createState() => _WebLayoutTemplateState();
}

class _WebLayoutTemplateState extends State<WebLayoutTemplate> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    // print('open drawer');
    _scaffoldKey.currentState.openDrawer();
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("My title"),
      content: Text("This is my message."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void _openEndDrawer() {
    
    print('open enddrawer');
     _scaffoldKey.currentState.openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    // print('open: $open');
    return ResponsiveBuilder(
      builder: (context, sizingInformation) => Scaffold(
        key: _scaffoldKey,
        drawer: sizingInformation.deviceScreenType == DeviceScreenType.mobile
            ? NavigationDrawer(_openEndDrawer)
            : null,
        endDrawer: ChatDrawer(),
        backgroundColor: Colors.blue[100],
        body: CenteredView(
          child: Column(
            children: [
              NavigationBar(_openDrawer, _openEndDrawer),
              Expanded(
                child: widget.child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
