import 'package:chat_waiting_trinity/pages/waiting/add_reservation_page.dart';
import 'package:chat_waiting_trinity/pages/web/screens/web_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import './screens/screens.dart';
import './widgets/widgets.dart';

import 'package:flutter/material.dart';

import '../../pages/chat/auth_page.dart';
import '../../widgets/chat/chat_badge.dart';

import '../chat/guest_chat_page.dart';
// import '../../controllers/chatNaviController.dart';
import '../../widgets/chat/chat_with_guest_list.dart';
import '../../widgets/chat/chat_with_admin.dart';
import 'package:intl/intl.dart';

class WebHomeNav extends StatefulWidget {
  @override
  _WebHomeNavState createState() => _WebHomeNavState();
}

class _WebHomeNavState extends State<WebHomeNav> with TickerProviderStateMixin {
  // List<Widget> _screens;
  // List<IconData> _icons;
  bool _isAdvisor = false;
  TabController _topTabController;
  TabController _bottomTabController;
  int _selectedIndex = 0;
  int _unFinishedGuestChatNumber = 0;
  @override
  void initState() {
    super.initState();
    firebaseOnMessage();
    _topTabController = TabController(length: 3, vsync: this);
    _bottomTabController = TabController(length: 5, vsync: this);
  }

  void onFirebaseoOpendedApp() {
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print('onMessageOpenedApp occured. Message is: ');
      print(event.notification.title);
    });
  }

  void firebaseOnMessage() {
    FirebaseMessaging.onMessage.listen((message) {
      if (message != null) {
        final title = message.notification.title;
        final body = message.notification.body;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Title: $title, Body: $body')),
        );
        // showDialog(
        //     context: context,
        //     builder: (context) {
        //       return SimpleDialog(
        //         contentPadding: EdgeInsets.all(18),
        //         children: [
        //           Text('Title: $title'),
        //           Text('Body: $body'),
        //         ],
        //       );
        //     });
      }
    });
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
    Icons.add,
    Icons.restaurant_menu,
    Icons.contact_phone,
    Icons.chat
  ];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void moveToReservation() {
    _bottomTabController.animateTo(_selectedIndex = 1);
    setState(() {
      _selectedIndex = 1;
    });
  }

  void moveToChat() {
    _bottomTabController.animateTo(_selectedIndex = 4);
    setState(() {
      _selectedIndex = 4;
    });
  }

  void openConsole() {
    print('openconsole run..');
    print('_advisor?  $_isAdvisor');
    if (MediaQuery.of(context).size.width < 800) {
      //mobile
      if (_isAdvisor)
        setState(() {
          _selectedIndex = 3;
        });
      _bottomTabController.animateTo(_selectedIndex = 3);
    } else {
      //desktop tablet
      if (_isAdvisor)
        setState(() {
          _selectedIndex = 2;
        });
      _topTabController.animateTo(_selectedIndex = 2);
    }
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
                  return Scaffold(
                      body: Container(width: 400, child: AuthPage()));
                }),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('Close'),
                onPressed: () {
                  if (FirebaseAuth.instance.currentUser != null &&
                      FirebaseAuth.instance.currentUser.uid ==
                          'M0clGRrBRMQSfQykuyA72WwHLgG2') {
                    setState(() {
                      _isAdvisor = true;
                    });
                  }

                  Navigator.pop(context);
                  // Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        });
  }

