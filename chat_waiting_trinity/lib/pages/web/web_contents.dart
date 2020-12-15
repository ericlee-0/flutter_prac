import 'package:flutter/material.dart';

class WebContents extends StatelessWidget {
  final String page;
  WebContents(this.page);
 
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Text(page)],
    );
  }
}
