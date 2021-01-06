import 'package:flutter/material.dart';
import './chat_drawer_header.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../chat/auth_page.dart';
import '../../chat/guest_chat_page.dart';

class ChatDrawer extends StatefulWidget {

  @override
  _ChatDrawerState createState() => _ChatDrawerState();
}

class _ChatDrawerState extends State<ChatDrawer> {
  bool login = false;

  void _isLogin(){
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
        // showAlertDialog(context);
        // print('User is currently signed out!');
        // isLogin = false;
        setState(() {
        login = false;  
        });
        
      } else {
       
        // print('User is signed in!');
        // isLogin = true;
        setState(() {
        login = true;  
        });
        
      }
    });
    
  }

  @override
  Widget build(BuildContext context) {
    _isLogin();
    return Container(
      width: 400,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(color:Colors.blue, blurRadius: 16)
      ]),
      child: SingleChildScrollView(
              child: Column(
            children: [
              ChatDrawerHeader(),
              // DrawerItem('Waiting', Icons.list_alt, WaitingRoute),
              // DrawerItem('Chat', Icons.chat, ChatRoute),
              // DrawerItem('About', Icons.help, AboutRoute)
              (login)? Text('logged'): AuthPage(),
            ]
          ),
      ),
     
    );
  }
}