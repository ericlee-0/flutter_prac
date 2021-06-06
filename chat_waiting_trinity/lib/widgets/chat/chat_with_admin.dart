import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../controllers/chat_room_controller.dart';
import './chat_room.dart';

class ChatWithAdmin extends StatefulWidget {
  final Function popToggleFn;

  const ChatWithAdmin({Key key, this.popToggleFn}) : super(key: key);
  @override
  _ChatWithAdminState createState() => _ChatWithAdminState();
}

class _ChatWithAdminState extends State<ChatWithAdmin> {
  bool _isBegin = false;
  bool _isWaiting = false;
  var chatRoomData;

  String _statusMessage = 'Waiting for chat with Agent....';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<void> _guestController() async {
    print('created guest room');
    try {
      chatRoomData = await ChatRoomController.instance.chatWithGuest();
      // print('created guest chat room');
      FirebaseFirestore.instance
          .collection('chats')
          .doc(chatRoomData['chatRoomPath'])
          .snapshots()
          .listen((event) {
        if (event.data()['chatBegin'] == true) {
          setState(() {
            _isBegin = true;
          });
        }
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isWaiting
        ? _isBegin
            ? ChatRoom(chatInfo: chatRoomData)
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Text(_statusMessage),
                  ],
                ),
              )
        : Center(
            child: ElevatedButton(
                child: Text('Request'),
                onPressed: () {
                  setState(() {
                    _isWaiting = true;
                  });
                  _guestController();
                }),
          );
  }
}
