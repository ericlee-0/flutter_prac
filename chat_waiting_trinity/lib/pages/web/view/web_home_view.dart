import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../home_contents/home_contents_desktop.dart';
import '../home_contents/home_contents_mobile.dart';

class WebHomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: HomeContentsMobile(),
      desktop: HomeContentsDesktop(),
    );
  }
}
