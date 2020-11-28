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
  Map<String, dynamic> _chatRoomData;
  String _statusMessage = 'Waiting for  chat with Advisor....';

  Future<void> _guestController() async {
    _chatRoomData = await ChatRoomController.instance.chatWithGuest();
    FirebaseFirestore.instance
        .collection('chats')
        .doc(_chatRoomData['chatRoomPath'])
        .snapshots()
        .listen((event) {
      if (event.data()['chatBegin'] == true) {
        _isBegin = true;
        Navigator.pushNamedAndRemoveUntil(context, ChatRoomPage.routeName, ModalRoute.withName('/home'),arguments: _chatRoomData);
          
      }
    });
    // return Text(_statusMessage);
  }

  @override
  Widget build(BuildContext context) {
    // await _getPath();
    // if (_isBegin)
    //   Navigator.pushNamed(context, ChatRoomPage.routeName,
    //       arguments: _chatRoomData);
    _guestController();
    return WillPopScope(
      child: Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Column(
              children: [
                CircularProgressIndicator(),
                Text(_statusMessage),
              ],
            ),
          )

          // body: FutureBuilder(
          //   future: ChatRoomController.instance.chatWithGuest(),
          //   builder: (ctx, snapshot) {
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return Center(
          //         child: CircularProgressIndicator(),
          //       );
          //     }
          //     print('future ${snapshot.data}');
          //     _chatRoomData = snapshot.data;
          //     return StreamBuilder(
          //       stream: FirebaseFirestore.instance
          //           .collection('chats')
          //           .doc(snapshot.data['chatRoomPath'])
          //           // .collection('2020/11/27${snapshot.data['chatRoomId']}')
          //           // .where('chatRoomId', isEqualTo: snapshot.data['chatRoomId'])
          //           .snapshots()
          //       // .snapshot.data['chatRoomPath'])
          //       ,
          //       builder: (ctx, snapshot2) {
          //         Widget children;
          //         if (snapshot2.connectionState == ConnectionState.waiting) {
          //           children = Center(
          //             child: CircularProgressIndicator(),
          //           );
          //         } else {
          //           if (snapshot2.data['chatBegin'] == false)
          //             children = Center(
          //                 child: Text('Waiting for  chat with Advisor....'));
          //           else {
          //             children = Center(child: Text('Advisor Responded....'));
          //             // setState(() {
          //             _isBegin = true;
          //             // });

          //           }
          //         }
          //         // print('stream ${snapshot2.data['chatBegin']}');

          //         return children;
          //         //  Text('Connected chat with Advisor....');
          //       },
          //     );
          //   },
          // ),
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
