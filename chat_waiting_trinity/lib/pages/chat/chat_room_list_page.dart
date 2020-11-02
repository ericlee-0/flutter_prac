
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './user_profile_edit_page.dart';
import './user_list_page.dart';

class ChatRoomListPage extends StatefulWidget {
  static const routeName = '/chat-room-list';
  @override
  _ChatRoomListPageState createState() => _ChatRoomListPageState();
}

class _ChatRoomListPageState extends State<ChatRoomListPage> {
  int _currentBottomNavigationIndex = 1;

void _bottomNavigation(int index){

  if(index == 0){
    Navigator.of(context).pushReplacementNamed(UserListPage.routeName);
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
                }else if (itemIdentifier == 'test') {
                  // Navigator.of(context).pushNamed(UserProfileImagePicker.routeName);
                }
              })
        ],
      ),
      body: Container(
        child: Text('Chat Room List'),
      ),
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
