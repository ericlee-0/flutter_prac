import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class MessageBubble extends StatelessWidget {
  final Key key;

  final dynamic chatInfo;

  MessageBubble(this.key, this.chatInfo);

  Future<void> _readMessage(bool isSelf, String path) async {
    if (!isSelf) {
      await FirebaseFirestore.instance.doc(path).update({'read': true});
    }
  }

  @override
  Widget build(BuildContext context) {
    final _user = FirebaseAuth.instance.currentUser;
    bool isSelf = false;
    // print('messagebubble ${chatInfo['sendUserName']}');
    // print('chatinfo ${chatInfo.reference.path}');
    if (chatInfo['sendUserName'] != 'system') {
      isSelf = _user.uid == chatInfo['sendUserId'];
    }

    _readMessage(isSelf, chatInfo.reference.path);
    final DateTime time = chatInfo['createdAt'].toDate();
    final formattedTime = DateFormat('MM/dd HH:mm').format(time);

    return (chatInfo['sendUserName'] == 'system')
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(chatInfo['message']),
                Text(formattedTime),
              ],
            ),
          )
        : Stack(
            children: [
              Row(
                mainAxisAlignment:
                    isSelf ? MainAxisAlignment.end : MainAxisAlignment.start,
                children: [
                  // isSelf? Text(formattedTime): null,
                  Container(
                    decoration: BoxDecoration(
                      color: isSelf
                          ? Theme.of(context).accentColor
                          : Colors.green[300],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                        bottomLeft:
                            !isSelf ? Radius.circular(0) : Radius.circular(12),
                        bottomRight:
                            isSelf ? Radius.circular(0) : Radius.circular(12),
                      ),
                    ),
                    width: 140,
                    padding: EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                    margin: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                    child: Column(
                      crossAxisAlignment: isSelf
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        Text(
                          chatInfo['sendUserName'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isSelf
                                ? Colors.white
                                : Theme.of(context)
                                    .accentTextTheme
                                    .headline1
                                    .color,
                          ),
                        ),
                        Text(
                          chatInfo['message'],
                          style: TextStyle(
                            color: isSelf
                                ? Colors.white
                                : Theme.of(context)
                                    .accentTextTheme
                                    .headline1
                                    .color,
                          ),
                          textAlign: isSelf ? TextAlign.end : TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                  // isSelf? null :Text(formattedTime),
                ],
              ),
              // if(chatInfo['sendUserType']!= 'guest' && chatInfo['sendUserType']!= 'advisor')
              // Positioned(
              //   top: 0,
              //   left: isSelf ? null : 120,
              //   right: isSelf ? 120 : null,
              //   child: CircleAvatar(
              //     backgroundImage: NetworkImage(chatInfo['sendUserImageUrl']),
              //   ),
              // ),
            ],
            clipBehavior: Clip.hardEdge,
          );
  }
}
