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
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: Column(children: [
        FittedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                  // decoration: BoxDecoration(color: Colors.blue[200]),
                  child: Text(
                'Current Wait Time :',
                style: TextStyle(
                    color: Colors.red[400],
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              )),
              const SizedBox(width: 5.0),
              Text('${waitTime.toString()} min..'),
              const SizedBox(width: 5.0),
              ElevatedButton.icon(
                  icon: Icon(
                    Icons.add,
                    size: 20,
                  ),
                  label: Text('join'),
                  onPressed: () => print('join witing'))
            ],
          ),
        ),
        const SizedBox(height: 10.0),

        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     FlatButton.icon(
        //         onPressed: () => print('join waiting'),
        //         color: Colors.red,
        //         icon: Icon(Icons.add),
        //         label: Text('Join'))
        //   ],
        // ),
        const Divider(height: 10.0, thickness: 0.5),
      ]),
    );
  }
}
