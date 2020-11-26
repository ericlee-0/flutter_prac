import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MessageBubble extends StatelessWidget {
  final Key key;
 
  final dynamic chatInfo;

  MessageBubble(this.key, this.chatInfo);

  @override
  Widget build(BuildContext context) {
    final _user = FirebaseAuth.instance.currentUser;
    final bool isSelf = _user.uid == chatInfo['sendUserId'];
    return Stack(
      children: [
        Row(
          mainAxisAlignment:
              isSelf ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color:
                    isSelf ? Theme.of(context).accentColor : Colors.green[300],
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
                crossAxisAlignment:
                    isSelf ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    chatInfo['sendUserName'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isSelf
                          ? Colors.white
                          : Theme.of(context).accentTextTheme.headline1.color,
                    ),
                  ),
                  Text(
                    chatInfo['message'],
                    style: TextStyle(
                      color: isSelf
                          ? Colors.white
                          : Theme.of(context).accentTextTheme.headline1.color,
                    ),
                    textAlign: isSelf ? TextAlign.end : TextAlign.start,
                  ),
                ],
              ),
            ),
          ],
        ),
        // if(chatInfo['sendUserType']!= 'guest' && chatInfo['sendUserType']!= 'advisor')
        Positioned(
          top: 0,
          left: isSelf ? null : 120,
          right: isSelf ? 120 : null,
          child: CircleAvatar(
            backgroundImage: NetworkImage(chatInfo['sendUserImageUrl']),
          ),
        ),
      ],
      clipBehavior: Clip.hardEdge,
    );
  }
}
