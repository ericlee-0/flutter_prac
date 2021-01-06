import 'package:chat_waiting_trinity/pages/web_old/call_to_action/call_to_action.dart';
import 'package:chat_waiting_trinity/pages/web_old/web_detail.dart';
import 'package:flutter/material.dart';
import '../route/route_names.dart';

class HomeContentsMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Function dummy;
    return SingleChildScrollView(
          child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            WebDetail(),
            SizedBox(height: 100,),
            CallToAction('Join Waiting',dummy, WaitingRoute),
            // SizedBox(height: 20,),
            // CallToAction(' Onlie Chat ',dummy, ChatRoute),
          ],
      
      ),
    );
  }
}