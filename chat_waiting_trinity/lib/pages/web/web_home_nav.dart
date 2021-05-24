import 'package:chat_waiting_trinity/pages/waiting/stepper_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import './screens/screens.dart';
import './widgets/widgets.dart';
import '../chat/auth_page_web.dart';
import 'package:flutter/material.dart';

import '../../pages/chat/auth_page.dart';
import '../waiting/join_waiting_page.dart';
import '../chat/guest_chat_page.dart';
import '../../controllers/chatNaviController.dart';

class WebHomeNav extends StatefulWidget {
  @override
  _WebHomeNavState createState() => _WebHomeNavState();
}

class _WebHomeNavState extends State<WebHomeNav> {
  final List<Widget> _screens = [
    WebHome(),
    WebContact(),
    WebLocation(),
    WebMenu(),
    WebBusiness(),
  ];
  // List<Widget> _screensMobile = [
  //   WebHome(),
  //   WebContact(),
  //   WebLocation(),
  //   WebMenu(),
  //   WebBusiness(),
  //   Scaffold(
  //       // body: Container(child: Text('button'),alignment: Alignment.center),
  //       ),
  // ];
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
    Icons.add,
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

  void moveToReservation() {
    setState(() {
      _selectedIndex = 2;
    });
  }

  void moveToChat() {
    setState(() {
      _selectedIndex = 5;
    });
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
            ? IndexedStack(
                // sizing: StackFit.loose,
                index: _selectedIndex,
                children: _screens,
              )
            //below part will be use it for chat container activemode
            // ? Row(
            //     children: [
            //       Container(
            //         width: screenSize.width * 0.65,
            //         child: IndexedStack(
            //           // sizing: StackFit.loose,
            //           index: _selectedIndex,
            //           children: _screens,
            //         ),
            //       ),
            //       SizedBox(width: screenSize.width * 0.05),
            //       Container(
            //         width: screenSize.width * 0.3,
            //         child: (user == null)
            //             ? ButtonGradiant(
            //                 title: 'chat with agent', onTap: showMyDialog)
            //             : GuestChatPage(),
            //         alignment: Alignment.center,
            //       )
            //     ],
            //   )
            : IndexedStack(
                index: _selectedIndex,
                // children: _screensMobile,
                children: [
                  WebHome(
                    toChatFn: moveToChat,
                    toReservationFn: moveToReservation,
                  ),
                  WebContact(),
                  Scaffold(
                    body: Container(
                      child: StreamBuilder(
                          stream:
                              //  Auth.instance.authState,
                              FirebaseAuth.instance.authStateChanges(),
                          builder: (ctx, userSnapshot) {
                            if (userSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (userSnapshot.hasData) {
                              // return JoinWaitingPage();
                              return StepperTest();
                            }
                            return AuthPage();
                          }),
                    ),
                  ),
                  WebMenu(),
                  WebBusiness(),
                  Scaffold(
                    body: Container(
                        child: StreamBuilder(
                            stream: FirebaseAuth.instance.authStateChanges(),
                            builder: (ctx, userSnapshot) {
                              if (userSnapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              if (userSnapshot.hasData) {
                                // print('id:${FirebaseAuth.instance.currentUser.uid}');
                                return FirebaseAuth.instance.currentUser.uid ==
                                        'twn4iAv7bmbYVvFUdQ9Ocyj25Vr1'
                                    ? GuestChatPage()
                                    : ChatNavicontroller();
                                // : ChatRoomListPage();
                                // return  kIsWeb ? GuestChatPage() : ChatRoomListPage();
                              }
                              return AuthPage();
                            })),
                  ),
                ],
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
