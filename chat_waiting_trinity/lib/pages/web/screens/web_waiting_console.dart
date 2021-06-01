import 'package:chat_waiting_trinity/controllers/join_waiting_controller.dart';
import 'package:chat_waiting_trinity/widgets/waiting/waiting_list_options.dart';

import 'package:firebase_auth/firebase_auth.dart';
import '../../../pages/waiting/waiting_console_page.dart';
import '../../../pages/web/widgets/widgets.dart';
import 'package:flutter/material.dart';
import '../../waiting/waiting_time_page.dart';
import '../../../widgets/waiting/waiting_list_messages.dart';
import '../../../controllers/chatNaviController.dart';
import '../../../pages/waiting/stepper_test.dart';

class WebWaitingConsole extends StatefulWidget {
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(), // on tap -> unfocus
      child: Scaffold(
          floatingActionButton: (MediaQuery.of(context).size.width > 800)
              ? ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      chatOpen = !chatOpen;
                    });
                  },
                  icon: Icon(Icons.chat_bubble_outline),
                  label: chatOpen ? Text('Close chat') : Text('Open chat'))
              : SizedBox.shrink(),
          floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
          body: Responsive(
            mobile: _WebWaitingConsoleMobile(
              scrollController: _trackingScrollController,
            ),
            desktop: Stack(
              children: [
                _WebWaitingConsoleDesktop(
                  scrollController: _trackingScrollController,
                  selectedListFn: _selectListOption,
                  selectedList: _selectList,
                  // messageList: _messageList,
                  messageInfo: _messageInfo,
                  openReservation: _openReservation,
                  messageFn: (result) {
                    print('messageFn run..');

                    setState(() {
                      // _messageList = result['message'];
                      _messageInfo = result;
                    });
                  },
                ),
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
                      child: StepperTest(
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
                    child: ChatNavicontroller(),
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

  const _WebWaitingConsoleMobile({Key key, this.scrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _WebWaitingConsoleDesktop extends StatelessWidget {
  final TrackingScrollController scrollController;
  final Function(String) selectedListFn;
  final Function(Map<String, dynamic>) messageFn;
  final String selectedList;
  // final List<dynamic> messageList;
  final Map<String, dynamic> messageInfo;
  final Function openReservation;

  const _WebWaitingConsoleDesktop(
      {Key key,
      this.scrollController,
      this.selectedListFn,
      this.selectedList,
      this.messageFn,
      this.messageInfo,
      // this.messageList,
      this.openReservation})
      : super(key: key);

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
                  reserveFn: openReservation,
                ),
              ),
              Flexible(
                flex: 8,
                child: WaitingConsolePage(
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
        SliverPadding(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
          sliver: SliverToBoxAdapter(
            child: Text('Footer'),
          ),
        )
      ],
    );
  }
}
