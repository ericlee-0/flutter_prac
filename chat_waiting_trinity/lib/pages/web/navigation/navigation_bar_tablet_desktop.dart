import 'package:flutter/material.dart';
import './navbar_item.dart';
import './navbar_logo.dart';
import '../route/route_names.dart';
import './navbar_item_chat.dart';

class NavigationBarTabletDesktop extends StatelessWidget {
  final Function endFn;
  NavigationBarTabletDesktop(this.endFn);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          NavBarLogo(),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              NavBarItem('Waiting',WaitingRoute),
              SizedBox(
                width: 40,
              ),
              // NavBarItem('Chat',ChatRoute),
              NavBarItemChat('Chat',endFn),
              SizedBox(
                width: 40,
              ),
              NavBarItem('About',AboutRoute),
              SizedBox(
                width: 40,
              ),
            ],
          ),
        ],
      ),
    );
  }
}