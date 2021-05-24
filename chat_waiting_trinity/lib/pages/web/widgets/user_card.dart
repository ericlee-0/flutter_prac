import 'package:flutter/material.dart';
import './profile_avatar.dart';

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
            'username',
            style: const TextStyle(fontSize: 16.0),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
