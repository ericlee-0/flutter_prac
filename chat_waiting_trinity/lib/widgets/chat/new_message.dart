import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class NewMessage extends StatefulWidget {
  final Map<String, dynamic> chatInfo;
  NewMessage(this.chatInfo);
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = TextEditingController();
  var _enteredMessage = '';

  void _sendMessage(Map<String,dynamic> chatInfo) async {
    FocusScope.of(context).unfocus();
    // final user = FirebaseAuth.instance.currentUser;
    // final userData = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    final Timestamp createdTime = Timestamp.now();
    print('new message charoompath : ${chatInfo['chatRoomPath']}');
    try{
    await FirebaseFirestore.instance
          .collection('chats')
          .doc(chatInfo['chatRoomPath'])
          // .collection('chatRooms')
          // .doc(chatInfo['chatRoomId'])
          .collection('chatMessages')
          .add({
        'message': _enteredMessage,
        'createdAt': createdTime,
        'sendUserId': chatInfo['userSelfId'],
        'sendUserName': chatInfo['userSelfName'],
        'sendUserImageUrl': chatInfo['userSelfImageUrl'],
        'receiveUserId': chatInfo['chatUserId'],
        'receiveUserName': chatInfo['chatUserName'],
        'receiverUserImageUrl': chatInfo['chatUserImageUrl']
      });

      await FirebaseFirestore.instance
          .collection('users')
          .doc(chatInfo['userSelfId'])
          .collection('chatRooms')
          .doc(chatInfo['chatRoomId'])
          .update({
        'lastMessage': _enteredMessage,
        'lastMessageCreatedAt': createdTime
      });
      await FirebaseFirestore.instance
          .collection('users')
          .doc(chatInfo['chatUserId'])
          .collection('chatRooms')
          .doc(chatInfo['chatRoomId'])
          .update({
        'lastMessage': _enteredMessage,
        'lastMessageCreatedAt': createdTime
      });
    }catch(e){
      print(e);
    }
    _controller.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              enableSuggestions: true,
              decoration: InputDecoration(labelText: 'Send a message...'),
              onChanged: (value) {
                setState(() {
                  _enteredMessage = value;
                });
              },
            ),
          ),
          IconButton(
            color: Theme.of(context).primaryColor,
            icon: Icon(Icons.send),
            onPressed: _enteredMessage.trim().isEmpty ? null :()=>_sendMessage(widget.chatInfo),
          ),
        ],
      ),
    );
  }
}