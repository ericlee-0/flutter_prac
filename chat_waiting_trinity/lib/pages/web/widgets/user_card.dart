import 'package:flutter/material.dart';
import './profile_avatar.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserCard extends StatelessWidget {
  final String userName;
  final Function logOutFn;

  const UserCard({Key key, this.userName, this.logOutFn}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Row(
        children: [
          // ProfileAvatar(name: 'null'),
          const SizedBox(width: 6.0),
          Text(
            userName,
            style: const TextStyle(
              fontSize: 16.0,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          ElevatedButton.icon(
              onPressed: () {
                //AuthPage
                // print('logout need to run');
                // FirebaseAuth.instance.signOut();
                // login();
                logOutFn();
              },
              icon: Icon(Icons.logout),
              label: Text('Logout')),
        ],
      ),
    );
  }
}
