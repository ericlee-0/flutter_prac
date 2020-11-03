import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './chat_room_list_page.dart';

class UserListPage extends StatefulWidget {
  static const routeName = '/user-list-page';

  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  int _currentBottomNavigationIndex = 0;

  void _bottomNavigation(int index) {
    if (index == 1) {
      Navigator.of(context).pushReplacementNamed(ChatRoomListPage.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('users').orderBy('username', descending: true ).snapshots(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final userData = snapshot.data.documents;
            // print('streambuilder: ${userData.length}');
            return SingleChildScrollView(
              child: SizedBox(
                // height: 500,
                child: Column(
                  children: [ListTile(title:Text('Current User Box')),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: userData.length,
                      itemBuilder: (ctx, index) => ListTile(
                        // title:Text('User ${userData[index].documentID}'),
                        key: ValueKey(userData[index].documentID),
                        title: Text(userData[index]['username']),
                        leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage(userData[index]['image_url']),
                          radius: 25,
                        ),
                        onTap: () {
                          print(userData[index].documentID);
                        },
                      ),
                    ),
                  ],
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
