import '../../../pages/chat/auth_page_web.dart';
import '../../../pages/chat/guest_chat_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WebChatContainer extends StatefulWidget {
  @override
  _WebChatContainerState createState() => _WebChatContainerState();
}

class _WebChatContainerState extends State<WebChatContainer> {
  bool _isAuth =
      FirebaseAuth.instance.currentUser != null; //firebase auth check
  bool _chatBegin = false; // firecloud chatbegin check

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    print('isAuth? ${FirebaseAuth.instance.currentUser}');
    return Container(
      color: Colors.blue,
      constraints: BoxConstraints(
        maxWidth: 400.0,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'web chat',
                  style: TextStyle(
                      fontSize: 18.0,
                      // fontWeight: FontWeight,
                      color: Colors.grey),
                ),
              ),
              Icon(Icons.chat_bubble, color: Colors.grey),
              const SizedBox(width: 8.0),
              Icon(Icons.more_horiz, color: Colors.grey),
            ],
          ),
          _chatBegin
              ? Container(
                  // futurebuilder? streambuilder?
                  color: Colors.green[200],
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  height: screenSize.height,
                  width: screenSize.width,
                  // height: double.infinity,
                  child: _isAuth ? Text('guestchatconatiner') : AuthPageWeb())
              : Container(
                  child: Column(children: [
                    SizedBox(height: 150),
                    RaisedButton(
                      onPressed: () {
                        //fireclould update with id
                        setState(() {
                          _chatBegin = true;
                        });

                        print('chat with agent');
                      },
                      textColor: Colors.white,
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: <Color>[
                              Color(0xFF0D47A1),
                              Color(0xFF1976D2),
                              Color(0xFF42A5F5),
                            ],
                          ),
                        ),
                        padding: const EdgeInsets.all(10.0),
                        child: const Text('Chat with Agent',
                            style: TextStyle(fontSize: 20)),
                      ),
                    ),
                  ]),
                ),

          // Expanded(child: ListView.builder(),)
        ],
      ),
    );
  }
}
