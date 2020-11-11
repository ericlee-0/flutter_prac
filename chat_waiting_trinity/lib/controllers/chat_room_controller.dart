// import 'dart:html';

// import 'dart:html';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../pages/chat/chat_room_page.dart';

class ChatRoomController {
  static ChatRoomController get instance => ChatRoomController();
  final _user = FirebaseAuth.instance.currentUser;

  Future<void> chat1on1(
      BuildContext context, Map<String, dynamic> chatUserInfo) async {
    // print(userIds.contains('otherUserId'));
    try {
      final userSelfData = await FirebaseFirestore.instance
          .collection('users')
          .doc(_user.uid)
          .get();

      final chatRoomsnapshots = await FirebaseFirestore.instance
          .collection('users')
          .doc(_user.uid)
          .collection('chatRooms')
          // .orderBy('lastMessageCreatedAt')
          .where('chatRoomType', isEqualTo: '1on1')
          .where('chatUserId', isEqualTo: chatUserInfo['chatUserId'])
          .get();

      // print(chatRoomsnapshots1.docs[0].id);
      // print(chatRoomsnapshots.docs[0].data());
      // chatRoomsnapshots.docs.forEach((element) {
      //   print(element.id);
      // });
      if (chatRoomsnapshots.docs.length != 0) {
        print(chatRoomsnapshots.docs.last.id);
        final String chatRoomId = chatRoomsnapshots.docs.last.id;
        Navigator.pushNamed(context, ChatRoomPage.routeName, arguments: {
          'chatRoomId': chatRoomId,
          'chatRoomType': '1on1',
          'chatUserId': chatUserInfo['chatUserId'],
          'chatUserImageUrl': chatUserInfo['chatUserImageUrl'],
          'chatUserName': chatUserInfo['chatUserName'],
          'userSelfId': _user.uid,
          'userSelfImageUrl': userSelfData['image_url'],
          'userSelfName': userSelfData['username'],
          // 'chatUserImageUrl':userData[index]['image_url'],
        });
        return;
      }
      final String chatRoomId = DateTime.now().toString();
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_user.uid)
          .collection('chatRooms')
          .doc(chatRoomId)
          .set({
        'chatRoomType': '1on1',
        'chatUserId': chatUserInfo['chatUserId'],
        'chatUserImageUrl': chatUserInfo['chatUserImageUrl'],
        'chatUserName': chatUserInfo['chatUserName'],
      });
      await FirebaseFirestore.instance
          .collection('users')
          .doc(chatUserInfo['chatUserId'])
          .collection('chatRooms')
          .doc(chatRoomId)
          .set({
        'chatRoomType': '1on1',
        'chatUserId': _user.uid,
        'chatUserImageUrl': userSelfData['image_url'],
        'chatUserName': userSelfData['username'],
      });
      Navigator.pushNamed(context, ChatRoomPage.routeName, arguments: {
        'chatRoomId': chatRoomId,
        'chatRoomType': '1on1',
        'chatUserId': chatUserInfo['chatUserId'],
        'chatUserImageUrl': chatUserInfo['chatUserImageUrl'],
        'chatUserName': chatUserInfo['chatUserName'],
        'userSelfId': _user.uid,
        'userSelfImageUrl': userSelfData['image_url'],
        'userSelfName': userSelfData['username'],
        // 'chatUserImageUrl':userData[index]['image_url'],
      });
      // print(chatRoomsnapshots1.docs[0].data());

    } catch (e) {
      print(e);
    }
  }
}
