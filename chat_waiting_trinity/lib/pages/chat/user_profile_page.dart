import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../controllers/chat_room_controller.dart';

class UserProfilePage extends StatelessWidget {
  static const routeName = '/user-profile-page';
  
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final Map<String,dynamic> args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(),
        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage(args['chatUserImageUrl']),
                ),
                Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Text(args['chatUserName']),
                ),
                RaisedButton(
                  child: Text('Start chat 1 on 1'),
                  onPressed: () {
                    // print(args[0]);
                    print(currentUser.uid);
                    ChatRoomController.instance.chat1on1(context,args);
                  },
                )
              ],
            ),
          ),
        ));
  }
}
