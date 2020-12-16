import 'package:flutter/material.dart';
import './navigation_drawer_header.dart';
import './drawer_item.dart';

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(color:Colors.blue, blurRadius: 16)
      ]),
      child: Column(
        children: [
          NavigationDrawerHeader(),
          DrawerItem('Waiting', Icons.list_alt),
          DrawerItem('Chat', Icons.chat),
          DrawerItem('About', Icons.help)
        ]
      ),
    );
  }
}