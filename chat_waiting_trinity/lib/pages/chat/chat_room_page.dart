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
  

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;
    print('chatroompage');
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Room'),
        actions: [
          DropdownButton(
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
              child: Messages(args['chatRoomId']),
            ),
            NewMessage(args),
            
          ],
        ),
      ),
    );
  }
}
