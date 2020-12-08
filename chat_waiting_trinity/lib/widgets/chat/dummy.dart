import 'package:flutter/material.dart';

class Dummy extends StatefulWidget {
  final userId;
  final title;
  Dummy({this.userId,this.title,Key key}): super(key:key);
  
  @override
  _DummyState createState() => _DummyState();
}

class _DummyState extends State<Dummy> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Dummy with ${widget.userId} on title:${widget.title}'),
      
    );
  }
}