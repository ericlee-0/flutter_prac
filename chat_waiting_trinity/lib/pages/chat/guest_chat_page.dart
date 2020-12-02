// import 'dart:html';

import 'package:flutter/material.dart';
import './../../controllers/chat_room_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './chat_room_page.dart';

class GuestChatPage extends StatefulWidget {
  static const routeName = '/guest-chat-page';

  @override
  _GuestChatPageState createState() => _GuestChatPageState();
}

class _GuestChatPageState extends State<GuestChatPage> {
  bool _isBegin = false;

  String _statusMessage = 'Waiting for  chat with Advisor....';

  Future<void> _guestController() async {
    final chatRoomData = await ChatRoomController.instance.chatWithGuest();
    print('created guest chat room');
    FirebaseFirestore.instance
        .collection('chats')
        .doc(chatRoomData['chatRoomPath'])
        .snapshots()
        .listen((event) {
      if (event.data()['chatBegin'] == true) {
        _isBegin = false;
        Navigator.pushNamedAndRemoveUntil(
            context, ChatRoomPage.routeName, ModalRoute.withName('/home'),
            arguments: chatRoomData);
      }
    });
    // return Text(_statusMessage);
  }

  Future<void> _showConfirmDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(''),
          content: Text('Do you want to chat with advisor?'),
          actions: [
            FlatButton(
                child: Text('Yes'),
                // onPressed: () => Navigator.pop(c, true),
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    _isBegin = true;
                  });

                  // Navigator.popAndPushNamed(context, '/home');
                }),
            FlatButton(
              child: Text('No'),
              onPressed: () => Navigator.pop(context, false),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // await _getPath();
    // if (_isBegin)
    //   Navigator.pushNamed(context, ChatRoomPage.routeName,
    //       arguments: _chatRoomData);
    if (_isBegin) {
      _guestController();
    }
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(),
        body: _isBegin
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Text(_statusMessage),
                  ],
                ),
              )
            : _showConfirmDialog(),
      ),
      onWillPop: () => showDialog<bool>(
        context: context,
        builder: (c) => AlertDialog(
          title: Text('Warning'),
          content: Text('Do you really want to stop chating and back to main?'),
          actions: [
            FlatButton(
              child: Text('Yes'),
              // onPressed: () => Navigator.pop(c, true),
              onPressed: () => Navigator.pushReplacementNamed(c, '/home'),
            ),
            FlatButton(
              child: Text('No'),
              onPressed: () => Navigator.pop(c, false),
            ),
          ],
        ),
      ),
    );
  }
}
