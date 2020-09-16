import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  final String questionText;

  Question(
      this.questionText); //position argument if use {} then named arguments

  @override
  Widget build(BuildContext context) {
    // return Container(

    // );

    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      child: Text(
        questionText,
        style: TextStyle(fontSize: 28),
        textAlign: TextAlign.center,
      ),
    );
  }
}
