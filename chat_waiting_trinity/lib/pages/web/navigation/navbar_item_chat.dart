import 'package:flutter/material.dart';
import '../../../locator.dart';
import './navigation_service.dart';

class NavBarItemChat extends StatelessWidget {
  final String title;
  // final String navigationPath;
  final Function fn;
  NavBarItemChat(this.title, this.fn);
  @override
  Widget build(BuildContext context) {
    
    return GestureDetector(
      onTap: (){
        // locator<NavigationService>().navigateTo(navigationPath);
        fn();

      },
          child: Text(
        title,
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}