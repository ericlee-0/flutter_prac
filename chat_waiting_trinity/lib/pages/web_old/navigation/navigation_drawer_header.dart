import 'package:flutter/material.dart';

class NavigationDrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      color: Theme.of(context).primaryColor,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Chat-Waiting',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white),
          ),
          Text(
            'TAP HERE',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
