import './chat_badge.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../../controllers/chat_room_controller.dart';

class ChatRoomList extends StatefulWidget {
  final String userId;
  final Stream<QuerySnapshot> listData;
  ChatRoomList({this.userId, this.listData, Key key}) : super(key: key);
  @override
  _ChatRoomListState createState() => _ChatRoomListState();
}

class _ChatRoomListState extends State<ChatRoomList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.listData,
      builder: (ctx, snapshot) {
        // print('user : ${_user.uid}');
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatRoomListData = snapshot.data.docs;
        // print('streambuilder: ${chatRoomListData}');
        return ListView.builder(
          shrinkWrap: true,
          itemCount: chatRoomListData.length,
          itemBuilder: (ctx, index) {
            // print('unread No :${chatRoomListData[index]['unRead']}');
            final unread = chatRoomListData[index]['unRead'];
            // _newChatRoomCount = _badgeControll(_newChatRoomCount, unread);
            return ListTile(
              // title:Text('chats chatData'),
              key: ValueKey(chatRoomListData[index].id),
              title: Text(chatRoomListData[index]['chatUserName']),
              subtitle: Text(chatRoomListData[index]['lastMessage']),
              leading: CircleAvatar(
                backgroundImage:
                    NetworkImage(chatRoomListData[index]['chatUserImageUrl']),
                radius: 25,
              ),
              trailing: Column(
                children: [
                  Text(DateFormat.yMMMd().format(chatRoomListData[index]
                          ['lastMessageCreatedAt']
                      .toDate())),
                  // Badge(value: chatRoomListData[index]['unRead'].toString()),
                  // (unread == 0)? Container() :_badge(unread.toString()),
                  ChatBadge(unread),
                ],
              ),
              isThreeLine: true,
              onTap: () {
                // print(chatRoomListData[index].data());
                ChatRoomController.instance.chatContinue(context, {
                  ...chatRoomListData[index].data(),
                  'chatRoomId': chatRoomListData[index].id
                });
                // print(chatData[index].documentID);
              },
            );
          },
        );
      },
    );
  }
}
