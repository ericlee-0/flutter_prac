import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../widgets/widgets.dart';
import '../../../pages/chat/auth_page.dart';
import '../../../pages/waiting/waiting_time_page.dart';
import '../../../pages/waiting/add_reservation_page.dart';
import '../../../widgets/chat/chat_with_admin.dart';

class WebAddReserve extends StatefulWidget {
  final Function logInFn;
  final String userName;
  final bool isLogin;
  final Function logOutFn;

  const WebAddReserve(
      {Key key, this.logInFn, this.userName, this.isLogin, this.logOutFn})
      : super(key: key);

  @override
  _WebAddReserveState createState() => _WebAddReserveState();
}

class _WebAddReserveState extends State<WebAddReserve> {
  final TrackingScrollController _trackingScrollController =
      TrackingScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
        body: Container(
          // width: MediaQuery.of(context).size.width,
          // height: MediaQuery.of(context).size.height,
          child: _WebAddReserveMobile(
            scrollController: _trackingScrollController,
            logInFn: widget.logInFn,
            userName: widget.userName,
            isLogin: widget.isLogin,
          ),
        ),
      ),
    );
  }
}

class _WebAddReserveMobile extends StatelessWidget {
  final TrackingScrollController scrollController;
  final Function logInFn;
  final String userName;
  final bool isLogin;
  final Function logOutFn;

  const _WebAddReserveMobile(
      {Key key,
      this.scrollController,
      this.logInFn,
      this.userName,
      this.isLogin,
      this.logOutFn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(controller: scrollController, slivers: [
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
      SliverPadding(
        padding: EdgeInsets.fromLTRB(0, 10.0, 0, 5.0),
        sliver: SliverToBoxAdapter(
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Colors.yellowAccent[100],
              ),
              child: isLogin
                  ? AddReservationPage(
                      userId: FirebaseAuth.instance.currentUser.uid,
                    )
                  : Center(
                      child: ElevatedButton(
                          onPressed: () => logInFn(context),
                          child: Text('Login')),
                    )),
        ),
      ),
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
