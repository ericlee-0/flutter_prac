import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../contents/home_contents_desktop.dart';
import '../contents/home_contents_mobile.dart';
import './orientation_layout.dart';

class WebHomeView extends StatelessWidget {
  final Function fn;
  WebHomeView(this.fn);
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: HomeContentsMobile() ,
      desktop: HomeContentsDesktop(fn),
    );
  }
}
