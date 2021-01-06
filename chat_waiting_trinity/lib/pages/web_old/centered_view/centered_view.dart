import 'package:flutter/material.dart';

class CenteredView extends StatelessWidget {
  final Widget child;
  CenteredView({this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 30),
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        child: child,
        constraints: BoxConstraints(maxWidth: 1200),
      ),
    );
  }
}
