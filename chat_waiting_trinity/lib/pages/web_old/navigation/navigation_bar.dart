import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import './navigation_bar_tablet_desktop.dart';
import './navigation_bar_mobile.dart';

class NavigationBar extends StatelessWidget {
  final Function fn;
  final Function endfn;
  NavigationBar(this.fn,this.endfn);
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: NavigationBarMobile(fn),
      tablet: NavigationBarTabletDesktop(endfn),
    );
  }
}


