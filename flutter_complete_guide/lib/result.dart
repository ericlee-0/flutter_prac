import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int resultScore;
  final Function resetHandler;

  Result(this.resultScore, this.resetHandler);

  String get resultPhrase {
    String resultText;
    if (resultScore <= 10) {
      resultText = 'You are awesome!';
    } else if (resultScore <= 16) {
      resultText = 'Pretty likeable!';
    } else if (resultScore <= 22) {
      resultText = 'You are something!';
    } else {
      resultText = 'You are amazing!';
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            resultPhrase,
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          FlatButton(
            onPressed: resetHandler,
            child: Text('Restart Quiz!'),
            textColor: Colors.green,
          )
        ],
      ),
    );
  }
}
