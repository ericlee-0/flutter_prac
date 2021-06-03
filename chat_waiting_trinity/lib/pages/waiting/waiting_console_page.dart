import 'package:chat_waiting_trinity/widgets/waiting/hashtag_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../controllers/waiting_list_controller.dart';
import '../../controllers/join_waiting_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../widgets/waiting/dropdown_input.dart';

class WaitingConsolePage extends StatefulWidget {
  final String listOption;
  final String selectedDate;
  final Function(Map<String, dynamic>) messageFn;

  const WaitingConsolePage(
      {Key key, this.listOption, this.messageFn, this.selectedDate})
      : super(key: key);

  @override
  _WaitingConsolePageState createState() => _WaitingConsolePageState();
}

class _WaitingConsolePageState extends State<WaitingConsolePage>
    with AutomaticKeepAliveClientMixin<WaitingConsolePage> {
  // ** here{
  // String _docId;
  // final String _docId; = widget.sele
  var _guestStatus = 'pending';
  var _guestMessage = 'no message sent';
  bool _tileOpened = false;

  TextEditingController _hastagController = TextEditingController();
  final List<String> _guestStatusList = <String>[
    'pending',
    'waiting',
    'checkedIn',
    'done',
  ];
  final List<String> _guestMessageList = <String>[
    'no message sent',
    'table-ready',
    'table-in 5 mins',
    'table-in 15 mins',
    'reservation cancelled'
  ];
  @override
  void initState() {
    // _docId = widget.selectedDate;
    // TODO: implement initState
    super.initState();
    // print('sled: ${widget.selectedDate.length}');
    // if (widget.selectedDate.length != 0)

    // else
    // _docId = DateFormat('yyyy/MM/dd').format(DateTime.now());
  }

  Widget _waitingTime(Timestamp reservAt) {
    var now = DateTime.now();
    // var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    DateTime dataTime = reservAt.toDate();
    var diff = now.difference(dataTime);
    // print(diff);
    var time = '';

    if (diff.inSeconds <= 0) {
      time = DateFormat('HH:mm').format(reservAt.toDate());
    } else if (diff.inSeconds > 0 && diff.inMinutes == 0 ||
        diff.inMinutes > 0 && diff.inHours == 0 ||
        diff.inHours > 0 && diff.inDays == 0) {
      if (diff.inHours > 0) {
        time = diff.inHours.toString() + 'h';
      } else if (diff.inMinutes > 0) {
        time = diff.inMinutes.toString() + 'm';
      } else if (diff.inSeconds > 0) {
        time = 'now';
      } else if (diff.inMilliseconds > 0) {
        time = 'now';
      } else if (diff.inMicroseconds > 0) {
        time = 'now';
      } else {
        time = 'now';
      }
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      time = diff.inDays.toString() + 'd ago';
    } else if (diff.inDays > 6) {
      time = (diff.inDays / 7).floor().toString() + 'w ago';
    } else if (diff.inDays > 29) {
      time = (diff.inDays / 30).floor().toString() + 'm ago';
    } else if (diff.inDays > 365) {
      time = '${dataTime.month}-${dataTime.day}-${dataTime.year}';
    }
    return Text(time);
  }

  List<QueryDocumentSnapshot> _listData(dynamic data) {
    if (widget.listOption == 'pending') {
      return WaitingListController.instance.getPendingList(data);
    }
    if (widget.listOption == 'waiting') {
      return WaitingListController.instance.getWaitingList(data);
    }
    if (widget.listOption == 'checkedIn') {
      return WaitingListController.instance.getCheckedInList(data);
    }
    if (widget.listOption == 'done') {
      return WaitingListController.instance.getDoneList(data);
    }
    return WaitingListController.instance.getActiveList(data);
  }

  Future<void> _hastagDialog2(path) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: true, // user must tap button!
        builder: (BuildContext context) {
          return HashtagDialog(
            doAfterConfirmFn: (List result) {
              print(result);
              if (result.length != 0) _upLoadHashtags(path, result);
            },
          );
        });
  }

  _upLoadHashtags(String path, List tags) async {
    print('messagesendFn run...');
    try {
      await FirebaseFirestore.instance.doc(path)
          // .doc(widget.messageInfo['path'])
          .update(
        {
          'hashtags': FieldValue.arrayUnion([...tags]),
        },
      );
    } catch (e) {
      print(e);
    }
    // _messageController.clear();
    // _enteredMessage = '';
  }

  @override
  Widget build(BuildContext context) {
    // print('_docId : $_docId');
    // _docId = widget.selectedDate;
    return Container(
        height: MediaQuery.of(context).size.height * 0.8,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('waiting')
              .doc(widget.selectedDate)
              .collection('list')
              .orderBy('reserveAt')
              .snapshots(),
          builder: (ctx, snapshot) {
            // if (snapshot.connectionState == ConnectionState.waiting) {
            //   return Center(
            //     child: CircularProgressIndicator(),
            //   );
            // }
            if (!snapshot.hasData ||
                snapshot.hasError ||
                snapshot.data.docs.length == 0) {
              return Text('No waiting..');
            }
            var waitingData = snapshot.data.docs;

            waitingData = _listData(waitingData);
            print('streambuilder: ${waitingData.length}');
            return ListView.builder(
              shrinkWrap: true,
              itemCount: waitingData.length,
              itemBuilder: (ctx, index) => ExpansionTile(
                // title:Text('User ${userData[index].documentID}'),
                key: PageStorageKey(waitingData[index].id.toString()),

                maintainState: true,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(waitingData[index]['name'],
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold)),
                    // Text(DateFormat('HH:MM')
                    //     .format(waitingData[index]['reserveAt'].toDate())),
                    _waitingTime(waitingData[index]['reserveAt']),
                  ],
                ),
                leading: CircleAvatar(
                  child: Text(waitingData[index]['people'].toString()),
                  radius: 25,
                ),
                trailing:
                    // Row(
                    //   children: [
                    Text(
                  waitingData[index]['waitingStatus'],
                  style: TextStyle(
                      backgroundColor: Colors.blueAccent,
                      color: Colors.blue[50]),
                ),
                //     _tileOpened
                //         ? Icon(Icons.expand_less)
                //         : Icon(Icons.expand_more)
                //   ],
                // ),

                onExpansionChanged: (val) {
                  // if (val) {
                  //   setState(() {
                  //     _tileOpened = !_tileOpened;
                  //   });

                  // }
                },

                children: [
                  ListTile(
                    // title: Text('Guest Info'),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Reservation# :' +
                                  waitingData[index]['reservationNumber']
                                      .toString()),
                              Text(
                                'Request time is ' +
                                    DateFormat('HH:mm').format(
                                        waitingData[index]['reserveAt']
                                            .toDate()),
                              ),
                              Text('Phone#: ' + waitingData[index]['phone']),
                              Text('Reserved at ' +
                                  waitingData[index]['createdAt']
                                      .toDate()
                                      .toString()),
                              ElevatedButton.icon(
                                  onPressed: () {
                                    print('add hashtags..');
                                    // _hastagDialog2();
                                    _hastagDialog2(
                                        waitingData[index].reference.path);
                                  },
                                  icon: Icon(Icons.add),
                                  label: Text('HashTag')),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            DropdownButton<String>(
                              // isExpanded: true,
                              key: Key('guest_status'),
                              value: _guestStatus,
                              onChanged: (String string) {
                                JoinWaitingController.instance.setStatus(
                                    waitingData[index].reference.path, string);
                                print('onchange string $string');
                                // print(waitingData[index].reference.path);
                                setState(() => _guestStatus = string);
                              },

                              // selectedItemBuilder: (BuildContext context) {
                              //   return _guestStatusList.map<Widget>((String item) {
                              //     print('serlectedItembuilder $item');
                              //     return Text(item);
                              //   }).toList();
                              // },
                              items: _guestStatusList.map((String item) {
                                return DropdownMenuItem<String>(
                                  child: SizedBox(
                                      // width: 200.0,
                                      child: Text('S: $item')),
                                  value: item,
                                );
                              }).toList(),
                              // icon: null,
                            ),
                          ],
                        ),
                      ],
                    ),
                    subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Container(
                              key: PageStorageKey('hashtagscontainer'),
                              height: 50,
                              width: 300,
                              child: waitingData[index]['hashtags'].length == 0
                                  ? Text('Hashtags')
                                  :
                                  // children: [Text('Hashtages')],
                                  ListView.builder(
                                      // shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount:
                                          waitingData[index]['hashtags'].length,
                                      itemBuilder: (context, ind) {
                                        return Text(
                                          '#${waitingData[index]['hashtags'][ind]}',
                                        );
                                      }),
                            ),
                          ),
                          ElevatedButton.icon(
                              onPressed: () {
                                // print('messagescreen open');
                                // print('${waitingData[index].reference.path}');
                                widget.messageFn({
                                  // 'message': waitingData[index]['messages'],
                                  'path': waitingData[index].reference.path
                                });
                              },
                              icon: Icon(Icons.expand_more),
                              label: Text('messages')),
                        ]),

                    onTap: () {
                      // widget.messageFn(waitingData[index]['messages']);
                      // print(waitingData[index].id);
                    },
                  ),
                ],
              ),
            );
          },
        ));
  }

  @override
  bool get wantKeepAlive => true; //
}
