import 'package:chat_waiting_trinity/pages/waiting/stepper_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import './screens/screens.dart';
import './widgets/widgets.dart';

import 'package:flutter/material.dart';

import '../../pages/chat/auth_page.dart';

import '../chat/guest_chat_page.dart';
import '../../controllers/chatNaviController.dart';

class WebHomeNav extends StatefulWidget {
  @override
  _WebHomeNavState createState() => _WebHomeNavState();
}

class _WebHomeNavState extends State<WebHomeNav> {
  // List<Widget> _screens;
  // List<IconData> _icons;
  bool _isAdvisor = false;
  @override
  void initState() {
    super.initState();
  }

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

  void openConsole() {
    print('openconsole run..');
    print('_advisor?  $_isAdvisor');
    if (_isAdvisor)
      setState(() {
        _selectedIndex = 2;
      });
  }

  // Future showMyDialog(BuildContext context) {

  //   return showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return new AlertDialog(
  //           content: AuthPageWeb(),
  //           actions: <Widget>[
  //             FlatButton(
  //               child: const Text('Close'),
  //               onPressed: () {

  //                 Navigator.pop(context);
  //                 // Navigator.of(context).pop(true);
  //               },
  //             ),
  //           ],
  //         );
  //       });
  // }

  Future showLoginDialog(BuildContext context) {
    // print('provider auth? $auth');

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            content: StreamBuilder(
                // stream: Auth.instance.authState,
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (ctx, userSnapshot) {
                  if (userSnapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (userSnapshot.hasData) {
                    return Text(
                      'Success!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          backgroundColor: Colors.blueAccent,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    );
                  }
                  return AuthPage();
                }),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('Close'),
                onPressed: () {
                  if (FirebaseAuth.instance.currentUser != null)
                    setState(() {
                      if (FirebaseAuth.instance.currentUser.uid ==
                          'M0clGRrBRMQSfQykuyA72WwHLgG2') _isAdvisor = true;
                    });
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
    if (FirebaseAuth.instance.currentUser != null &&
        FirebaseAuth.instance.currentUser.uid ==
            'M0clGRrBRMQSfQykuyA72WwHLgG2') {
      setState(() {
        _isAdvisor = true;
      });
    } else {
      setState(() {
        _isAdvisor = false;
      });
    }
    return DefaultTabController(
      length: Responsive.isMobile(context) ? _iconsMobile.length : 3,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: !Responsive.isMobile(context)
            ? PreferredSize(
                //desktop, tablet mode
                child: CustomAppBar(
                  icons: [
                    Icons.home,
                    // Icons.contact_phone,
                    // Icons.location_on,
                    Icons.restaurant_menu,
                    _isAdvisor
                        ? Icons.control_camera_sharp
                        : Icons.add_business,
                  ],
                  selectedIndex: _selectedIndex,
                  onTap: (index) {
                    setState(() => _selectedIndex = index);
                  },
                  isAdvisor: _isAdvisor,
                  login: showLoginDialog,
                  openConsole: openConsole,
                ),
                preferredSize: Size(screenSize.width * 0.2, 100.0))
            : null,
        body: !Responsive.isMobile(context)
            ? IndexedStack(
                //desktop, tablet mode
                // sizing: StackFit.loose,
                index: _selectedIndex,
                children: [
                  WebHome(),
                  // WebContact(),
                  // WebLocation(),
                  WebMenu(),
                  _isAdvisor ? WebWaitingConsole() : WebBusiness(),
                ],
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
