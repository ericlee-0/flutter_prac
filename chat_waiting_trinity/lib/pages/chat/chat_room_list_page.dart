// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './user_profile_edit_page.dart';
import './user_list_page.dart';
import 'chat_room_page.dart';
import 'package:intl/intl.dart';


class ChatRoomListPage extends StatefulWidget {
  static const routeName = '/chat-room-list';
  @override
  _ChatRoomListPageState createState() => _ChatRoomListPageState();
}

class _ChatRoomListPageState extends State<ChatRoomListPage> {
  int _currentBottomNavigationIndex = 1;
  final _user = FirebaseAuth.instance.currentUser;

void _bottomNavigation(int index){

  if(index == 0){
    Navigator.of(context).pushReplacementNamed(UserListPage.routeName);
  }
if(index == 2){
    Navigator.of(context).pushNamed(ChatRoomPage.routeName);
  }
}
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
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
      body: StreamBuilder(
          // stream: FirebaseFirestore.instance.collection('chats').doc('1on1').collection('chatRooms').doc('2020-11-03 10:45:50.374778').collection('chatMessages').snapshots(),
          stream: FirebaseFirestore.instance.collection('users').doc(_user.uid).collection('chatRooms').orderBy('lastMessageCreatedAt').snapshots(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final chatRoomListData = snapshot.data.documents;
            // print('streambuilder: ${chatRoomListData}');
            return SingleChildScrollView(
              child: SizedBox(
                // height: 500,
                child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: chatRoomListData.length,
                      itemBuilder: (ctx, index) => ListTile(
                        // title:Text('chats chatData'),
                        key: ValueKey(chatRoomListData[index].documentID),
                        title: Text(chatRoomListData[index]['chatUserName']),
                        subtitle: Text(chatRoomListData[index]['lastMessage']),
                        leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage(chatRoomListData[index]['chatUserImageUrl']),
                          radius: 25,
                        ),
                        trailing: Text(DateFormat.yMMMd().format(chatRoomListData[index]['lastMessageCreatedAt'].toDate())),
                        isThreeLine: true,
                        onTap: () {
                          // print(chatData[index].documentID);
                        },
                      ),
                    ),
                 
              ),
            );
          }),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Users',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            label: 'Etc',
          ),
        ],
        currentIndex: _currentBottomNavigationIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _bottomNavigation,
      ),
    );
  }
}
