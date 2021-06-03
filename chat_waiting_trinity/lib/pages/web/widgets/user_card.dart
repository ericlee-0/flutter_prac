import 'package:flutter/material.dart';
import './profile_avatar.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Row(
        children: [
          ProfileAvatar(name: 'null'),
          const SizedBox(width: 6.0),
          Text(
            'user',
            style: const TextStyle(fontSize: 16.0),
            overflow: TextOverflow.ellipsis,
          ),
          ElevatedButton.icon(
              onPressed: () {
                //AuthPage
                // print('logout need to run');
                FirebaseAuth.instance.signOut();
                // login();
              },
              icon: Icon(Icons.logout),
              label: Text('Logout')),
        ],
      ),
    );
  }
}
