import 'package:flutter/material.dart';
import './web_nav_bar.dart';

class WebHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color.fromRGBO(89, 185, 212, 1.0),
              Color.fromRGBO(41, 94, 163, 1.0)
            ],
          ),
        ),
        child: Column(children: [
          
          WebNavBar(),
        ]),
      ),
    );
  }
}
