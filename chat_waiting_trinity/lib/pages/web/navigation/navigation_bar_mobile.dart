import './navbar_logo.dart';
import 'package:flutter/material.dart';

class NavigationBarMobile extends StatelessWidget {
  final Function drawerFn;
  NavigationBarMobile(this.drawerFn);
  @override
  Widget build(BuildContext context) {
    return Container(
      height:80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: (){
              
              drawerFn();},
          ),
          NavBarLogo(),
        ],
      )
      
    );
  }
}