import 'package:flutter/material.dart';
import './chat_drawer_header.dart';

class ChatDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(color:Colors.blue, blurRadius: 16)
      ]),
      child: Column(
        children: [
          ChatDrawerHeader(),
          // DrawerItem('Waiting', Icons.list_alt, WaitingRoute),
          // DrawerItem('Chat', Icons.chat, ChatRoute),
          // DrawerItem('About', Icons.help, AboutRoute)
        ]
      ),
    );
  }
}