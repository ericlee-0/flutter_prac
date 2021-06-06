import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../../controllers/chat_room_controller.dart';
import './chat_room.dart';

class ChatWithGuestList extends StatefulWidget {
  final String advisorId;
  // GuestChatList(this.advisorId);
  // final Stream<QuerySnapshot> listData;
  ChatWithGuestList({this.advisorId, Key key}) : super(key: key);

  @override
  _ChatWithGuestListState createState() => _ChatWithGuestListState();
}

class _ChatWithGuestListState extends State<ChatWithGuestList> {
  DateTime today;
  // DateTime roundUpTime ;
  String docId;
  bool _roomChose = false;
  Map<String, dynamic> _chatInfo;
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
    return _roomChose
        ?
        // ChatRoomController.instance.chatContinuewithGuest(_chatInfo)
        ChatRoom(
            chatInfo: {
                'chatRoomId': _chatInfo['chatRoomId'],
                'chatRoomType': _chatInfo['chatRoomType'],
                'chatRoomPath': _chatInfo['chatRoomPath'],
                'chatUserId': _chatInfo['chatUserId'],
                'chatUserImageUrl': _chatInfo['chatUserImageUrl'],
                'chatUserName': _chatInfo['chatUserName'],
                'userSelfId': widget.advisorId,
                'userSelfImageUrl': '',
                'userSelfName': 'admin',
                // 'chatUserImageUrl':userData[index]['image_url'],
              },
            chatDoneFn: (value) {
              setState(() {
                _roomChose = !value;
              });
            })
        : StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(widget.advisorId)
                .collection(docId)
                .orderBy('createdAt')
                .snapshots(),
            builder: (ctx, snapshot) {
              // print('user : ${}');
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final chatRoomListData = snapshot.data.docs;
              print('streambuilder: ${chatRoomListData.length}');
              return Container(
                height: 500,
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        // shrinkWrap: true,
                        itemCount: chatRoomListData.length,
                        itemBuilder: (ctx, index) => ListTile(
                          // title:Text('chats chatData'),
                          key: ValueKey(chatRoomListData[index].id),
                          title: Text(chatRoomListData[index]['chatUserName']),
                          subtitle: Column(
                            children: [
                              // DateTime.parse(chatRoomListData[index].documentID.toString());
                              Text(chatRoomListData[index].id.substring(5, 16)),
                              // Text(DateFormat('yyyy/MM/dd HH:mm').format(
                              //     chatRoomListData[index]['lastMessageCreatedAt'].toDate())),
                            ],
                          ),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                chatRoomListData[index]['chatUserImageUrl']),
                            radius: 25,
                          ),
                          trailing: ElevatedButton(
                            child: chatRoomListData[index]['chatFinished']
                                ? Text('Finished')
                                : Text('Anser'),
                            onPressed: () {
                              if (chatRoomListData[index]['chatUserName'] ==
                                      'guest' ||
                                  chatRoomListData[index]['chatUserName'] ==
                                      'test') {
                                FirebaseFirestore.instance
                                    .collection('chats')
                                    .doc(
                                        chatRoomListData[index]['chatRoomPath'])
                                    .update({'chatBegin': true});
                              }
                              setState(() {
                                _roomChose = true;
                                _chatInfo = {
                                  ...chatRoomListData[index].data(),
                                  'chatRoomId': chatRoomListData[index].id
                                };
                              });
                              // ChatRoomController.instance.chatContinue(context, {
                              //   ...chatRoomListData[index].data(),
                              //   'chatRoomId': chatRoomListData[index].id
                              // });
                            },
                          ),

                          isThreeLine: true,
                          onTap: () {
                            // print(chatRoomListData[index].data());

                            // print(chatData[index].documentID);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
  }
}
