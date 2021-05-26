import 'package:chat_waiting_trinity/controllers/join_waiting_controller.dart';
import 'package:flutter/material.dart';

class CancelDialog extends StatefulWidget {
  // final bool isWaiting;
  final result;
  final Function(bool) doAfterConfirmFn;

  const CancelDialog({Key key, this.result, this.doAfterConfirmFn})
      : super(key: key);

  @override
  _CancelDialogState createState() => _CancelDialogState();
}

class _CancelDialogState extends State<CancelDialog> {
  List<bool> _isChecked = [false];
  bool _canUpload = false;
  // bool _confirmButtonEnabled = false;
  List<String> _textsForCancel = [
    "I would like to cancel it and make new one ",
  ];

  @override
  Widget build(BuildContext context) {
    // print(widget.result[0].reference.path);
    print(widget.result is List);
    print(widget.result.length);
    // print(widget.result['name']);
    // print(widget.result[2].length);
    return AlertDialog(
      title: Text('Your Pre-Reservation Exists'),
      content: Container(
        width: 300,
        height: 450,
        child: Column(
          // mainAxisSize: MainAxisSize.mi,
          children: [
            Expanded(
                child: Column(
                    children: widget.result.map<Widget>((entry) {
              var w = Expanded(
                child: Column(children: [
                  Text('Reservation Number: ${entry['reservationNumber']}'),
                  Text('Name:               ${entry['name']}'),
                  Text('Time:               ${entry['reserveAt'].toDate()}'),
                  Text('Phone:              ${entry['phone']}'),
                  Text('Number of Guests:   ${entry['people']}'),
                ]),
              );

              return w;
            }).toList())
                //       : Column(
                //           children: [
                //             Text(
                //                 'Reservation Number: ${widget.result['reservationNumber']}'),
                //             Text('Name:               ${widget.result['name']}'),
                //             Text(
                //                 'Time:               ${widget.result['reserveAt']}'),
                //             Text('Phone:              ${widget.result['phone']}'),
                //             Text('Number of Guests:   ${widget.result['people']}'),
                //           ],
                //         ),
                ),
            Expanded(
              child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(8.0),
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: _textsForCancel.length,
                      itemBuilder: (_, index) {
                        return CheckboxListTile(
                          title: Text(_textsForCancel[index]),
                          value: _isChecked[index],
                          onChanged: (val) {
                            setState(() {
                              _isChecked[index] = val;
                              _canUpload = true;
                              for (var item in _isChecked) {
                                if (item == false) {
                                  _canUpload = false;
                                }
                              }
                            });
                          },
                        );
                      },
                    ),
                  ]),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        SizedBox(
            width: 350,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  // color: Colors.blue,
                  onPressed: _canUpload
                      ? () {
                          // print("upload");
                          widget.result.forEach((e) {
                            JoinWaitingController.instance
                                .setStatus(e.reference.path, 'canceled');
                          });

                          Navigator.of(context).pop();
                          widget.doAfterConfirmFn(true);
                        }
                      : null,
                  child: _canUpload
                      ? Text('Cancel')
                      : Text('Check the conditions'),
                ),
                ElevatedButton(
                  // color: Colors.blue,
                  onPressed: () {
                    // print("back");
                    Navigator.of(context).pop();
                    widget.doAfterConfirmFn(false);
                  },

                  child: Text('Back'),
                ),
              ],
            ))
      ],
    );
  }
}

// switch (await showDialog<Department>(
//         context: context,
//         builder: (BuildContext context) {
//           return SimpleDialog(
//             title: const Text('Reservation Processing'),
//             children: <Widget>[
//               SimpleDialogOption(
//                 onPressed: () {
//                   Navigator.pop(context, Department.treasury);
//                 },
//                 child: const Text('Treasury department'),
//               ),
//               SimpleDialogOption(
//                 onPressed: () {
//                   Navigator.pop(context, Department.state);
//                 },
//                 child: const Text('State department'),
//               ),
//             ],
//           );
//         })) {
//       case Department.treasury:
//         // Let's go.
//         // ...
//         break;
//       case Department.state:
//         // ...
//         break;
//       default:
//         // dialog dismissed
//         break;
//     }
