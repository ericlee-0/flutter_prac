import 'package:flutter/material.dart';

class WaitingListDrawer extends StatelessWidget {
  final Function selectList;
  WaitingListDrawer(this.selectList);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Select list option'),
            // automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Pending list'),
            onTap: () {
             selectList('pending');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Done list'),
            onTap: () {
            selectList('done');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Active list'),
            onTap: () {
             selectList('active');
            },
          ),
         
          
        ],
      ),
    );
  }
}