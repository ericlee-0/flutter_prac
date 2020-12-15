import 'package:flutter/material.dart';
import '../web_detail.dart';
import '../call_to_action/call_to_action.dart';

class HomeContentsDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        WebDetail(),
        Expanded(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CallToAction('Join Waiting'),
            SizedBox(
              height: 30,
            ),
            CallToAction('   Chating    '),
          ],
        ))
      ],
    );
  }
}
