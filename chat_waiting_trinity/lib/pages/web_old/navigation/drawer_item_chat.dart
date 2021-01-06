import './navbar_item.dart';
import 'package:flutter/material.dart';
import './navbar_item_chat.dart';

class DrawerItemChat extends StatelessWidget {
  final String title;
  final IconData icon;
  // final String navigationPath;
  final Function fn;
  DrawerItemChat(this.title, this.icon,this.fn);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, top:60),
      child: Row(children:[
        Icon(icon),
        SizedBox(width: 30,),
        NavBarItemChat(title,fn),
      ]),
    );
  }
}