import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WaitingListMessages extends StatefulWidget {
  // final List messageList;
  final Map<String, dynamic> messageInfo;

  const WaitingListMessages({Key key, this.messageInfo}) : super(key: key);

  @override
  _WaitingListMessagesState createState() => _WaitingListMessagesState();
}

class _WaitingListMessagesState extends State<WaitingListMessages> {
  final _messageController = TextEditingController();
  // var _enteredMessage = '';
  var _guestMessage = 'no message sent';
  final List<String> _guestMessageList = <String>[
    'no message sent',
    'Your table is ready',
    'Your table will be ready in 5 mins',
    'your table will be ready in 15 mins',
    'reservation cancelled'
  ];

  _sendMessage() async {
    print('messagesendFn run...');
    try {
      await FirebaseFirestore.instance.doc(widget.messageInfo['path'])
          // .doc(widget.messageInfo['path'])
          .update(
        {
          'messages': FieldValue.arrayUnion([
            {
              'sender': 'admin',
              'message': _messageController.text.trim(),
              'at': Timestamp.now()
            }
          ]),
        },
      );
    } catch (e) {
      print(e);
    }
    _messageController.clear();
    // _enteredMessage = '';
  }

  @override
  Widget build(BuildContext context) {
    // final data = widget.messageInfo;
    print(
      MediaQuery.of(context).size.height / 0.5,
    );
    return Container(
      height: 600,
      // width: 300,
      padding: EdgeInsets.fromLTRB(10, 50, 10, 0),
      child: Column(
        children: [
          (widget.messageInfo == null)
              ? Text('No message sent')
              : Expanded(
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          // .collection('waiting')
                          .doc(widget.messageInfo['path'])
                          .snapshots(),
                      builder: (ctx, snapshot) {
                        if (!snapshot.hasData ||
                            snapshot.hasError ||
                            snapshot.data.data()['messages'].length == 0) {
                          return Text('No messages..');
                        }
                        var messageData = snapshot.data.get('messages');
                        return ListView.builder(
                          // shrinkWrap: true,
                          itemCount: messageData.length,
                          itemBuilder: (BuildContext context, int index) {
                            // print(messageData.length);
                            return Container(
                              // height: 75,
                              // color: Colors.amber[colorCodes[index]],
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: Stack(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        messageData[index]['sender'] == 'admin'
                                            ? MainAxisAlignment.end
                                            : MainAxisAlignment.start,
                                    children: [
                                      // isSelf? Text(formattedTime): null,
                                      Container(
                                        decoration: BoxDecoration(
                                          color: messageData[index]['sender'] ==
                                                  'admin'
                                              ? Colors.grey[400]
                                              : Colors.green[600],
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(12),
                                            topRight: Radius.circular(12),
                                            bottomLeft: messageData[index]
                                                        ['sender'] !=
                                                    'admin'
                                                ? Radius.circular(0)
                                                : Radius.circular(12),
                                            bottomRight: messageData[index]
                                                        ['sender'] ==
                                                    'admin'
                                                ? Radius.circular(0)
                                                : Radius.circular(12),
                                          ),
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                (2 / 13),
                                        padding: EdgeInsets.symmetric(
                                          vertical: 6,
                                          horizontal: 8,
                                        ),
                                        // ),
                                        // margin: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                                        child: Column(
                                          crossAxisAlignment: messageData[index]
                                                      ['sender'] ==
                                                  'admin'
                                              ? CrossAxisAlignment.end
                                              : CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              messageData[index]['message'],
                                              style: TextStyle(
                                                color: messageData[index]
                                                            ['sender'] ==
                                                        'admin'
                                                    ? Colors.white
                                                    : Colors.white,
                                              ),
                                              textAlign: messageData[index]
                                                          ['sender'] ==
                                                      'admin'
                                                  ? TextAlign.end
                                                  : TextAlign.start,
                                            ),
                                            Text(
                                              '${messageData[index]['at'].toDate()}',
                                              style: TextStyle(fontSize: 7),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                                clipBehavior: Clip.hardEdge,
                              ),
                            );
                          },
                        );
                      }),
                ),
          // Text('message drop down example'),
          DropdownButton<String>(
            // isExpanded: true,
            key: Key('guest_message'),
            isExpanded: true,
            value: _guestMessage,
            onChanged: (String string) => setState(() {
              _guestMessage = string;
              _messageController.text = string;
            }),
            selectedItemBuilder: (BuildContext context) {
              return _guestMessageList.map<Widget>((String item2) {
                return Text(item2);
              }).toList();
            },
            items: _guestMessageList.map((String item2) {
              return DropdownMenuItem<String>(
                child: SizedBox(
                    // width: 200.0,
                    child: Text(item2)),
                value: item2,
              );
            }).toList(),
            // icon: null,
          ),

          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _messageController,
                  textCapitalization: TextCapitalization.sentences,
                  autocorrect: true,
                  enableSuggestions: true,
                  decoration: InputDecoration(labelText: 'Send a message...'),
                  onChanged: (value) {
                    // setState(() {
                    //   _enteredMessage = value;
                    // });
                  },
                ),
              ),
              IconButton(
                color: Colors.blue[400],
                icon: Icon(Icons.send),
                onPressed: _messageController.text.trim().isEmpty
                    ? null
                    : () => _sendMessage(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
