// import 'dart:html';

import 'package:chat_waiting_trinity/pages/web/widgets/profile_avatar.dart';
import 'package:flutter/material.dart';

class Rooms extends StatelessWidget {
  // it should be ths list of waiting people and button click to full waiting list page
  final Widget waitingPeople;

  const Rooms({Key key, this.waitingPeople}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 40.0,
          width: double.infinity,
          color: Colors.white,
          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Text(
            'Current Waiting List',
            style: TextStyle(
                color: Colors.red[200],
                fontSize: 18.0,
                fontWeight: FontWeight.bold),
          ),
        ),
        // SizedBox(

        //   height: 20,
        // ),
        Container(
          height: 80.0,
          width: double.infinity,
          color: Colors.white,
          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: ListView.builder(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: OutlinedButton(
                      onPressed: () => print('join'),
                      style: OutlinedButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.teal[400],
                      ),
                      child: Text('+ Join')),
                );
              }
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ProfileAvatar(imageUrl: ''),
              );
            },
          ),
          // ],
          // ),
        ),
      ],
    );
  }
}

class _CreateRoomButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: () => print('join'),
        // child: Text('Woolha.com'),
        style: OutlinedButton.styleFrom(
          primary: Colors.white,
          backgroundColor: Colors.teal[400],
        ),
        // style: ButtonStyle(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),),
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        // color: Colors.white,
        // borderSide: BorderSide(width: 3.0, color: Colors.blueAccent),
        // textColor: Colors.blue,
        child:
            //  Row(
            //   children: [
            // ShaderMask(
            //     shaderCallback: (rect) => RadialGradient(
            //           center: Alignment.topLeft,
            //           radius: 1.0,
            //           colors: <Color>[Colors.yellow, Colors.deepOrange.shade900],
            //           tileMode: TileMode.mirror,
            //         ).createShader(rect),
            // child:
            // Icon(Icons.add, size: 45.0, color: Colors.blue),
            // const SizedBox(width: 4.0),
            Text('+ Join')
        //   ],
        // ),
        );
  }
}
