import 'package:flutter/material.dart';
// import './web_nav_bar.dart';
import './web_contents.dart';

class WebHome extends StatefulWidget {
  @override
  _WebHomeState createState() => _WebHomeState();
}

class _WebHomeState extends State<WebHome> {
  String _page;
  // Function _changePage;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _page = 'Home';
  }

  void _changePage(String page) {
    setState(() {
      _page = page;
    });
  }
  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    // print('width: $width');
    // String page = 'Home';
    print('current page: $_page');
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color.fromRGBO(89, 185, 212, 1.0),
              Color.fromRGBO(41, 94, 163, 1.0)
            ],
          ),
        ),
        child: Column(children: [
          // WebNavBar(_page, _changePage),
          WebContents(_page),
          // Text('where is drawer')
        ]),
      ),
     
      
    );
  }
}
