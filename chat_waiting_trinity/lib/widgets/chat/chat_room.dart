import '../../controllers/chat_room_controller.dart';
import 'package:chat_waiting_trinity/widgets/chat/guest_chat_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:intl/intl.dart';
// import './user_profile_edit_page.dart';
import '../../widgets/chat/messages.dart';
import '../../widgets/chat/new_message.dart';

class ChatRoom extends StatefulWidget {
  static const routeName = '/chat-room-page';
  final Map<String, dynamic> chatInfo;
  final Function(bool) chatDoneFn;

  const ChatRoom({Key key, this.chatInfo, this.chatDoneFn}) : super(key: key);
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> _showExitDialog(Map<String, dynamic> args) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Warning'),
          content: Text('Do you really want to stop chating and back to main?'),
          actions: [
            FlatButton(
                child: Text('Yes'),
                // onPressed: () => Navigator.pop(c, true),
                onPressed: () async {
                  await ChatRoomController.instance
                      .chatFinish(args['chatRoomPath'], args['userSelfName']);
                  Navigator.of(context).pop();
                  Navigator.popAndPushNamed(context, '/home');
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

  Future<void> _read(String userId, String roomId) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc('$userId/chatRooms/$roomId')
        .update({'unRead': 0});
    print('readed');
  }

  @override
  Widget build(BuildContext context) {
    final _user = FirebaseAuth.instance.currentUser;
    final Map<String, dynamic> args =
        ModalRoute.of(context).settings.arguments ?? widget.chatInfo;
    print('ChatRoom');
    final isSelf = _user.uid == args['userSelfId'];
    if (isSelf &&
        (args['chatUserName'] != 'guest' || args['chatUserName'] != 'test')) {
      // _read(args['userSelfId'], args['chatRoomId']);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Room'),
        actions: [
          (args['userSelfName'] == 'guest' || args['userSelfName'] == 'test')
              ? IconButton(
                  icon: Icon(Icons.exit_to_app),
                  onPressed: () => _showExitDialog(args))
              : DropdownButton(
                  underline: Container(),
                  icon: Icon(
                    Icons.more_vert,
                    color: Theme.of(context).primaryIconTheme.color,
                  ),
                  items: [
                    DropdownMenuItem(
                      child: Container(
                        child: Row(
                          children: [
                            Icon(Icons.exit_to_app),
                            SizedBox(
                              width: 8,
                            ),
                            Text('exit')
                          ],
                        ),
                      ),
                      value: 'exit',
                    ),
                    DropdownMenuItem(
                      child: Container(
                        child: Row(
                          children: [
                            Icon(Icons.edit),
                            SizedBox(
                              width: 8,
                            ),
                            Text('Edit Profile')
                          ],
                        ),
                      ),
                      value: 'edit',
                    ),
                    args['chatUserName'] == 'test'
                        ? DropdownMenuItem(
                            child: Container(
                              child: Row(
                                children: [
                                  Icon(Icons.exit_to_app),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text('done chat')
                                ],
                              ),
                            ),
                            value: 'finisihed',
                          )
                        : DropdownMenuItem(
                            child: Container(
                              child: Row(
                                children: [
                                  Icon(Icons.exit_to_app),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text('Finish Chat')
                                ],
                              ),
                            ),
                            value: 'finished',
                          ),
                  ],
                  onChanged: (itemIdentifier) async {
                    if (itemIdentifier == 'edit') {
                      // Navigator.of(context)
                      //     .pushNamed(UserProfileEditPage.routeName);
                    } else if (itemIdentifier == 'exit') {
                      // FirebaseAuth.instance.signOut();
                      widget.chatDoneFn(true);
                      // Navigator.of(context).pushNamed('/');
                    } else if (itemIdentifier == 'test') {
                      // Navigator.of(context).pushNamed(UserProfileImagePicker.routeName);
                    } else if (itemIdentifier == 'finisihed') {
                      // print('args');
                      // print('args ${args['userSelfId']} ${args['chatRoomId']} ');
                      await ChatRoomController.instance.chatFinish(
                          args['chatRoomPath'], args['userSelfName']);
                      String roomId = args['chatRoomPath']
                          .substring(10, args['chatRoomPath'].length);
                      // print(roomId);
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc('${args['userSelfId']}/$roomId')
                          // .collection(args['chatRoom'])
                          // .doc(args['chatRoomId'])
                          .update({'chatFinished': true});
                      widget.chatDoneFn(true);
                      // Navigator.of(context).pop();
                      // Navigator.of(context).pop();
                      // Navigator.of(context).pop();
                      // Navigator.of(context).pushNamed(UserProfileImagePicker.routeName);
                    }
                  })
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Messages(args['chatRoomPath']),
            ),
            NewMessage(args),
          ],
        ),
      ),
    );
  }
}
