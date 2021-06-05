// import 'package:chat_waiting_trinity/controllers/join_form_controller.dart';
import 'package:chat_waiting_trinity/controllers/join_waiting_controller.dart';
import 'package:chat_waiting_trinity/widgets/waiting/waiting_list_options.dart';

import 'package:firebase_auth/firebase_auth.dart';
import '../../../pages/waiting/waiting_console_page.dart';
import '../../../pages/web/widgets/widgets.dart';
import 'package:flutter/material.dart';
import '../../waiting/waiting_time_page.dart';
import '../../../widgets/waiting/waiting_list_messages.dart';
// import '../../../controllers/chatNaviController.dart';
import '../../waiting/add_reservation_page.dart';
import '../../../widgets/chat/chat_with_guest_list.dart';
import 'package:intl/intl.dart';

class WebWaitingConsole extends StatefulWidget {
  final Function toReserveFn;
  final Function toChatFn;

  const WebWaitingConsole({Key key, this.toReserveFn, this.toChatFn})
      : super(key: key);
  @override
  _WebWaitingConsoleState createState() => _WebWaitingConsoleState();
}

class _WebWaitingConsoleState extends State<WebWaitingConsole> {
  final TrackingScrollController _trackingScrollController =
      TrackingScrollController();
  String _selectList = 'active';
  // List<dynamic> _messageList = [];
  Map<String, dynamic> _messageInfo;
  bool chatOpen = false;
  bool reservationOpen = false;
  // final now = DateTime.now();
  bool _rightDrawerOpen = false;
  bool _leftDrawerOpen = false;

