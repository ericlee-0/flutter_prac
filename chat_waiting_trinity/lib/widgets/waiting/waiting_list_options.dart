import 'package:flutter/material.dart';

class WaitingListOption extends StatelessWidget {
  final Function selectList;
  final Function reserveFn;

  const WaitingListOption({
    Key key,
    this.selectList,
    this.reserveFn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      child: Column(
        children: [
          Text('Select list option'),
          // automaticallyImplyLeading: false,

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
          Divider(),
          Spacer(),
          OutlinedButton(
            child: Text(
              'Reservation',
              style: TextStyle(
                  // color: Colors.red[400],
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
            style: OutlinedButton.styleFrom(
              primary: Colors.white,
              backgroundColor: Colors.blue[600],
              shadowColor: Colors.red,
              elevation: 10,
            ),
            onPressed: () {
              reserveFn();
            },
          ),
        ],
      ),
    );
  }
}
