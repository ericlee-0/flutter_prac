import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:intl/intl.dart';
import './user_profile_edit_page.dart';
import '../../widgets/chat/messages.dart';
import '../../widgets/chat/new_message.dart';

class ChatRoomPage extends StatefulWidget {
  static const routeName = '/chat-room-page';
  @override
  _ChatRoomPageState createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  Future<void> _showExitDialog() async {
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
                onPressed: () {
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

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;
    print('chatroompage');
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Room'),
        actions: [
          (args['userSelfName'] == 'guest' || args['userSelfName'] == 'test')
              ? IconButton(
                  icon: Icon(Icons.exit_to_app),
                  onPressed: () => _showExitDialog())
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
                            Text('Logout')
                          ],
                        ),
                      ),
                      value: 'logout',
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
                    DropdownMenuItem(
                      child: Container(
                        child: Row(
                          children: [
                            Icon(Icons.exit_to_app),
                            SizedBox(
                              width: 8,
                            ),
                            Text('Test Page')
                          ],
                        ),
                      ),
                      value: 'test',
                    ),
                  ],
                  onChanged: (itemIdentifier) {
                    if (itemIdentifier == 'edit') {
                      Navigator.of(context)
                          .pushNamed(UserProfileEditPage.routeName);
                    } else if (itemIdentifier == 'logout') {
                      FirebaseAuth.instance.signOut();
                      Navigator.of(context).pushNamed('/');
                    } else if (itemIdentifier == 'test') {
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
