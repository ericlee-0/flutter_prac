import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../../controllers/chat_room_controller.dart';

class GuestChatList extends StatefulWidget {
  final String advisorId;
  GuestChatList(this.advisorId);

  @override
  _GuestChatListState createState() => _GuestChatListState();
}

class _GuestChatListState extends State<GuestChatList> {
  DateTime today;
  // DateTime roundUpTime ;
  String docId;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    today = DateTime.now();
    // roundUpTime = today.subtract(Duration(hours: today.hour ));
    docId = DateFormat('yyyy/MM/dd').format(today);

  }


  // final DateTime today = DateTime.now();

  // final DateTime roundUpTime = today.subtract(Duration(hours: today.hour ));

  @override
  Widget build(BuildContext context) {
    // print('roundup time $roundUpTime');
    return StreamBuilder(
      // stream: FirebaseFirestore.instance.collection('chats').doc('1on1').collection('chatRooms').doc('2020-11-03 10:45:50.374778').collection('chatMessages').snapshots(),
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(widget.advisorId)
          .collection(docId)
          // .doc(docId)
          // .where('chatRoomType', isEqualTo: 'withGuest')
          // .where('createdAt', isGreaterThan: roundUpTime)
          .orderBy('createdAt')
          // .orderBy('lastMessageCreatedAt', descending: true)
          .snapshots(),

      builder: (ctx, snapshot) {
        // print('user : ${}');
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatRoomListData = snapshot.data.documents;
        // print('streambuilder: ${chatRoomListData.length}');
        return ListView.builder(
          shrinkWrap: true,
          itemCount: chatRoomListData.length,
          itemBuilder: (ctx, index) => ListTile(
            // title:Text('chats chatData'),
            key: ValueKey(chatRoomListData[index].documentID),
            title: Text(chatRoomListData[index]['chatUserName']),
            subtitle: Column(
              children: [
                // DateTime.parse(chatRoomListData[index].documentID.toString());
                Text(chatRoomListData[index].documentID.substring(5,16)),
                // Text(DateFormat('yyyy/MM/dd HH:mm').format(
                //     chatRoomListData[index]['lastMessageCreatedAt'].toDate())),
              ],
            ),
            leading: CircleAvatar(
              backgroundImage:
                  NetworkImage(chatRoomListData[index]['chatUserImageUrl']),
              radius: 25,
            ),
            trailing: RaisedButton(
              child: chatRoomListData[index]['chatFinished'] ? Text('Finished'):Text('Anser'),
              onPressed: () {
                ChatRoomController.instance.chatContinue(context, {
                  ...chatRoomListData[index].data(),
                  'chatRoomId': chatRoomListData[index].documentID
                });
              },
            ),

            isThreeLine: true,
            onTap: () {
              // print(chatRoomListData[index].data());

              // print(chatData[index].documentID);
            },
          ),
        );
      },
    );
  }
}
