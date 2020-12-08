import 'package:flutter/material.dart';

class ChatBadge extends StatelessWidget {
  final int value;
  ChatBadge(this.value);
  @override
  Widget build(BuildContext context) {
    return (value == 0)
        ? SizedBox.shrink()
        : Container(
            padding: EdgeInsets.all(2.0),
            // color: Theme.of(context).accentColor,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.red,
            ),
            constraints: BoxConstraints(
              minWidth: 16,
              minHeight: 16,
            ),
            child: Text(
              value.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
              ),
            ),
          );
  }
}