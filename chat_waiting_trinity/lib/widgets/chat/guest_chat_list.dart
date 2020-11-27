import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../../controllers/chat_room_controller.dart';

class GuestChatList extends StatelessWidget {
  final String advisorId;
  GuestChatList(this.advisorId);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        // stream: FirebaseFirestore.instance.collection('chats').doc('1on1').collection('chatRooms').doc('2020-11-03 10:45:50.374778').collection('chatMessages').snapshots(),
        stream:FirebaseFirestore.instance
                .collection('users')
                .doc(advisorId)
                .collection('chatRooms')
                .where('chatRoomType', isEqualTo: 'withGuest')
                // .orderBy('lastMessageCreatedAt', descending: true)
                .snapshots(),
            
        builder: (ctx, snapshot) {
          // print('user : ${_user.uid}');
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final chatRoomListData = snapshot.data.documents;
          // print('streambuilder: ${chatRoomListData}');
          return ListView.builder(
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
              trailing: Text(DateFormat.yMMMd().format(
                  chatRoomListData[index]['lastMessageCreatedAt'].toDate())),
              isThreeLine: true,
              onTap: () {
                // print(chatRoomListData[index].data());
                ChatRoomController.instance.chatContinue(context, {
                  ...chatRoomListData[index].data(),
                  'chatRoomId': chatRoomListData[index].documentID
                });
                // print(chatData[index].documentID);
              },
            ),
          );
        },
      );
  }
}