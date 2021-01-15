import 'package:flutter/material.dart';

class ButtonGradiant extends StatelessWidget {
  final String title;

  final Function onTap;

  const ButtonGradiant({Key key, @required this.title, @required this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    // User user = Provider.of<User>(context);
    return RaisedButton(
      onPressed: () {onTap(context);},
      textColor: Colors.white,
      padding: const EdgeInsets.all(0.0),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              Color(0xFF0D47A1),
              Color(0xFF1976D2),
              Color(0xFF42A5F5),
            ],
          ),
        ),
        padding: const EdgeInsets.all(10.0),
        child: Text(
          title,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
