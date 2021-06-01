import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './message_bubble.dart';

class Messages extends StatelessWidget {
  final String chatRoomPath;
  Messages(this.chatRoomPath);

  @override
  Widget build(BuildContext context) {
    // print('chatroompath $chatRoomPath');
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chats')
          // .doc('1on1')
          // .collection('chatRooms')
          .doc(chatRoomPath)
          .collection('chatMessages')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (ctx, chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        final chatDocs = chatSnapshot.data.docs;
        // print('chatmessage path ${chatDocs[0].reference.path}');
        return ListView.builder(
            reverse: true,
            itemCount: chatDocs.length,
            itemBuilder: (ctx, index) {
              return MessageBubble(
                  ValueKey(chatDocs[index].id), chatDocs[index]);
            });
      },
    );
  }
}
