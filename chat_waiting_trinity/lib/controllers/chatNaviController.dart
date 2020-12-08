import 'package:chat_waiting_trinity/widgets/chat/guest_chat_list.dart';

import '../widgets/chat/chat_badge.dart';

import '../widgets/chat/chat_appbar.dart';
// import '../widgets/chat/dummy.dart';
import '../widgets/chat/user_list.dart';
import '../widgets/chat/chat_room_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatNavicontroller extends StatefulWidget {
  @override
  _ChatNavicontrollerState createState() => _ChatNavicontrollerState();
}

class _ChatNavicontrollerState extends State<ChatNavicontroller> {
  final User _user = FirebaseAuth.instance.currentUser;
  bool _isAdvisor;
  DateTime _today;
  String _guestDocId;
  List<Widget> _pages;
  Future<QuerySnapshot> _userList = FirebaseFirestore.instance
      .collection('users')
      // .where('username',isEqualTo:'guest')
      .orderBy('username', descending: true)
      .get();

  int _chatRoomListUnread = 0;
  int _guestChatUnread = 0;

  Stream<QuerySnapshot> _chatRoomListStream;
  // Stream<QuerySnapshot> _guestChatListStream;

  Future<void> _getUnread() async {
    int counter = 0;
    int preCounter = _chatRoomListUnread;
    int counterGuest = 0;
    int preCounterGuest = _guestChatUnread;
    // print('getUnread ${_chatRoomListStream}');
    FirebaseFirestore.instance
        .collection('users')
        .doc(_user.uid)
        .collection('chatRooms')
        .where('chatRoomType', isEqualTo: '1on1')
        .orderBy('lastMessageCreatedAt', descending: true)
        .snapshots()
        .listen((event) {
      event.docs.forEach((element) {
        // print('${element['unRead']}');
        counter += element['unRead'];
      });
      // print('unreadcount $counter');
      if (counter != preCounter) {
        setState(() {
          _chatRoomListUnread = counter;
        });
      }
    });
    // print(_guestDocId);
    if (_isAdvisor) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(_user.uid)
          .collection(_guestDocId)
          .snapshots()
          .listen((event) {
        // print('guestchatlength : ${event.docs.length}');
        // event.docs.
        event.docs.forEach((element) {
          // print('${element['unRead']}');
          if (element['chatFinished'] == false) counterGuest++;
        });
        if (counterGuest != preCounterGuest) {
          setState(() {
            _guestChatUnread = counterGuest;
          });
        }
      });
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _today = DateTime.now();
    // roundUpTime = today.subtract(Duration(hours: today.hour ));
    _guestDocId = DateFormat('yyyy/MM/dd').format(_today);

    _isAdvisor = _user.uid == 'M0clGRrBRMQSfQykuyA72WwHLgG2';
    _chatRoomListStream = FirebaseFirestore.instance
        .collection('users')
        .doc(_user.uid)
        .collection('chatRooms')
        .where('chatRoomType', isEqualTo: '1on1')
        .orderBy('lastMessageCreatedAt', descending: true)
        .snapshots();

    _pages = [
      UserList(
        key: PageStorageKey('UserList'),
        userId: _user.uid,
        listData: _userList,
      ),
      ChatRoomList(
        userId: _user.uid,
        listData: _chatRoomListStream,
        key: PageStorageKey('ChatRoomList'),
      ),
      _isAdvisor
          ? GuestChatList(
              advisorId: _user.uid,
              listData: FirebaseFirestore.instance
                  .collection('users')
                  .doc(_user.uid)
                  .collection(_guestDocId)
                  .orderBy('createdAt')
                  .snapshots(),
              key: PageStorageKey('GuestChatList'),
            )
          : Text('Nothig here yet')
    ];
  }

  final PageStorageBucket bucket = PageStorageBucket();

  int _selectedIndex = 0;

  Widget _bottomNavigationBar(int selectedIndex) {
    _getUnread();
    return BottomNavigationBar(
      onTap: (int index) => setState(() => _selectedIndex = index),
      currentIndex: selectedIndex,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'User List'),
        BottomNavigationBarItem(
            icon: Stack(children: [
              Icon(
                Icons.chat_bubble,
                color: Colors.grey,
              ),
              Positioned(
                top: 0,
                right: 0,
                child: ChatBadge(_chatRoomListUnread),
              )
            ]),
            label: 'Chat Room List'),
        _isAdvisor
            ? BottomNavigationBarItem(
                icon: Stack(children: [
                  Icon(
                    Icons.emoji_people,
                    color: Colors.grey,
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: ChatBadge(_guestChatUnread),
                  )
                ]),
                label: 'Guest Chat List')
            : BottomNavigationBarItem(icon:Icon(Icons.not_interested), label: 'Nothing')
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    _getUnread();
    return Scaffold(
      appBar: ChatAppBar(appBar: AppBar()),
      bottomNavigationBar: _bottomNavigationBar(_selectedIndex),
      body: PageStorage(
        child: _pages[_selectedIndex],
        bucket: bucket,
      ),
    );
  }
}
