import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class WaitingList extends StatefulWidget {
  // static final routeName = '/waiting-list';
  @override
  _WaitingListState createState() => _WaitingListState();
}

class _WaitingListState extends State<WaitingList> {
  final _docId = DateFormat('yyyy/MM/dd').format(DateTime.now());
  var _guestStatus = 'pending';
  var _guestMessage = 'no message sent';
  final List<String> _guestStatusList = <String>[
    'pending',
    'checked-in',
    'seated',
    'removed'
  ];
  final List<String> _guestMessageList = <String>[
    'no message sent',
    'table-ready',
    'table-in 5 mins',
    'table-in 15 mins',
    'reservation cancelled'
  ];

  Widget _waitingTime(String reservAt) {
    var now = DateTime.now();
    // var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    DateTime dataTime = DateFormat('yyyy/MM/dd HH:mm').parse(reservAt);
    var diff = now.difference(dataTime);
    print(diff);
    var time = '';

    if (diff.inSeconds <= 0 ||
        diff.inSeconds > 0 && diff.inMinutes == 0 ||
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

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('waiting')
          .doc(_docId)
          .collection('list')
          // .orderBy('forWhen', descending: true)
          .snapshots(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final waitingData = snapshot.data.documents;
        print('streambuilder: ${waitingData.length}');
        return SingleChildScrollView(
          child: Container(
           
              child: Column(
                children: [
                  // ListTile(title: Text('Current waiting ')),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: waitingData.length,
                    itemBuilder: (ctx, index) => ExpansionTile(
                      // title:Text('User ${userData[index].documentID}'),
                      key: ValueKey(waitingData[index].documentID.toString()),
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
                      trailing: Text(
                        _guestStatus,
                        style: TextStyle(backgroundColor: Colors.blueAccent),
                      ),
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
                                          waitingData[index]['reserveAt']
                                              .substring(waitingData[index]
                                                          ['reserveAt']
                                                      .length -
                                                  5),
                                    ),
                                    Text(
                                        'Phone#: ' + waitingData[index]['phone']),
                                    Text('Reserved at ' +
                                        waitingData[index]['createdAt']
                                            .toDate()
                                            .toString()),
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
                                    onChanged: (String string) =>
                                        setState(() => _guestStatus = string),
                                    selectedItemBuilder: (BuildContext context) {
                                      return _guestStatusList
                                          .map<Widget>((String item) {
                                        return Text(item);
                                      }).toList();
                                    },
                                    items: _guestStatusList.map((String item) {
                                      return DropdownMenuItem<String>(
                                        child: SizedBox(
                                            // width: 200.0,
                                            child: Text('Status $item')),
                                        value: item,
                                      );
                                    }).toList(),
                                    // icon: null,
                                  ),
                                  DropdownButton<String>(
                                    // isExpanded: true,
                                    key: Key('guest_message'),
                                    value: _guestMessage,
                                    onChanged: (String string) =>
                                        setState(() => _guestMessage = string),
                                    selectedItemBuilder: (BuildContext context) {
                                      return _guestMessageList
                                          .map<Widget>((String item2) {
                                        return Text(item2);
                                      }).toList();
                                    },
                                    items: _guestMessageList.map((String item2) {
                                      return DropdownMenuItem<String>(
                                        child: SizedBox(
                                            // width: 200.0,
                                            child: Text('M: $item2')),
                                        value: item2,
                                      );
                                    }).toList(),
                                    // icon: null,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          onTap: () {
                            print(waitingData[index].documentID);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              
            ),
          ),
        );
      },
    );
  }
}
