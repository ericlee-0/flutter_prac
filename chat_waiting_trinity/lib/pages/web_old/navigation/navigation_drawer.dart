import 'package:chat_waiting_trinity/pages/web_old/navigation/navigation_service.dart';
import 'package:flutter/material.dart';
import './navigation_drawer_header.dart';
import './drawer_item.dart';
import './drawer_item_chat.dart';
import '../route/route_names.dart';

class NavigationDrawer extends StatelessWidget {
  final Function fn;
  NavigationDrawer(this.fn);
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
          DrawerItem('Home', Icons.home, HomeRoute),
          DrawerItem('Waiting', Icons.list_alt, WaitingRoute),
          DrawerItemChat('Chat', Icons.chat, fn),

          DrawerItem('About', Icons.help, AboutRoute)
        ]
      ),
    );
  }
}