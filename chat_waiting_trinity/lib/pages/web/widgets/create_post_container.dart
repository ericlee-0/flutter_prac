import './circle_button.dart';
import 'package:flutter/material.dart';

class CreatePostContainer extends StatelessWidget {
  final int waitTime;

  CreatePostContainer({@required this.waitTime});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 100.0,

      // color: Colors.redAccent,
      padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 0),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
                decoration: BoxDecoration(color: Colors.red),
                child: Text(
                  'Current Wait Time :',
                  style: TextStyle(color: Colors.white),
                )),
            const SizedBox(width: 5.0),
            Text('${waitTime.toString()} min..'),
            const SizedBox(width: 5.0),
            CircleButton(
                icon: Icons.add,
                iconSize: 30.0,
                onPressed: () => print('join witing'))
          ],
        ),
        const SizedBox(height: 10.0),
        
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton.icon(
                onPressed: () => print('join waiting'),
                color: Colors.red,
                icon: Icon(Icons.add),
                label: Text('Join'))
          ],
        ),
        const Divider(height: 10.0, thickness: 0.5),
      ]),
    );
  }
}
