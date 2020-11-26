import 'package:flutter/material.dart';
import './../../controllers/chat_room_controller.dart';

class GuestChatPage extends StatelessWidget {
  static const routeName = '/guest-chat-page';
  // bool _isResponse = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Center(
            child: RaisedButton(
          child: Text('Start chat with Advisor'),
          onPressed: () {
            // print(args[0]);
            // print(currentUser.uid);
            ChatRoomController.instance.chatWithGuest(context);
          },
        )),
      ),
    );
  }
}
