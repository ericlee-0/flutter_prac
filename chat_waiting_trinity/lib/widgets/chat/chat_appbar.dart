import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar;
  // final List<Widget> widgets;
  //https://stackoverflow.com/questions/53411890/how-can-i-have-my-appbar-in-a-separate-file-in-flutter-while-still-having-the-wi

  const ChatAppBar({Key key, this.appBar,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Chat'),
      actions: [
        DropdownButton(
            underline: Container(),
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: [
                      Icon(Icons.exit_to_app),
                      SizedBox(
                        width: 8,
                      ),
                      Text('Logout')
                    ],
                  ),
                ),
                value: 'logout',
              ),
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: [
                      Icon(Icons.edit),
                      SizedBox(
                        width: 8,
                      ),
                      Text('Edit Profile')
                    ],
                  ),
                ),
                value: 'edit',
              ),
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: [
                      Icon(Icons.exit_to_app),
                      SizedBox(
                        width: 8,
                      ),
                      Text('Test Page')
                    ],
                  ),
                ),
                value: 'test',
              ),
            ],
            onChanged: (itemIdentifier) {
              if (itemIdentifier == 'edit') {
                // Navigator.of(context)
                //     .pushNamed(UserProfileEditPage.routeName);
              } else if (itemIdentifier == 'logout') {
                FirebaseAuth.instance.signOut();
                // Navigator.of(context).pushNamed('/');
              } else if (itemIdentifier == 'test') {
                // print(getAuthState);
                // Navigator.of(context).pushNamed(UserProfileImagePicker.routeName);
              }
            })
      ],
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}
