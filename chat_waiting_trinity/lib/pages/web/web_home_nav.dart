import 'package:chat_waiting_trinity/pages/chat/guest_chat_page.dart';
import 'package:chat_waiting_trinity/pages/web/widgets/button_gradiant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import './screens/screens.dart';
import './widgets/widgets.dart';
import '../chat/auth_page_web.dart';
import 'package:flutter/material.dart';

class WebHomeNav extends StatefulWidget {
  @override
  _WebHomeNavState createState() => _WebHomeNavState();
}

class _WebHomeNavState extends State<WebHomeNav> {
  final List<Widget> _screens = [
    WebHome(),
    Scaffold(),
    Scaffold(),
    Scaffold(),
    Scaffold(),
  ];
  List<Widget> _screensMobile = [
    WebHome(),
    Scaffold(),
    Scaffold(),
    Scaffold(),
    Scaffold(),
    Scaffold(
        // body: Container(child: Text('button'),alignment: Alignment.center),
        ),
  ];
  final List<IconData> _icons = const [
    Icons.home,
    Icons.contact_phone,
    Icons.location_on,
    Icons.restaurant_menu,
    Icons.add_business,
  ];
  final List<IconData> _iconsMobile = const [
    Icons.home,
    Icons.contact_phone,
    Icons.location_on,
    Icons.restaurant_menu,
    Icons.add_business,
    Icons.chat
  ];
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _screensMobile =
  }

  Future showMyDialog(BuildContext context) {
    // print('provider auth? $auth');

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            content: AuthPageWeb(),
            actions: <Widget>[
              FlatButton(
                child: const Text('Close'),
                onPressed: () {
                  Navigator.pop(context);
                  // Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    User user = Provider.of<User>(context);
    print('provider $user');
    print('height: ${screenSize.height}');
    // StreamBuilder builder = StreamBuilder(
    //     stream: FirebaseAuth.instance.authStateChanges(),
    //     builder: (context, snapshot) {
    //       if (snapshot.connectionState == ConnectionState.waiting) {
    //         return Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       }
    //       if (snapshot.hasData) {
    //         if (_isPopupOpen) {
    //           _isPopupOpen = false;
    //           Navigator.pop(context);
    //         }
    //         _isAuth = true;
    //         return SizedBox.shrink();
    //         // ('webchatcontainer');
    //       }
    //       return ButtonGradiant(title: 'chat with agent',onTap: showMyDialog);
    //     });
    return DefaultTabController(
      length:
          Responsive.isMobile(context) ? _iconsMobile.length : _icons.length,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: !Responsive.isMobile(context)
            ? PreferredSize(
                child: CustomAppBar(
                    icons: _icons,
                    selectedIndex: _selectedIndex,
                    onTap: (index) {
                      setState(() => _selectedIndex = index);
                    }),
                preferredSize: Size(screenSize.width * 0.5, 100.0))
            : null,
        body: !Responsive.isMobile(context)
            ? Row(
                children: [
                  Container(
                    width: screenSize.width * 0.65,
                    child: IndexedStack(
                      // sizing: StackFit.loose,
                      index: _selectedIndex,
                      children: _screens,
                    ),
                  ),
                  SizedBox(width: screenSize.width * 0.05),
                  Container(
                    width: screenSize.width * 0.3,
                    child: (user == null)
                        ? ButtonGradiant(
                            title: 'chat with agent', onTap: showMyDialog)
                        : GuestChatPage(),
                    alignment: Alignment.center,
                  )
                ],
              )
            : IndexedStack(
                index: _selectedIndex,
                children: _screensMobile,
              ),
        endDrawer: WebChatDrawer(),
        bottomNavigationBar: Responsive.isMobile(context)
            ? Container(
                padding: const EdgeInsets.only(bottom: 12.0),
                color: Colors.white,
                child: CustomTabBar(
                  icons: _iconsMobile,
                  selectedIndex: _selectedIndex,
                  onTap: (index) => setState(
                    () => _selectedIndex = index,
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
