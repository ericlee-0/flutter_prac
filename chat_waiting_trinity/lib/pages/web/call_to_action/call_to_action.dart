import 'package:flutter/material.dart';

class CallToAction extends StatelessWidget {

  final String title;
  final Function endDrawer;
  CallToAction(this.title,this.endDrawer);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white),
      ),
      decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(5)),
       
    );
  }
}
