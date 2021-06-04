import '../widgets/widgets.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../../../pages/chat/auth_page.dart';
// import '../../waiting/join_waiting_page.dart';
// import '../../chat/guest_chat_page.dart';
// import '../../../controllers/chatNaviController.dart';
import '../../waiting/waiting_time_page.dart';
// import './../../waiting/add_reservation_page.dart';
import '../../waiting/add_reservation_page.dart';
import '../../../widgets/chat/chat_with_admin.dart';

class WebHome extends StatefulWidget {
  final Function toChatFn;
  final Function toReservationFn;
  final Function loginFn;

  const WebHome({Key key, this.toChatFn, this.toReservationFn, this.loginFn})
      : super(key: key);

  @override
  _WebHomeState createState() => _WebHomeState();
}

class _WebHomeState extends State<WebHome> {
  final TrackingScrollController _trackingScrollController =
      TrackingScrollController();

  // var scrollInt;
  bool chatOpen = false;
  bool reservationOpen = false;
  @override
  void initState() {
    super.initState();

    // _trackingScrollController.addListener(changeSelector);
    // chatOpen = false;
    // reservationOpen = false;
    // setState(() {
    //   scrollInt = 0;
    // });
  }

  // changeSelector() {
  //   var scrollValue = _trackingScrollController.offset.round();
  //   var scrollIntValue = 0;

  //   if (scrollIntValue < 8) scrollIntValue = (scrollValue / 30).floor();
  //   if (scrollIntValue < 8)
  //     setState(() {
  //       scrollInt = scrollIntValue;
  //     });
  // }

