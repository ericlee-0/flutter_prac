import 'package:flutter/material.dart';
import '../../../locator.dart';
import '../navigation/navigation_service.dart';

class CallToAction extends StatelessWidget {
  final String title;
  final Function endDrawer;
  final String navigationPath;
  CallToAction(this.title, this.endDrawer, this.navigationPath);
  @override
  Widget build(BuildContext context) {
    print('calltoaction navi:$navigationPath');
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
      child: GestureDetector(
        onTap: () {
          locator<NavigationService>().navigateTo(navigationPath);
        },
        child: Text(
          title,
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white),
        ),
      ),
      decoration: BoxDecoration(
          color: Colors.green, borderRadius: BorderRadius.circular(5)),
    );
  }
}
