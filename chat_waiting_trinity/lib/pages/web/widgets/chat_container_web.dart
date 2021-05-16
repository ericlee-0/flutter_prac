import 'package:flutter/material.dart';

class ChatContainerWeb extends StatefulWidget {
  final bool selected;

  const ChatContainerWeb({Key key, this.selected}) : super(key: key);

  @override
  _ChatContainerWebState createState() => _ChatContainerWebState();
}

class _ChatContainerWebState extends State<ChatContainerWeb> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedContainer(
        width: widget.selected ? 200.0 : 0.0,
        height: widget.selected ? 600.0 : 0.0,
        color: widget.selected ? Colors.grey : Colors.blue,
        alignment:
            widget.selected ? Alignment.center : AlignmentDirectional.topCenter,
        duration: Duration(seconds: 2),
        curve: Curves.fastOutSlowIn,
        child: FlutterLogo(size: 75),
      ),
    );
  }
}
