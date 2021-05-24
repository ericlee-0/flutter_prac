import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String name;
  // final bool isActive;

  const ProfileAvatar({
    Key key,
    @required this.name,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 30.0,
      backgroundColor: Colors.orange[200],
      child: Text(name.substring(0, 2)),
    );
  }
}