  openReservation() {
    print('reservation clicked');
    setState(() {
      reservationOpen = !reservationOpen;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _trackingScrollController.dispose();
    super.dispose();
  }

  List eventListItems = [
    {
      'type': 'E',
      'creator': 'Gyubee Dundas',
      'image': 'assets/images/event.jpeg',
      'detail':
          'this event is created by duddas haha so i have no idear other location and contents is not decided yet. we will figure it out sooner or later',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(), // on tap -> unfocus
      child: Scaffold(
        floatingActionButton: ElevatedButton.icon(
            onPressed: () {
              if (MediaQuery.of(context).size.width <= 800)
                widget.toChatFn();
              else
                setState(() {
                  chatOpen = !chatOpen;
                });
            },
            icon: Icon(Icons.chat_bubble_outline),
            label: chatOpen ? Text('Close chat') : Text('Open chat')),
        body: Responsive(
          mobile: _HomeMobile(
            scrollController: _trackingScrollController,
            eventListItems: eventListItems,
            reserveFn: widget.toReservationFn,
            loginFn: widget.loginFn,
          ),
          desktop: Stack(
            clipBehavior: Clip.hardEdge,
            children: [
              _HomeDesktop(
                scrollController: _trackingScrollController,
                eventListItems: eventListItems,
                openReservationFn: openReservation,
              ),
              // Container(
              //   alignment: Alignment.center,
              //   child: AnimatedContainer(
              //       width: reservationOpen ? 400.0 : 0.0,
              //       height: reservationOpen ? 600.0 : 0.0,
              //       color: reservationOpen ? Colors.blue[100] : Colors.white,
              //       // alignment: reservationOpen
              //       //     ? Alignment.bottomRight
              //       //     : AlignmentDirectional.topEnd,
              //       duration: Duration(seconds: 1),
              //       curve: Curves.fastOutSlowIn,
              //       child: reservationOpen
              //           ? StreamBuilder(
              //               stream:
              //                   //  Auth.instance.authState,
              //                   FirebaseAuth.instance.authStateChanges(),
              //               builder: (ctx, userSnapshot) {
              //                 if (userSnapshot.connectionState ==
              //                     ConnectionState.waiting) {
              //                   return Center(
              //                     child: CircularProgressIndicator(),
              //                   );
              //                 }
              //                 if (userSnapshot.hasData) {
              //                   // return JoinWaitingPage();
              //                   // return AddReservationPage();
              //                   return AddReservationPage(
              //                       closeReservationFn: openReservation,
              //                       userId:
              //                           FirebaseAuth.instance.currentUser.uid);
              //                 }
              //                 return AuthPage();
              //               })
              //           : SizedBox.shrink()),
              // ),
              reservationOpen
                  ? Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 580,
                        width: 380,
                        // color: Colors.amberAccent[50],
                        decoration:
                            BoxDecoration(color: Colors.amberAccent[50]),
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
                                // return AddReservationPage();
                                return AddReservationPage(
                                    closeReservationFn: openReservation,
                                    userId:
                                        FirebaseAuth.instance.currentUser.uid);
                              }
                              return AuthPage();
                            }),
                      ),
                    )
                  : SizedBox.shrink(),
              // Container(
              //   padding: EdgeInsets.fromLTRB(0, 0, 50, 50),
              //   alignment: Alignment.bottomRight,
              //   child: AnimatedContainer(
              //       width: chatOpen ? 400.0 : 0.0,
              //       height: chatOpen ? 600.0 : 0.0,
              //       color: chatOpen ? Colors.grey[100] : Colors.white,
              //       alignment: chatOpen
              //           ? Alignment.bottomRight
              //           : AlignmentDirectional.topEnd,
              //       duration: Duration(seconds: 1),
              //       curve: Curves.fastOutSlowIn,
              //       child: chatOpen
              //           ? StreamBuilder(
              //               stream: FirebaseAuth.instance.authStateChanges(),
              //               builder: (ctx, userSnapshot) {
              //                 if (userSnapshot.connectionState ==
              //                     ConnectionState.waiting) {
              //                   return Center(
              //                     child: CircularProgressIndicator(),
              //                   );
              //                 }
              //                 if (userSnapshot.hasData) {
              //                   // print('id:${FirebaseAuth.instance.currentUser.uid}');
              //                   return ChatWithAdmin(
              //                     popToggleFn: widget.toChatFn,
              //                     key: PageStorageKey('chatWithAdminscreen'),
              //                   );
              //                   // : ChatRoomListPage();
              //                   // return  kIsWeb ? GuestChatPage() : ChatRoomListPage();
              //                 }
              //                 return AuthPage();
              //               })
              //           : SizedBox.shrink()),
              // )
              chatOpen
                  ? Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                          height: 580,
                          width: 380,
                          decoration:
                              BoxDecoration(color: Colors.amberAccent[50]),
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
                                  return ChatWithAdmin(
                                    popToggleFn: widget.toChatFn,
                                    key: PageStorageKey('chatWithAdminscreen'),
                                  );
                                  // : ChatRoomListPage();
                                  // return  kIsWeb ? GuestChatPage() : ChatRoomListPage();
                                }
                                return AuthPage();
                              })),
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeMobile extends StatelessWidget {
  final TrackingScrollController scrollController;
  final List<dynamic> eventListItems;

  final Function reserveFn;
  final Function loginFn;

  const _HomeMobile(
      {Key key,
      this.scrollController,
      this.eventListItems,
      this.reserveFn,
      this.loginFn})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverAppBar(
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          title: SizedBox(
            height: 80,
            width: 150,
            child: Image.asset(
              'assets/images/logo_150_113.png',
            ),
          ),
          //  Text(
          //   'chat_wait',
          //   style: const TextStyle(
          //       color: Colors.blue,
          //       fontSize: 28.0,
          //       fontWeight: FontWeight.bold),
          // ),
          centerTitle: false,
          floating: true,
          actions: [
            CircleButton(
                icon: Icons.home,
                iconSize: 30.0,
                onPressed: () => print('Home')),
            CircleButton(
                icon: Icons.message_rounded,
                iconSize: 30.0,
                onPressed: () => print('message')),
            CircleButton(
                icon: Icons.timelapse,
                iconSize: 30.0,
                onPressed: () => print('waiting')),
            FirebaseAuth.instance.currentUser == null
                ? ElevatedButton.icon(
                    onPressed: () {
                      //AuthPage
                      print('login page need to run');
                      loginFn(context);
                    },
                    icon: Icon(Icons.login),
                    label: Text('Login'))
                : UserCard(),
          ],
        ),
        SliverToBoxAdapter(
          child: Image.asset(
            'assets/images/main_image.png',
            fit: BoxFit.fill,
          ),
        ),
        // MainTitle(
        //   scrollInt: scrollInt,
        // ),
        SliverToBoxAdapter(
          child: Container(
            padding: EdgeInsets.fromLTRB(50, 15, 50, 15),
            child: OutlinedButton(
              child: Text(
                'Reservation',
                style: TextStyle(
                    // color: Colors.red[400],
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold),
              ),
              style: OutlinedButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.blue[600],
                shadowColor: Colors.red,
                elevation: 10,
              ),
              onPressed: () {
                reserveFn();
              },
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.fromLTRB(0, 10.0, 0, 5.0),
          sliver: SliverToBoxAdapter(
              child: Column(
            children: [
              // CreatePostContainer(waitTime: 10),
              WaitingTimePage(),
              Rooms(waitingPeople: Text('list of waiting people')),
              OrderOnline(),
            ],
          )),
        ),
        SliverToBoxAdapter(
          child: Stories(item: Text('list of Menu items')),
        ),
        SliverToBoxAdapter(
          child: Image.asset(
            'assets/images/store_location.png',
            fit: BoxFit.fill,
          ),
        ),
        // SliverPadding(
        //   padding: EdgeInsets.fromLTRB(0, 10.0, 0, 5.0),
        //   sliver: SliverToBoxAdapter(
        //     child: EventList(item: eventListItems),
        //   ),
        // ),
        SliverList(
            delegate: SliverChildBuilderDelegate(
          (context, index) {
            //here will be event container. using as listview
            //final Post post = posts[index];
            return PostContainer(item: eventListItems[index]);
          },
          childCount: eventListItems.length,
        )),
        SliverToBoxAdapter(
          child: Container(
            height: 50,
            color: Colors.grey[350],
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(0, 20.0, 0, 0),
            child: Text(
              'Copyright © 2021 Trinity Inc. All rights reserved.  Privacy Policy Terms of Use | Sales and Refunds | Site Map ',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}

class _HomeDesktop extends StatelessWidget {
  final TrackingScrollController scrollController;
  final List<dynamic> eventListItems;

  final Function openReservationFn;

  const _HomeDesktop(
      {Key key,
      this.scrollController,
      this.eventListItems,
      this.openReservationFn})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: CustomScrollView(
      controller: scrollController,
      slivers: [
        // MainTitle(
        //   scrollInt: scrollInt,
        // ),
        SliverToBoxAdapter(
          child: Image.asset(
            'assets/images/main_image.png',
            fit: BoxFit.fill,
          ),
        ),
        SliverToBoxAdapter(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(),
            Flexible(
              flex: 9,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/store_location.png',
                      fit: BoxFit.fill,
                    ),
                    Stories(item: Text('list of Menu items')),
                    EventList(item: eventListItems)
                  ],
                ),
              ),
            ),
            // const Spacer(),
            Flexible(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                        child: OutlinedButton(
                          child: Text(
                            'Reservation',
                            style: TextStyle(
                                // color: Colors.red[400],
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold),
                          ),
                          style: OutlinedButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: Colors.blue[600],
                            shadowColor: Colors.red,
                            elevation: 10,
                          ),
                          onPressed: () {
                            print('reservationFn run..');
                            openReservationFn();
                          },
                        ),
                      ),
                      // CreatePostContainer(waitTime: 10),
                      WaitingTimePage(),
                      Rooms(waitingPeople: Text('list of waiting people')),
                      OrderOnline(),
                    ],
                  ),
                )),
            const Spacer(),
          ],
        )),
        // SliverList(
        //     delegate: SliverChildBuilderDelegate(
        //   (context, index) {
        //     //here will be event container. using as listview
        //     //final Post post = posts[index];
        //     return PostContainer();
        //   },
        //   childCount: 2,
        // )),
        SliverToBoxAdapter(
          child: Container(
            height: 100,
            color: Colors.grey[350],
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(0, 20.0, 0, 0),
            child: Text(
              'Copyright © 2021 Trinity Inc. All rights reserved.  Privacy Policy Terms of Use | Sales and Refunds | Site Map ',
              textAlign: TextAlign.center,
            ),
          ),
        ),
        // SliverToBoxAdapter(
        //   child: CreatePostContainer(waitTime: 10),
        // ),
        // SliverPadding(
        //   padding: EdgeInsets.fromLTRB(0, 10.0, 0, 5.0),
        //   sliver: SliverToBoxAdapter(
        //     child: Rooms(waitingPeople: Text('list of waiting people')),
        //   ),
        // ),
      ],
    ));
  }
}