  String _selectedDate = DateFormat('yyyy/MM/dd').format(DateTime.now());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // _selectedDate = DateFormat('yyyy/MM/dd').format(now);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _trackingScrollController.dispose();
    super.dispose();
  }

  void _selectListOption(String selected) {
    setState(() {
      _selectList = selected;
    });
  }

  _openReservation() {
    print('reservation clicked');
    setState(() {
      reservationOpen = !reservationOpen;
    });
  }

  _rightDrawerToggle() {
    setState(() {
      _rightDrawerOpen = !_rightDrawerOpen;
    });
  }

  _leftDrawerToggle() {
    setState(() {
      _leftDrawerOpen = !_leftDrawerOpen;
    });
  }

  Future<void> _showDialogDate() async {
    try {
      final selectedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now().subtract(Duration(days: 100)),
          lastDate: DateTime.now().add(
            Duration(days: 100),
          ));

      DateTime resultTime = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
      );
      if (resultTime != null)
        setState(() {
          _selectedDate = DateFormat('yyyy/MM/dd').format(resultTime);
        });

      //  = _roundUpTime(resultTime);
      // print('date: ${_dateOnController.text}');
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    print('selectedData: $_selectedDate');
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(), // on tap -> unfocus
      child: Scaffold(
          floatingActionButton: (MediaQuery.of(context).size.width > 800)
              ? ElevatedButton.icon(
                  onPressed: () {
                    if (MediaQuery.of(context).size.width <= 900)
                      widget.toChatFn();
                    else
                      setState(() {
                        chatOpen = !chatOpen;
                      });
                  },
                  icon: Icon(Icons.chat_bubble_outline),
                  label: chatOpen ? Text('Close chat') : Text('Open chat'))
              : SizedBox.shrink(),
          floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
          body: Responsive(
            mobile: Stack(
              children: [
                _WebWaitingConsoleMobile(
                  scrollController: _trackingScrollController,
                  rightDrawerOpenFn: () => _rightDrawerToggle(),
                  leftDrawerOpenFn: () => _leftDrawerToggle(),
                  selectedList: _selectList,
                  selectedDate: _selectedDate,
                  selectDateFn: () => _showDialogDate(),
                  messageFn: (result) {
                    print('messageFn run..');
                    _rightDrawerToggle();
                    setState(() {
                      _messageInfo = result;
                    });
                  },
                ),
                _leftDrawerOpen
                    ? Positioned(
                        left: 0.0,
                        child: Container(
                          width: 300,
                          decoration:
                              new BoxDecoration(color: Colors.green[50]),
                          child: Column(
                            children: [
                              OutlinedButton.icon(
                                  onPressed: () => _leftDrawerToggle(),
                                  icon: Icon(Icons.close),
                                  label: Text('Option Box')),
                              WaitingListOption(
                                selectList: _selectListOption,
                                reserveFn: widget.toReserveFn,
                              ),
                            ],
                          ),
                        ),
                      )
                    : SizedBox.shrink(),
                _rightDrawerOpen
                    ? Positioned(
                        right: 0.0,
                        child: Container(
                            width: 350,
                            decoration:
                                new BoxDecoration(color: Colors.green[50]),
                            child: Column(
                              children: [
                                OutlinedButton.icon(
                                    onPressed: () => _rightDrawerToggle(),
                                    icon: Icon(Icons.close),
                                    label: Text('Message Box')),
                                WaitingListMessages(
                                  messageInfo: _messageInfo,
                                ),
                              ],
                            )),
                      )
                    : SizedBox.shrink(),
              ],
            ),
            desktop: Stack(
              children: [
                // _WebWaitingConsoleDesktop(
                //   scrollController: _trackingScrollController,
                //   selectedListFn: _selectListOption,
                //   selectedList: _selectList,
                //   messageInfo: _messageInfo,
                //   openReservationFn: _openReservation,
                //   selectedDate: _selectedDate,
                //   selectDateFn: () => _showDialogDate(),
                //   messageFn: (result) {
                //     print('messageFn run..');

                //     setState(() {
                //       _messageInfo = result;
                //     });
                //   },
                // ),
                _WebWaitingConsoleDesktop(
                    _trackingScrollController,
                    _selectListOption,
                    _selectList,
                    _messageInfo,
                    _openReservation,
                    _selectedDate,
                    _showDialogDate, (result) {
                  setState(() {
                    _messageInfo = result;
                  });
                }),

                Container(
                  alignment: Alignment.center,
                  child: AnimatedContainer(
                      width: reservationOpen ? 400.0 : 0.0,
                      height: reservationOpen ? 600.0 : 0.0,
                      color: reservationOpen ? Colors.blue[100] : Colors.white,
                      // alignment: reservationOpen
                      //     ? Alignment.bottomRight
                      //     : AlignmentDirectional.topEnd,
                      duration: Duration(seconds: 1),
                      curve: Curves.fastOutSlowIn,
                      child: AddReservationPage(
                          closeReservationFn: _openReservation,
                          userId: FirebaseAuth.instance.currentUser.uid)),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 50, 50),
                  alignment: Alignment.bottomLeft,
                  child: AnimatedContainer(
                    width: chatOpen ? 400.0 : 0.0,
                    height: chatOpen ? 600.0 : 0.0,
                    color: chatOpen ? Colors.grey[100] : Colors.white,
                    alignment: chatOpen
                        ? Alignment.bottomLeft
                        : AlignmentDirectional.topEnd,
                    duration: Duration(seconds: 1),
                    curve: Curves.fastOutSlowIn,
                    child:
                        // ChatNavicontroller(),

                        ChatWithGuestList(
                      advisorId: FirebaseAuth.instance.currentUser.uid,
                      key: PageStorageKey('GuestChatList'),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}

class _WebWaitingConsoleMobile extends StatelessWidget {
  final TrackingScrollController scrollController;
  final Function rightDrawerOpenFn;
  final Function leftDrawerOpenFn;
  final String selectedList;
  final String selectedDate;
  final Function selectDateFn;
  final Function(Map<String, dynamic>) messageFn;

  const _WebWaitingConsoleMobile(
      {Key key,
      @required this.scrollController,
      @required this.rightDrawerOpenFn,
      @required this.leftDrawerOpenFn,
      @required this.selectedList,
      @required this.selectedDate,
      @required this.selectDateFn,
      @required this.messageFn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverToBoxAdapter(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: () => leftDrawerOpenFn(),
                  child: Text('Option Box')),
              Text(
                'Waiting Console',
                textAlign: TextAlign.center,
                style: TextStyle(
                    // backgroundColor: Colors.blueAccent,
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
              // ElevatedButton(
              //     onPressed: () => rightDrawerOpenFn(),
              //     child: Text('Message Box')),
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WaitingTimePage(),
              Spacer(),
              ElevatedButton(
                  onPressed: () {
                    // print('add 10 mins.');
                    JoinWaitingController.instance.setWaitingTime(10);
                  },
                  child: Text('+10')),
              ElevatedButton(
                  onPressed: () {
                    // print('sub 10 mins.');
                    JoinWaitingController.instance.setWaitingTime(-10);
                  },
                  child: Text('-10')),
              Spacer(),
              TextButton(
                  onPressed: () {
                    selectDateFn();
                  },
                  child: Text(selectedDate))
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: WaitingConsolePage(
            selectedDate: selectedDate,
            listOption: selectedList,
            messageFn: messageFn,
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
      ],
    );
  }
}

class _WebWaitingConsoleDesktop extends StatelessWidget {
  final TrackingScrollController scrollController;
  final Function(String) selectedListFn;
  final String selectedList;
  final Map<String, dynamic> messageInfo;
  final Function openReservationFn;
  final String selectedDate;
  final Function selectDateFn;
  final Function(Map<String, dynamic>) messageFn;

  _WebWaitingConsoleDesktop(
      this.scrollController,
      this.selectedListFn,
      this.selectedList,
      this.messageInfo,
      this.openReservationFn,
      this.selectedDate,
      this.selectDateFn,
      this.messageFn);

  @override
  Widget build(BuildContext context) {
    // if (messageInfo['message'] != null) print(messageInfo['message'].length);
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverPadding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
          sliver: SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  flex: 3,
                  child: Text(
                    'Waiting Console',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        // backgroundColor: Colors.blueAccent,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                ),
                Flexible(
                  flex: 8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      WaitingTimePage(),
                      Spacer(),
                      ElevatedButton(
                          onPressed: () {
                            print('add 10 mins.');
                            JoinWaitingController.instance.setWaitingTime(10);
                          },
                          child: Text('+10')),
                      ElevatedButton(
                          onPressed: () {
                            print('sub 10 mins.');
                            JoinWaitingController.instance.setWaitingTime(-10);
                          },
                          child: Text('-10')),
                      Spacer(),
                      TextButton(
                          onPressed: () {
                            selectDateFn();
                          },
                          child: Text(selectedDate))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 2,
                child: WaitingListOption(
                  selectList: selectedListFn,
                  reserveFn: openReservationFn,
                ),
              ),
              Flexible(
                flex: 8,
                child: WaitingConsolePage(
                  selectedDate: selectedDate,
                  listOption: selectedList,
                  messageFn: messageFn,
                ),
              ),
              Flexible(
                flex: 3,
                child:
                    // (messageInfo == null || messageInfo['message'].length == 0)
                    // ? Text('Message')
                    // :
                    WaitingListMessages(
                  messageInfo: messageInfo,
                ),
              )
            ],
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
      ],
    );
  }
}
