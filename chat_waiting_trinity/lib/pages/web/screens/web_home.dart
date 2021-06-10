import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../widgets/widgets.dart';
import '../../../pages/chat/auth_page.dart';
import '../../../pages/waiting/waiting_time_page.dart';
import '../../../pages/waiting/add_reservation_page.dart';
import '../../../widgets/chat/chat_with_admin.dart';

class WebHome extends StatefulWidget {
  final Function toChatFn;
  final Function toReservationFn;
  final Function logInFn;
  final Function logOutFn;
  final String userName;

  const WebHome(
      {Key key,
      this.toChatFn,
      this.toReservationFn,
      this.logInFn,
      this.logOutFn,
      this.userName})
      : super(key: key);

  @override
  _WebHomeState createState() => _WebHomeState();
}

class _WebHomeState extends State<WebHome> {
  final TrackingScrollController _trackingScrollController =
      TrackingScrollController();

  bool chatOpen;
  bool reservationOpen;

  final List eventListItems = [
    {
      'type': 'E',
      'creator': 'Gyubee Dundas',
      'image': 'assets/images/event.jpeg',
      'detail':
          'this event is created by duddas haha so i have no idear other location and contents is not decided yet. we will figure it out sooner or later',
    }
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chatOpen = false;
    reservationOpen = false;
  }

  _openReservation() {
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(), // on tap -> unfocus,
      child: Scaffold(
        floatingActionButton: ElevatedButton.icon(
            onPressed: () {
              if (MediaQuery.of(context).size.width <= 900)
                widget.toChatFn();
              else
                setState(() {
                  chatOpen = !chatOpen;
                });
            },
            icon: Icon(Icons.chat_bubble_outline),
            label: chatOpen ? Text('Close chat') : Text('Open chat')),
        body: Responsive(
          mobile: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: _WebHomeMobile(
              scrollController: _trackingScrollController,
              eventListItems: eventListItems,
              reserveFn: widget.toReservationFn,
              logInFn: widget.logInFn,
              logOutFn: widget.logOutFn,
              userName: widget.userName,
            ),
          ),
          desktop: Stack(
            children: [
              _WebHomeDesktop(
                scrollController: _trackingScrollController,
                eventListItems: eventListItems,
                openReservationFn: _openReservation,
              ),
              Container(
                alignment: Alignment.center,
                child: AnimatedContainer(
                  width: reservationOpen ? 400.0 : 0.0,
                  height: reservationOpen ? 600.0 : 0.0,
                  color: reservationOpen ? Colors.blue[100] : Colors.white,
                  duration: Duration(seconds: 1),
                  curve: Curves.fastOutSlowIn,
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
                              closeReservationFn: _openReservation,
                              userId: FirebaseAuth.instance.currentUser.uid);
                        }
                        return AuthPage();
                      }),
                ),
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: chatOpen
                    ? Container(
                        // padding: EdgeInsets.fromLTRB(0, 0, 50, 50),
                        // alignment: Alignment.bottomRight,
                        // child: AnimatedContainer(
                        //   width: chatOpen ? 400.0 : 0.0,
                        //   height: chatOpen ? 600.0 : 0.0,
                        //   color: chatOpen ? Colors.grey[100] : Colors.white,
                        //   alignment: chatOpen
                        //       ? Alignment.bottomLeft
                        //       : AlignmentDirectional.topEnd,
                        //   duration: Duration(seconds: 1),
                        //   curve: Curves.fastOutSlowIn,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                        ),
                        width: 400,
                        height: 600,
                        child: Column(
                          children: [
                            Text('Chat Screen'),
                            StreamBuilder(
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
                                    return ChatWithAdmin(
                                      popToggleFn: widget.toChatFn,
                                      key:
                                          PageStorageKey('chatWithAdminscreen'),
                                    );
                                  }
                                  return AuthPage();
                                }),
                          ],
                        ),
                        // ChatNavicontroller(),
                        // ),
                      )
                    : SizedBox.shrink(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _WebHomeMobile extends StatelessWidget {
  final TrackingScrollController scrollController;
  final List<dynamic> eventListItems;
  final Function reserveFn;
  final Function logInFn;
  final Function logOutFn;
  final String userName;

  const _WebHomeMobile(
      {Key key,
      this.scrollController,
      this.eventListItems,
      this.reserveFn,
      this.logInFn,
      this.logOutFn,
      this.userName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(controller: scrollController, slivers: [
      SliverAppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.black,
        title: SizedBox(
          height: 80,
          width: 150,
          child: Image.asset(
            'assets/images/logo_150_113.png',
          ),
        ),
        centerTitle: false,
        floating: true,
        actions: [
          FirebaseAuth.instance.currentUser == null
              ? CircleButton(
                  onPressed: () {
                    //AuthPage
                    print('login page need to run');
                    logInFn(context);
                  },
                  icon: Icons.login,
                  iconSize: 30.0,
                )
              : UserCard(
                  userName: userName,
                  logOutFn: logOutFn,
                ),
        ],
      ),
      SliverToBoxAdapter(
        child: Image.asset(
          'assets/images/main_image_mobile.png',
          fit: BoxFit.fill,
        ),
      ),
      SliverToBoxAdapter(
        child: Container(
          padding: MediaQuery.of(context).size.width < 900
              ? EdgeInsets.fromLTRB(10, 15, 10, 15)
              : EdgeInsets.fromLTRB(150, 15, 150, 15),
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
            Rooms(
              waitingPeople: 'Current Waiting People',
              openJoinFn: reserveFn,
            ),
            OrderOnline(),
          ],
        )),
      ),
      SliverToBoxAdapter(
        child: Stories(item: Text('list of Menu items')),
      ),
      SliverPadding(
        padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
        sliver: SliverToBoxAdapter(
          child: Image.asset(
            'assets/images/store_location.png',
            fit: BoxFit.fill,
          ),
        ),
      ),
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
    ]);
  }
}

class _WebHomeDesktop extends StatelessWidget {
  final TrackingScrollController scrollController;
  final List<dynamic> eventListItems;
  final Function openReservationFn;

  const _WebHomeDesktop(
      {Key key,
      this.scrollController,
      this.eventListItems,
      this.openReservationFn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(controller: scrollController, slivers: [
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
                    Rooms(
                        waitingPeople: 'Current Waiting People',
                        openJoinFn: openReservationFn),
                    OrderOnline(),
                  ],
                ),
              )),
          const Spacer(),
        ],
      )),
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
    ]);
  }
}