// final Stream<QuerySnapshot> _getGuestChatCountStream = FirebaseFirestore.instance
//         .collection('users')
//         .doc('M0clGRrBRMQSfQykuyA72WwHLgG2')
//         .collection(docId)
//         .snapshots();

  Stream<QuerySnapshot> _getUnfinishedGuestChatCountStream() {
    final now = DateTime.now();
    final docId = DateFormat('yyyy/MM/dd').format(now);
    // int counter = 0;
    print('guestchatcountFn run..');

    return FirebaseFirestore.instance
        .collection('users')
        .doc('M0clGRrBRMQSfQykuyA72WwHLgG2')
        .collection(docId)
        .snapshots();
    //   .then((event) {
    // event.docs.forEach((element) {
    //   // print('${element['unRead']}');
    //   if (element['chatFinished'] == false) counter++;
    // });
    // print('chat? $counter');
    //   setState(() {
    //     _unFinishedGuestChatNumber = counter;
    //   });
    // });
  }

  @override
  void dispose() {
    _topTabController.dispose();
    _bottomTabController.dispose();
    super.dispose();
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
      // _getUnfinishedGuestChatCount();
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
                  controller: _topTabController,
                  icons: [
                    Icons.home,
                    // Icons.contact_phone,
                    // Icons.location_on,
                    Icons.restaurant_menu,
                    _isAdvisor
                        ? Icons.control_camera_sharp
                        : Icons.contact_phone
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
                  WebHome(
                    toChatFn: moveToChat,
                    toReservationFn: moveToReservation,
                    loginFn: showLoginDialog,
                  ),
                  // WebContact(),
                  // WebLocation(),
                  WebMenu(),
                  _isAdvisor ? WebWaitingConsole() : WebContact(),
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
                    loginFn: showLoginDialog,
                  ),
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
                              return AddReservationPage();
                            }
                            return AuthPage();
                          }),
                    ),
                  ),
                  WebMenu(),
                  _isAdvisor
                      ? WebWaitingConsole(
                          toReserveFn: moveToReservation,
                          toChatFn: moveToChat,
                        )
                      : WebContact(),
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
                                        'M0clGRrBRMQSfQykuyA72WwHLgG2'
                                    ? ChatWithGuestList(
                                        advisorId: FirebaseAuth
                                            .instance.currentUser.uid,
                                        key: PageStorageKey('GuestChatList'),
                                      )
                                    : ChatWithAdmin(
                                        key: PageStorageKey('ChatWithAdmin'));
                                // : ChatNavicontroller();
                                // : ChatRoomListPage();
                                // return  kIsWeb ? GuestChatPage() : ChatRoomListPage();
                              }
                              return AuthPage();
                            })),
                  ),
                ],
              ),
        // endDrawer: WebChatDrawer(),
        bottomNavigationBar: Responsive.isMobile(context)
            ? Container(
                padding: const EdgeInsets.only(bottom: 12.0),
                color: Colors.white,
                child: CustomTabBar(
                  controller: _bottomTabController,
                  icons: [
                    Icons.home,
                    Icons.add,
                    Icons.restaurant_menu,
                    _isAdvisor
                        ? Icons.control_camera_sharp
                        : Icons.contact_phone,
                    Icons.chat
                  ],
                  selectedIndex: _selectedIndex,
                  onTap: (index) => setState(
                    () => _selectedIndex = index,
                  ),
                  unreadChatNum: _isAdvisor
                      ? StreamBuilder(
                          stream: _getUnfinishedGuestChatCountStream(),
                          builder: (context, snapshot) {
                            Widget count;
                            int c = 0;
                            if (snapshot.hasError) {
                              count = ChatBadge(0);
                            } else {
                              switch (snapshot.connectionState) {
                                case ConnectionState.none:
                                  count = ChatBadge(0);
                                  break;
                                case ConnectionState.waiting:
                                  count = ChatBadge(0);
                                  break;
                                case ConnectionState.active:
                                  snapshot.data.docs.forEach((element) {
                                    //   // print('${element['unRead']}');
                                    if (element['chatFinished'] == false) c++;
                                  });
                                  count = ChatBadge(c);
                                  c = 0;

                                  break;
                                case ConnectionState.done:
                                  count = ChatBadge(0);
                                  break;
                              }
                            }

                            return count;
                          })
                      // ? ChatBadge(_unFinishedGuestChatNumber)
                      : ChatBadge(0),
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
