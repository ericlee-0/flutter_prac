import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import './user_profile_edit_page.dart';
class ChatRoomPage extends StatefulWidget {
  static const routeName = '/chat-room-page';
  @override
  _ChatRoomPageState createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  final _user = FirebaseAuth.instance.currentUser;
  bool _newChat = true;
  final String _chatRoomType = '1on1';
  final String _chatRoomId = DateTime.now().toString();

  Future<void> _createChatRoom(
      String chatRoomId, String type, Map<String, dynamic> roomUserData) async {
    await FirebaseFirestore.instance
        .collection('chats')
        .doc(type)
        .collection('chatRooms')
        .doc(chatRoomId)
        .set(roomUserData);

    return;
  }

  Future<void> _generateMessage() async {
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(_user.uid)
        .get();

    // Future<String> chatRoomId;

    // print(docId.parent.parent.id);
    if (_newChat) {
      await _createChatRoom(_chatRoomId, _chatRoomType, {
        'firstUserId': _user.uid,
        'firstUserImageUrl': userData['image_url'],
        'firstUserName': userData['username'],
        'secondUserId': 'otherUserId',
        'secondUserImageUrl': 'otherUserImageUrl',
        'secondUserName': 'otherUserName',
      });
      setState(() {
        _newChat = false;
      });
    }

    await FirebaseFirestore.instance
        .collection('chats')
        .doc(_chatRoomType)
        .collection('chatRooms')
        .doc(_chatRoomId)
        .collection('chatMessages')
        .add({
      'message': 'Auto message at ${Timestamp.now()}',
      'createdAt': Timestamp.now().toString(),
      'sendUserId': _user.uid,
      'receiveUserId': 'who receive?',
      'userName': userData['username'],
      'userImage': userData['image_url']
    });
    await FirebaseFirestore.instance
        .collection('chats')
        .doc(_chatRoomType)
        .collection('chatRooms')
        .doc(_chatRoomId)
        .update({'lastMessage':'Last Message','lastMessageCreatedAt':Timestamp.now()});
  }
  

  @override
  Widget build(BuildContext context) {
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
                  Navigator.of(context).pushNamed(UserProfileEditPage.routeName);
                }
                else if (itemIdentifier == 'logout') {
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushNamed('/');
                }else if (itemIdentifier == 'test') {
                  // Navigator.of(context).pushNamed(UserProfileImagePicker.routeName);
                }
              })
        ],
      ),
      body: RaisedButton(
        child: Text('Message generate'),
        onPressed: _generateMessage,
      ),
    );
  }
}
